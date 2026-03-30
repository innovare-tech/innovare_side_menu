import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('InnovareSideMenuItem', () {
    test('constructs with minimal parameters', () {
      const item = InnovareSideMenuItem(
        id: 'home',
        icon: Icons.home,
        title: 'Home',
      );

      expect(item.id, 'home');
      expect(item.icon, Icons.home);
      expect(item.title, 'Home');
      expect(item.route, isNull);
      expect(item.subItems, isNull);
      expect(item.onTap, isNull);
      expect(item.isActive, false);
      expect(item.trailing, isNull);
      expect(item.customLeading, isNull);
      expect(item.permission, isNull);
      expect(item.badge, isNull);
      expect(item.tooltip, isNull);
      expect(item.semanticLabel, isNull);
    });

    test('constructs with all parameters', () {
      final item = InnovareSideMenuItem(
        id: 'settings',
        icon: Icons.settings,
        title: 'Settings',
        route: '/settings',
        subItems: const [],
        onTap: () {},
        isActive: true,
        permission: 'admin',
        badge: const InnovareSideMenuBadge.count(3),
        tooltip: 'Open settings',
        semanticLabel: 'Settings menu item',
      );

      expect(item.id, 'settings');
      expect(item.route, '/settings');
      expect(item.subItems, isEmpty);
      expect(item.onTap, isNotNull);
      expect(item.isActive, true);
      expect(item.permission, 'admin');
      expect(item.badge, isNotNull);
      expect(item.tooltip, 'Open settings');
      expect(item.semanticLabel, 'Settings menu item');
    });

    test('copyWith changes only specified fields', () {
      const original = InnovareSideMenuItem(
        id: 'home',
        icon: Icons.home,
        title: 'Home',
        route: '/home',
        isActive: false,
        permission: 'user',
      );

      final updated = original.copyWith(
        title: 'Dashboard',
        isActive: true,
      );

      expect(updated.id, 'home');
      expect(updated.icon, Icons.home);
      expect(updated.title, 'Dashboard');
      expect(updated.route, '/home');
      expect(updated.isActive, true);
      expect(updated.permission, 'user');
    });

    test('copyWith preserves all fields when no arguments given', () {
      const original = InnovareSideMenuItem(
        id: 'test',
        icon: Icons.star,
        title: 'Test',
        route: '/test',
        isActive: true,
        permission: 'admin',
        tooltip: 'Tip',
        semanticLabel: 'Label',
      );

      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.icon, original.icon);
      expect(copy.title, original.title);
      expect(copy.route, original.route);
      expect(copy.isActive, original.isActive);
      expect(copy.permission, original.permission);
      expect(copy.tooltip, original.tooltip);
      expect(copy.semanticLabel, original.semanticLabel);
    });

    test('copyWith can set new badge, tooltip, semanticLabel', () {
      const original = InnovareSideMenuItem(
        id: 'item',
        icon: Icons.info,
        title: 'Item',
      );

      final updated = original.copyWith(
        badge: const InnovareSideMenuBadge.dot(),
        tooltip: 'New tooltip',
        semanticLabel: 'New label',
      );

      expect(updated.badge, isNotNull);
      expect(updated.badge!.isDot, true);
      expect(updated.tooltip, 'New tooltip');
      expect(updated.semanticLabel, 'New label');
    });
  });

  group('InnovareSideMenuSection', () {
    test('constructs with title and items', () {
      const section = InnovareSideMenuSection(
        title: 'Main',
        items: [
          InnovareSideMenuItem(
            id: 'home',
            icon: Icons.home,
            title: 'Home',
          ),
        ],
      );

      expect(section.title, 'Main');
      expect(section.items, hasLength(1));
    });

    test('constructs without title', () {
      const section = InnovareSideMenuSection(items: []);

      expect(section.title, isNull);
      expect(section.items, isEmpty);
    });
  });
}
