import 'package:flutter/widgets.dart';

/// A badge displayed on a menu item to indicate notifications or status.
///
/// Use the named constructors to create different badge variants:
/// - [InnovareSideMenuBadge.count] — Numeric count badge.
/// - [InnovareSideMenuBadge.dot] — Small dot indicator.
/// - [InnovareSideMenuBadge.custom] — Fully custom widget.
class InnovareSideMenuBadge {
  /// The numeric count to display. Only set by [InnovareSideMenuBadge.count].
  final int? count;

  /// Background color of the badge.
  final Color? color;

  /// Text color for the count label.
  final Color? textColor;

  /// A fully custom widget to render as the badge.
  final Widget? customWidget;

  /// Whether this badge is a simple dot indicator.
  final bool isDot;

  /// Creates a badge displaying a numeric [count].
  ///
  /// Optionally specify [color] and [textColor] to override theme defaults.
  const InnovareSideMenuBadge.count(
    int this.count, {
    this.color,
    this.textColor,
  })  : isDot = false,
        customWidget = null;

  /// Creates a small dot badge indicator.
  ///
  /// Optionally specify [color] to override the default badge color.
  const InnovareSideMenuBadge.dot({
    this.color,
  })  : count = null,
        textColor = null,
        customWidget = null,
        isDot = true;

  /// Creates a badge with a fully [customWidget].
  ///
  /// The widget is rendered as-is in the badge position.
  const InnovareSideMenuBadge.custom(
    Widget this.customWidget,
  )   : count = null,
        color = null,
        textColor = null,
        isDot = false;
}
