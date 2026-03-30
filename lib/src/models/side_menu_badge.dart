import 'package:flutter/widgets.dart';

class InnovareSideMenuBadge {
  final int? count;
  final Color? color;
  final Color? textColor;
  final Widget? customWidget;
  final bool isDot;

  const InnovareSideMenuBadge.count(
    int this.count, {
    this.color,
    this.textColor,
  })  : isDot = false,
        customWidget = null;

  const InnovareSideMenuBadge.dot({
    this.color,
  })  : count = null,
        textColor = null,
        customWidget = null,
        isDot = true;

  const InnovareSideMenuBadge.custom(
    Widget this.customWidget,
  )   : count = null,
        color = null,
        textColor = null,
        isDot = false;
}
