import 'package:flutter/material.dart';

import '../models/side_menu_item.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
import 'simple_menu_item.dart';

class ExpandableMenuItem extends StatefulWidget {
  final InnovareSideMenuItem item;
  final InnovareSideMenuStyle style;
  final String? currentRoute;
  final bool Function(String permission)? permissionChecker;

  const ExpandableMenuItem({
    super.key,
    required this.item,
    required this.style,
    this.currentRoute,
    this.permissionChecker,
  });

  @override
  State<ExpandableMenuItem> createState() => _ExpandableMenuItemState();
}

class _ExpandableMenuItemState extends State<ExpandableMenuItem>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration:
          widget.style.expandAnimationDuration ?? Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.style.itemMargin,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isExpanded
                  ? widget.style.itemHoverColor
                  : widget.style.inactiveItemDecoration?.color,
              borderRadius: widget.style.itemBorderRadius,
            ),
            child: ListTile(
              leading: widget.item.customLeading ??
                  Container(
                    padding: widget.style.itemIconPadding,
                    decoration: widget.style.inactiveItemIconDecoration,
                    child: Icon(
                      widget.item.icon,
                      color: widget.style.inactiveItemIconColor,
                      size: widget.style.itemIconSize,
                    ),
                  ),
              title: Text(
                widget.item.title,
                style: TextStyle(
                  color: widget.style.inactiveItemTextColor,
                  fontSize: widget.style.itemFontSize,
                  fontWeight: widget.style.inactiveItemFontWeight,
                ),
              ),
              trailing: RotationTransition(
                turns: _rotationAnimation,
                child: Icon(
                  widget.style.expandIcon ?? Icons.expand_more,
                  color: widget.style.expandIconColor,
                  size: widget.style.expandIconSize,
                ),
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  if (isExpanded) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius:
                    widget.style.itemBorderRadius ?? BorderRadius.zero,
              ),
              hoverColor: widget.style.itemHoverColor,
              contentPadding: widget.style.itemPadding,
              dense: true,
            ),
          ),
          AnimatedSize(
            duration: widget.style.expandAnimationDuration ??
                Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Container(
                    margin: EdgeInsets.only(top: 2),
                    padding: EdgeInsets.only(
                      left: widget.style.subItemIndentation ?? 0,
                    ),
                    child: Column(
                      children: widget.item.subItems!
                          .where((subItem) => shouldShowItem(
                              subItem, widget.permissionChecker))
                          .map(
                            (subItem) => SimpleMenuItem(
                              item: subItem,
                              style: widget.style,
                              isSubItem: true,
                            ),
                          )
                          .toList(),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
