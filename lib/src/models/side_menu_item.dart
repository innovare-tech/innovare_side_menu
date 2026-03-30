import 'package:flutter/material.dart';

import 'side_menu_badge.dart';

/// Represents a single item in the [InnovareSideMenu].
///
/// Each item has an [id], [icon], and [title]. Items can optionally contain
/// [subItems] to create expandable/hierarchical menus, a [badge] for
/// notifications, and a [permission] key for filtering.
class InnovareSideMenuItem {
  /// Unique identifier for this menu item.
  final String id;

  /// The icon displayed for this menu item.
  final IconData icon;

  /// The display text for this menu item.
  final String title;

  /// Optional route associated with this item for navigation matching.
  final String? route;

  /// Nested child items. When provided, the item renders as expandable
  /// in expanded mode and shows a popup overlay in collapsed mode.
  final List<InnovareSideMenuItem>? subItems;

  /// Callback invoked when the item is tapped.
  final VoidCallback? onTap;

  /// Whether this item is currently active/selected.
  ///
  /// Defaults to `false`.
  final bool isActive;

  /// Optional widget displayed at the trailing end of the item.
  final Widget? trailing;

  /// Optional widget to replace the default icon as the leading element.
  final Widget? customLeading;

  /// Permission key used by [InnovareSideMenu.permissionChecker] to
  /// determine visibility. If `null`, the item is always visible.
  final String? permission;

  /// Optional badge displayed on the item (count, dot, or custom).
  final InnovareSideMenuBadge? badge;

  /// Tooltip text shown on hover. Defaults to [title] if not specified.
  final String? tooltip;

  /// Custom accessibility label for screen readers. Defaults to [title]
  /// if not specified.
  final String? semanticLabel;

  /// Creates a menu item.
  ///
  /// The [id], [icon], and [title] parameters are required.
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

  /// Creates a copy of this item with the given fields replaced.
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
