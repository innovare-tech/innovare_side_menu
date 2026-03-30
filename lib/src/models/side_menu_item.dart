import 'package:flutter/material.dart';

import 'side_menu_badge.dart';

class InnovareSideMenuItem {
  final String id;
  final IconData icon;
  final String title;
  final String? route;
  final List<InnovareSideMenuItem>? subItems;
  final VoidCallback? onTap;
  final bool isActive;
  final Widget? trailing;
  final Widget? customLeading;
  final String? permission;
  final InnovareSideMenuBadge? badge;
  final String? tooltip;
  final String? semanticLabel;

  const InnovareSideMenuItem({
    required this.id,
    required this.icon,
    required this.title,
    this.route,
    this.subItems,
    this.onTap,
    this.isActive = false,
    this.trailing,
    this.customLeading,
    this.permission,
    this.badge,
    this.tooltip,
    this.semanticLabel,
  });

  InnovareSideMenuItem copyWith({
    String? id,
    IconData? icon,
    String? title,
    String? route,
    List<InnovareSideMenuItem>? subItems,
    VoidCallback? onTap,
    bool? isActive,
    Widget? trailing,
    Widget? customLeading,
    String? permission,
    InnovareSideMenuBadge? badge,
    String? tooltip,
    String? semanticLabel,
  }) {
    return InnovareSideMenuItem(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      route: route ?? this.route,
      subItems: subItems ?? this.subItems,
      onTap: onTap ?? this.onTap,
      isActive: isActive ?? this.isActive,
      trailing: trailing ?? this.trailing,
      customLeading: customLeading ?? this.customLeading,
      permission: permission ?? this.permission,
      badge: badge ?? this.badge,
      tooltip: tooltip ?? this.tooltip,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }
}
