import 'package:flutter/material.dart';

import '../models/side_menu_item.dart';
import '../styles/side_menu_style.dart';

class SimpleMenuItem extends StatelessWidget {
  final InnovareSideMenuItem item;
  final InnovareSideMenuStyle style;
  final bool isSubItem;

  const SimpleMenuItem({
    super.key,
    required this.item,
    required this.style,
    required this.isSubItem,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive;

    final padding = isSubItem ? style.subItemPadding : style.itemPadding;
    final margin = isSubItem ? style.subItemMargin : style.itemMargin;
    final borderRadius =
        isSubItem ? style.subItemBorderRadius : style.itemBorderRadius;
    final iconSize = isSubItem ? style.subItemIconSize : style.itemIconSize;
    final fontSize = isSubItem ? style.subItemFontSize : style.itemFontSize;

    final decoration = isActive
        ? (isSubItem
            ? style.activeSubItemDecoration
            : style.activeItemDecoration)
        : (isSubItem
            ? style.inactiveSubItemDecoration
            : style.inactiveItemDecoration);

    final textColor = isActive
        ? (isSubItem
            ? style.activeSubItemTextColor
            : style.activeItemTextColor)
        : (isSubItem
            ? style.inactiveSubItemTextColor
            : style.inactiveItemTextColor);

    final iconColor = isActive
        ? (isSubItem
            ? style.activeSubItemIconColor
            : style.activeItemIconColor)
        : (isSubItem
            ? style.inactiveSubItemIconColor
            : style.inactiveItemIconColor);

    final iconDecoration = isActive
        ? style.activeItemIconDecoration
        : style.inactiveItemIconDecoration;

    final fontWeight = isActive
        ? style.activeItemFontWeight
        : style.inactiveItemFontWeight;

    return Container(
      margin: margin,
      decoration: decoration,
      child: ListTile(
        leading: item.customLeading ??
            Container(
              padding: isSubItem ? EdgeInsets.all(6) : style.itemIconPadding,
              decoration: isSubItem ? null : iconDecoration,
              child: Icon(item.icon, color: iconColor, size: iconSize),
            ),
        title: Text(
          item.title,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        trailing: item.trailing,
        onTap: item.onTap,
        hoverColor: style.itemHoverColor,
        contentPadding: padding,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
      ),
    );
  }
}
