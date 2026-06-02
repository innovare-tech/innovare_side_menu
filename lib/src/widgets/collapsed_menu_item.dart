import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/side_menu_item.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
import 'badge_widget.dart';
import 'simple_menu_item.dart';

class CollapsedMenuItem extends StatefulWidget {
  final InnovareSideMenuItem item;
  final InnovareSideMenuStyle style;
  final bool Function(String permission)? permissionChecker;

  const CollapsedMenuItem({
    super.key,
    required this.item,
    required this.style,
    this.permissionChecker,
  });

  @override
  State<CollapsedMenuItem> createState() => _CollapsedMenuItemState();
}

class _CollapsedMenuItemState extends State<CollapsedMenuItem> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isPopupOpen = false;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isPopupOpen = false;
    setState(() {});
  }

  void _showSubItemsPopup() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => _SubItemsPopup(
        link: _layerLink,
        item: widget.item,
        style: widget.style,
        permissionChecker: widget.permissionChecker,
        onClose: _removeOverlay,
      ),
    );
    overlay.insert(_overlayEntry!);
    setState(() {
      _isPopupOpen = true;
    });
  }

  bool _hasActiveSubItem(InnovareSideMenuItem item) {
    final subs = item.subItems;
    if (subs == null) return false;
    for (final sub in subs) {
      if (sub.isActive || _hasActiveSubItem(sub)) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final hasSubItems =
        widget.item.subItems != null && widget.item.subItems!.isNotEmpty;
    // A collapsed parent reflects its section: it reads as active when it (or
    // any descendant) is active, and while its sub-items popup is open.
    final isActive = widget.item.isActive ||
        _hasActiveSubItem(widget.item) ||
        (hasSubItems && _isPopupOpen);

    final decoration = isActive
        ? widget.style.collapsedActiveItemDecoration
        : widget.style.collapsedInactiveItemDecoration;

    final iconColor = isActive
        ? widget.style.activeItemIconColor
        : widget.style.inactiveItemIconColor;

    final iconSize =
        widget.style.collapsedIconSize ?? widget.style.itemIconSize;

    void handleTap() {
      if (widget.style.enableHaptics) HapticFeedback.selectionClick();
      if (hasSubItems) {
        if (_isPopupOpen) {
          _removeOverlay();
        } else {
          _showSubItemsPopup();
        }
      } else {
        widget.item.onTap?.call();
      }
    }

    final onTap =
        (!hasSubItems && widget.item.onTap == null) ? null : handleTap;

    return Semantics(
      label: widget.item.accessibleLabel,
      button: true,
      selected: isActive,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Tooltip(
          message: widget.item.tooltip ?? widget.item.title,
          waitDuration: Duration(milliseconds: 500),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: decoration,
            child: InkWell(
              onTap: onTap,
              borderRadius: widget.style.itemBorderRadius,
              hoverColor: widget.style.itemHoverColor,
              child: Padding(
                padding: widget.style.collapsedItemPadding ??
                    EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: _buildIcon(iconColor, iconSize),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color? iconColor, double? iconSize) {
    final iconWidget = Icon(
      widget.item.icon,
      color: iconColor,
      size: iconSize,
    );

    if (widget.item.badge == null) {
      return iconWidget;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          top: widget.style.badgeOffset?.top ?? -4,
          right: widget.style.badgeOffset?.right ?? -4,
          child: BadgeWidget(badge: widget.item.badge!, style: widget.style),
        ),
      ],
    );
  }
}

class _SubItemsPopup extends StatelessWidget {
  final LayerLink link;
  final InnovareSideMenuItem item;
  final InnovareSideMenuStyle style;
  final bool Function(String permission)? permissionChecker;
  final VoidCallback onClose;

  const _SubItemsPopup({
    required this.link,
    required this.item,
    required this.style,
    this.permissionChecker,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          offset: Offset(4, 0),
          child: Material(
            elevation: 8,
            borderRadius: style.itemBorderRadius ?? BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 180,
                maxWidth: 280,
              ),
              decoration: BoxDecoration(
                color: style.decoration?.color ??
                    Theme.of(context).colorScheme.surface,
                borderRadius:
                    style.itemBorderRadius ?? BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: style.inactiveItemTextColor,
                        fontSize: style.itemFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(height: 1),
                  for (var subItem in item.subItems!)
                    if (shouldShowItem(subItem, permissionChecker))
                      SimpleMenuItem(
                        item: subItem.copyWith(
                          onTap: () {
                            subItem.onTap?.call();
                            onClose();
                          },
                        ),
                        style: style,
                        isSubItem: true,
                      ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
