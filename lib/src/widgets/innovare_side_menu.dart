import 'package:flutter/material.dart';

import '../models/side_menu_item.dart';
import '../models/side_menu_mode.dart';
import '../models/side_menu_section.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
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
  }) : style = style ?? const InnovareSideMenuStyle();

  @override
  Widget build(BuildContext context) {
    // TODO: task 6 will implement collapsed mode
    return _buildExpanded();
  }

  Widget _buildExpanded() {
    return Container(
      width: style.width,
      height: double.infinity,
      padding: style.padding,
      decoration: style.decoration,
      child: Column(
        children: [
          if (header != null)
            Container(
              padding: style.headerPadding,
              decoration: style.headerDecoration ??
                  (style.headerDivider != null
                      ? BoxDecoration(
                          border: Border(bottom: style.headerDivider!),
                        )
                      : null),
              child: header,
            ),
          Expanded(
            child: ListView(
              padding: style.sectionPadding,
              physics: scrollPhysics,
              children: [
                for (var section in sections) ...[
                  if (shouldShowSection(section, permissionChecker)) ...[
                    if (section.title != null)
                      Padding(
                        padding: style.sectionTitlePadding ?? EdgeInsets.zero,
                        child: Text(
                          section.title!,
                          style: style.sectionTitleStyle,
                        ),
                      ),
                    for (var item in section.items)
                      if (shouldShowItem(item, permissionChecker))
                        _buildMenuItem(item),
                  ],
                ],
              ],
            ),
          ),
          if (footer != null)
            Container(
              padding: style.footerPadding,
              decoration: style.footerDecoration ??
                  (style.footerDivider != null
                      ? BoxDecoration(
                          border: Border(top: style.footerDivider!),
                        )
                      : null),
              child: footer,
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(InnovareSideMenuItem item) {
    final hasSubItems = item.subItems != null && item.subItems!.isNotEmpty;

    if (hasSubItems) {
      return ExpandableMenuItem(
        item: item,
        style: style,
        currentRoute: currentRoute,
        permissionChecker: permissionChecker,
      );
    }

    return SimpleMenuItem(item: item, style: style, isSubItem: false);
  }
}
