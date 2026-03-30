import 'package:flutter/material.dart';

import '../models/side_menu_badge.dart';
import '../styles/side_menu_style.dart';

class BadgeWidget extends StatelessWidget {
  final InnovareSideMenuBadge badge;
  final InnovareSideMenuStyle style;

  const BadgeWidget({
    super.key,
    required this.badge,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (badge.isDot) {
      return Container(
        width: style.badgeSize,
        height: style.badgeSize,
        decoration: BoxDecoration(
          color: badge.color ?? style.badgeColor ?? Colors.red,
          shape: BoxShape.circle,
        ),
      );
    }

    if (badge.customWidget != null) {
      return badge.customWidget!;
    }

    // count variant
    final displayText =
        badge.count != null && badge.count! > 99 ? '99+' : '${badge.count}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
      decoration: BoxDecoration(
        color: badge.color ?? style.badgeColor ?? Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        displayText,
        style: style.badgeTextStyle ??
            TextStyle(
              color: badge.textColor ?? style.badgeTextColor ?? Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
