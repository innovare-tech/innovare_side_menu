import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('InnovareSideMenuStyle', () {
    test('default constructor has width 280 and collapsedWidth 72', () {
      const style = InnovareSideMenuStyle();

      expect(style.width, 280);
      expect(style.collapsedWidth, 72);
      expect(style.badgeSize, 8);
    });

    test('copyWith changes width and preserves all other fields', () {
      const original = InnovareSideMenuStyle(
        width: 280,
        collapsedWidth: 72,
        badgeSize: 8,
        itemFontSize: 14,
        subItemFontSize: 13,
      );

      final updated = original.copyWith(width: 320);

      expect(updated.width, 320);
      expect(updated.collapsedWidth, 72);
      expect(updated.badgeSize, 8);
      expect(updated.itemFontSize, 14);
      expect(updated.subItemFontSize, 13);
    });

    test('copyWith with no arguments preserves all fields', () {
      const original = InnovareSideMenuStyle(
        width: 300,
        collapsedWidth: 80,
        badgeSize: 10,
      );

      final copy = original.copyWith();

      expect(copy.width, original.width);
      expect(copy.collapsedWidth, original.collapsedWidth);
      expect(copy.badgeSize, original.badgeSize);
    });
  });

  group('InnovareSideMenuThemes', () {
    test('darkDefault returns style with gradient decoration and white text',
        () {
      final style = InnovareSideMenuThemes.darkDefault();

      expect(style.width, 280);
      expect(style.decoration, isNotNull);
      expect(style.decoration!.gradient, isNotNull);
      expect(style.activeItemTextColor, Colors.white);
      expect(style.collapsedWidth, 72);
    });

    test('fromTheme accepts ThemeData.light() without exception', () {
      final style =
          InnovareSideMenuThemes.fromTheme(ThemeData.light());

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
    });

    test('fromTheme accepts ThemeData.dark() without exception', () {
      final style =
          InnovareSideMenuThemes.fromTheme(ThemeData.dark());

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
    });

    test('lightDefault returns style with width > 0', () {
      final style = InnovareSideMenuThemes.lightDefault();

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
      expect(style.activeItemTextColor, Colors.white);
    });

    test('minimal returns style with width > 0', () {
      final style = InnovareSideMenuThemes.minimal();

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
    });

    test('glassmorphism returns style with width > 0', () {
      final style = InnovareSideMenuThemes.glassmorphism();

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
      expect(style.decoration!.gradient, isNotNull);
    });
  });
}
