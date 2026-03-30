import 'package:flutter/material.dart';

import '../models/side_menu_item.dart';
import '../models/side_menu_mode.dart';
import '../models/side_menu_section.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
import 'collapsed_menu_item.dart';
import 'expandable_menu_item.dart';
import 'simple_menu_item.dart';

class InnovareSideMenu extends StatelessWidget {
  final List<InnovareSideMenuSection> sections;
  final InnovareSideMenuStyle style;
  final String? currentRoute;
  final ScrollPhysics? scrollPhysics;
  final bool Function(String permission)? permissionChecker;
  final Widget? header;
  final Widget? footer;
  final Widget? collapsedHeader;
  final Widget? collapsedFooter;
  final InnovareSideMenuMode mode;
  final Duration? modeTransitionDuration;

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

    final activeHeader = _isCollapsed ? collapsedHeader : header;
    final activeFooter = _isCollapsed ? collapsedFooter : footer;

    return AnimatedContainer(
      duration: _transitionDuration,
      curve: Curves.easeInOut,
      width: targetWidth,
      height: double.infinity,
      padding: style.padding,
      decoration: style.decoration,
      child: Column(
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
                  if (shouldShowSection(sections[i], permissionChecker)) ...[
                    if (_isCollapsed) ...[
                      if (i > 0) Divider(height: 1),
                    ] else ...[
                      if (sections[i].title != null)
                        Padding(
                          padding:
                              style.sectionTitlePadding ?? EdgeInsets.zero,
                          child: Text(
                            sections[i].title!,
                            style: style.sectionTitleStyle,
                          ),
                        ),
                    ],
                    for (var item in sections[i].items)
                      if (shouldShowItem(item, permissionChecker))
                        _buildMenuItem(item),
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
      ),
    );
  }

  Widget _buildMenuItem(InnovareSideMenuItem item) {
    if (_isCollapsed) {
      return CollapsedMenuItem(
        item: item,
        style: style,
        permissionChecker: permissionChecker,
      );
    }

    final hasSubItems = item.subItems != null && item.subItems!.isNotEmpty;

    if (hasSubItems) {
      return ExpandableMenuItem(
        item: item,
        style: style,
        currentRoute: currentRoute,
        permissionChecker: permissionChecker,
      );
    }

    return SimpleMenuItem(
      item: item,
      style: style,
      isSubItem: false,
      isCollapsed: _isCollapsed,
      transitionDuration: _transitionDuration,
    );
  }
}
