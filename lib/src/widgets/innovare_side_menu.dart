import 'package:flutter/material.dart';

import '../models/side_menu_item.dart';
import '../models/side_menu_mode.dart';
import '../models/side_menu_section.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
import 'collapsed_menu_item.dart';
import 'expandable_menu_item.dart';
import 'simple_menu_item.dart';

/// A declarative, customizable side menu widget for Flutter.
///
/// Displays a vertical navigation menu with sections, hierarchical items,
/// badges, and permission-based filtering. Supports both [InnovareSideMenuMode.expanded]
/// and [InnovareSideMenuMode.collapsed] modes with animated transitions.
///
/// {@tool snippet}
/// ```dart
/// InnovareSideMenu(
///   style: InnovareSideMenuThemes.darkDefault(),
///   sections: [
///     InnovareSideMenuSection(
///       title: 'MAIN',
///       items: [
///         InnovareSideMenuItem(
///           id: 'home',
///           icon: Icons.home,
///           title: 'Home',
///           isActive: true,
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
class InnovareSideMenu extends StatelessWidget {
  /// The list of sections to display in the menu.
  final List<InnovareSideMenuSection> sections;

  /// Visual styling configuration. Defaults to [InnovareSideMenuStyle] with
  /// default values if not provided.
  final InnovareSideMenuStyle style;

  /// The current route for matching active items by route.
  final String? currentRoute;

  /// Custom scroll physics for the menu's [ListView].
  final ScrollPhysics? scrollPhysics;

  /// Callback to determine if an item with a given permission should be shown.
  ///
  /// If `null`, all items are visible regardless of their [InnovareSideMenuItem.permission].
  final bool Function(String permission)? permissionChecker;

  /// Widget displayed at the top of the menu in expanded mode.
  final Widget? header;

  /// Widget displayed at the bottom of the menu in expanded mode.
  final Widget? footer;

  /// Widget displayed at the top of the menu in collapsed mode.
  final Widget? collapsedHeader;

  /// Widget displayed at the bottom of the menu in collapsed mode.
  final Widget? collapsedFooter;

  /// The current display mode. Defaults to [InnovareSideMenuMode.expanded].
  final InnovareSideMenuMode mode;

  /// Duration of the animated transition between expanded and collapsed modes.
  ///
  /// Defaults to `Duration(milliseconds: 300)`.
  final Duration? modeTransitionDuration;

  /// Creates an [InnovareSideMenu].
  ///
  /// The [sections] parameter is required.
  const InnovareSideMenu({
    super.key,
    required this.sections,
    InnovareSideMenuStyle? style,
    this.currentRoute,
    this.scrollPhysics,
    this.permissionChecker,
    this.header,
    this.footer,
    this.collapsedHeader,
    this.collapsedFooter,
    this.mode = InnovareSideMenuMode.expanded,
    this.modeTransitionDuration,
  }) : style = style ?? const InnovareSideMenuStyle();

  bool get _isCollapsed => mode == InnovareSideMenuMode.collapsed;

  Duration get _transitionDuration =>
      modeTransitionDuration ?? Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final targetWidth = _isCollapsed ? style.collapsedWidth : style.width;

    return AnimatedContainer(
      duration: _transitionDuration,
      curve: Curves.easeInOut,
      width: targetWidth,
      height: double.infinity,
      padding: style.padding,
      decoration: style.decoration,
      clipBehavior: style.decoration != null ? Clip.hardEdge : Clip.none,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Switch content based on actual animated width, not the boolean flag,
          // to prevent overflow during the width transition animation.
          final widthThreshold = (style.width + style.collapsedWidth) / 2;
          final showCollapsed = constraints.maxWidth < widthThreshold;

          final activeHeader = showCollapsed ? collapsedHeader : header;
          final activeFooter = showCollapsed ? collapsedFooter : footer;

          return Column(
            children: [
              if (activeHeader != null)
                Container(
                  padding: style.headerPadding,
                  decoration: style.headerDecoration ??
                      (style.headerDivider != null
                          ? BoxDecoration(
                              border: Border(bottom: style.headerDivider!),
                            )
                          : null),
                  child: activeHeader,
                ),
              Expanded(
                child: ListView(
                  padding: style.sectionPadding,
                  physics: scrollPhysics,
                  children: [
                    for (var i = 0; i < sections.length; i++) ...[
                      if (shouldShowSection(
                          sections[i], permissionChecker)) ...[
                        if (showCollapsed) ...[
                          if (i > 0) Divider(height: 1),
                        ] else ...[
                          if (sections[i].title != null)
                            Padding(
                              padding:
                                  style.sectionTitlePadding ?? EdgeInsets.zero,
                              child: Text(
                                sections[i].title!,
                                style: style.sectionTitleStyle,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                            ),
                        ],
                        for (var item in sections[i].items)
                          if (shouldShowItem(item, permissionChecker))
                            _buildMenuItem(item, showCollapsed),
                      ],
                    ],
                  ],
                ),
              ),
              if (activeFooter != null)
                Container(
                  padding: style.footerPadding,
                  decoration: style.footerDecoration ??
                      (style.footerDivider != null
                          ? BoxDecoration(
                              border: Border(top: style.footerDivider!),
                            )
                          : null),
                  child: activeFooter,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(InnovareSideMenuItem item, bool showCollapsed) {
    // Auto-match: se currentRoute corresponde ao item.route, marcar como active
    final resolvedItem = _resolveActiveState(item);

    if (showCollapsed) {
      return CollapsedMenuItem(
        item: resolvedItem,
        style: style,
        permissionChecker: permissionChecker,
      );
    }

    final hasSubItems = resolvedItem.subItems != null && resolvedItem.subItems!.isNotEmpty;

    if (hasSubItems) {
      return ExpandableMenuItem(
        item: resolvedItem,
        style: style,
        currentRoute: currentRoute,
        permissionChecker: permissionChecker,
      );
    }

    return SimpleMenuItem(
      item: resolvedItem,
      style: style,
      isSubItem: false,
      isCollapsed: showCollapsed,
      transitionDuration: _transitionDuration,
    );
  }

  InnovareSideMenuItem _resolveActiveState(InnovareSideMenuItem item) {
    if (currentRoute == null || currentRoute!.isEmpty) return item;
    if (item.route == null) return item;

    final isMatch = currentRoute == item.route ||
        currentRoute!.startsWith('${item.route}/');

    if (isMatch && !item.isActive) {
      return item.copyWith(isActive: true);
    }
    if (!isMatch && item.isActive) {
      return item.copyWith(isActive: false);
    }

    return item;
  }
}
