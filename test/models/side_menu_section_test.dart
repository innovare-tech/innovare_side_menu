import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
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
      expect(section.items.first.id, 'home');
    });

    test('constructs without title', () {
      const section = InnovareSideMenuSection(items: []);

      expect(section.title, isNull);
      expect(section.items, isEmpty);
    });

    test('constructs with multiple items', () {
      const section = InnovareSideMenuSection(
        title: 'Navigation',
        items: [
          InnovareSideMenuItem(id: 'a', icon: Icons.home, title: 'A'),
          InnovareSideMenuItem(id: 'b', icon: Icons.settings, title: 'B'),
          InnovareSideMenuItem(id: 'c', icon: Icons.info, title: 'C'),
        ],
      );

      expect(section.items, hasLength(3));
      expect(section.items[0].id, 'a');
      expect(section.items[2].id, 'c');
    });

    test('constructs with items containing subItems', () {
      const section = InnovareSideMenuSection(
        title: 'Nested',
        items: [
          InnovareSideMenuItem(
            id: 'parent',
            icon: Icons.folder,
            title: 'Parent',
            subItems: [
              InnovareSideMenuItem(
                id: 'child',
                icon: Icons.file_copy,
                title: 'Child',
              ),
            ],
          ),
        ],
      );

      expect(section.items.first.subItems, isNotNull);
      expect(section.items.first.subItems, hasLength(1));
    });
  });
}
