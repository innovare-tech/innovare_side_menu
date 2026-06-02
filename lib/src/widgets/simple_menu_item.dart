import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/side_menu_item.dart';
import '../styles/side_menu_style.dart';
import 'badge_widget.dart';

class SimpleMenuItem extends StatelessWidget {
  final InnovareSideMenuItem item;
  final InnovareSideMenuStyle style;
  final bool isSubItem;
  final bool isCollapsed;
  final Duration transitionDuration;

  const SimpleMenuItem({
    super.key,
    required this.item,
    required this.style,
    required this.isSubItem,
    this.isCollapsed = false,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final stateDuration =
        reduceMotion ? Duration.zero : style.stateAnimationDuration;

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

    Widget tile = AnimatedContainer(
      duration: stateDuration,
      curve: Curves.easeOutCubic,
      margin: margin,
      decoration: decoration,
      child: ListTile(
        leading: item.customLeading ??
            _buildLeading(
              iconColor: iconColor,
              iconSize: iconSize,
              iconDecoration: iconDecoration,
              duration: stateDuration,
            ),
        title: AnimatedOpacity(
          opacity: isCollapsed ? 0.0 : 1.0,
          duration: transitionDuration,
          child: AnimatedDefaultTextStyle(
            duration: stateDuration,
            curve: Curves.easeOutCubic,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        trailing: isCollapsed ? null : item.trailing,
        onTap: item.onTap,
        hoverColor: style.itemHoverColor,
        contentPadding: padding,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
      ),
    );

    if (isCollapsed) {
      tile = Tooltip(
        message: item.tooltip ?? item.title,
        waitDuration: Duration(milliseconds: 500),
        child: tile,
      );
    }

    return Semantics(
      label: item.semanticLabel ?? item.title,
      button: true,
      selected: item.isActive,
      child: _FocusableItem(
        onTap: item.onTap,
        style: style,
        child: tile,
      ),
    );
  }

  Widget _buildLeading({
    required Color? iconColor,
    required double? iconSize,
    required BoxDecoration? iconDecoration,
    required Duration duration,
  }) {
    // TweenAnimationBuilder requires a non-null tween end, so only animate the
    // color when one is provided; otherwise fall back to the ambient icon color.
    final Widget iconChild = iconColor == null
        ? Icon(item.icon, size: iconSize)
        : TweenAnimationBuilder<Color?>(
            duration: duration,
            tween: ColorTween(end: iconColor),
            builder: (context, color, _) =>
                Icon(item.icon, color: color, size: iconSize),
          );

    final iconWidget = AnimatedContainer(
      duration: duration,
      curve: Curves.easeOutCubic,
      padding: isSubItem ? const EdgeInsets.all(6) : style.itemIconPadding,
      decoration: isSubItem ? null : iconDecoration,
      child: iconChild,
    );

    if (item.badge == null) {
      return iconWidget;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          top: style.badgeOffset?.top ?? -4,
          right: style.badgeOffset?.right ?? -4,
          child: BadgeWidget(badge: item.badge!, style: style),
        ),
      ],
    );
  }
}

class _FocusableItem extends StatefulWidget {
  final VoidCallback? onTap;
  final InnovareSideMenuStyle style;
  final Widget child;

  const _FocusableItem({
    required this.onTap,
    required this.style,
    required this.child,
  });

  @override
  State<_FocusableItem> createState() => _FocusableItemState();
}

class _FocusableItemState extends State<_FocusableItem> {
  bool _isFocused = false;

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space) {
        widget.onTap?.call();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
      },
      onKeyEvent: _handleKeyEvent,
      child: Builder(
        builder: (context) {
          if (!_isFocused) return widget.child;
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: widget.style.itemBorderRadius ?? BorderRadius.circular(4),
            ),
            position: DecorationPosition.foreground,
            child: widget.child,
          );
        },
      ),
    );
  }
}
