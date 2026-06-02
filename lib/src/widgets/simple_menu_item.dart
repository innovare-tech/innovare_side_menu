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

    final baseOnTap = item.onTap;
    final onTap = baseOnTap == null
        ? null
        : () {
            if (style.enableHaptics) HapticFeedback.selectionClick();
            baseOnTap();
          };

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
        onTap: onTap,
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
        onTap: onTap,
        style: style,
        child: _InteractiveScale(
          enabled: onTap != null,
          pressedScale: style.pressedScale,
          hoverScale: style.hoverScale,
          child: tile,
        ),
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

/// Adds a tactile press (and optional hover) scale around an item.
///
/// Uses a raw [Listener] so it never competes with the tile's own tap gesture,
/// and cancels the press if the pointer moves enough to start a scroll. Honors
/// `MediaQuery.disableAnimations`.
class _InteractiveScale extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final double pressedScale;
  final double hoverScale;

  const _InteractiveScale({
    required this.child,
    required this.enabled,
    required this.pressedScale,
    required this.hoverScale,
  });

  @override
  State<_InteractiveScale> createState() => _InteractiveScaleState();
}

class _InteractiveScaleState extends State<_InteractiveScale> {
  bool _pressed = false;
  bool _hovered = false;
  Offset? _downPosition;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    var scale = 1.0;
    if (widget.enabled && !reduceMotion) {
      if (_pressed) {
        scale = widget.pressedScale;
      } else if (_hovered) {
        scale = widget.hoverScale;
      }
    }

    final scaled = AnimatedScale(
      scale: scale,
      duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: widget.child,
    );

    if (!widget.enabled) return scaled;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerDown: (event) {
          _downPosition = event.position;
          _setPressed(true);
        },
        onPointerMove: (event) {
          if (_pressed &&
              _downPosition != null &&
              (event.position - _downPosition!).distance > 12) {
            _setPressed(false);
          }
        },
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: scaled,
      ),
    );
  }
}
