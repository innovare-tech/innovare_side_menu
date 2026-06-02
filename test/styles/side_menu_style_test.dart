import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_design/innovare_design.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('InnovareSideMenuStyle', () {
    test('default constructor has width 280 and collapsedWidth 72', () {
      const style = InnovareSideMenuStyle();

      expect(style.width, 280);
      expect(style.collapsedWidth, 72);
      expect(style.badgeSize, 8);
      expect(style.animateOnAppear, isTrue);
      expect(style.stateAnimationDuration, const Duration(milliseconds: 200));
      expect(style.enableHaptics, isTrue);
      expect(style.pressedScale, 0.97);
      expect(style.hoverScale, 1.0);
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
      final style = InnovareSideMenuThemes.fromTheme(ThemeData.light());

      expect(style.width, greaterThan(0));
      expect(style.decoration, isNotNull);
    });

    test('fromTheme accepts ThemeData.dark() without exception', () {
      final style = InnovareSideMenuThemes.fromTheme(ThemeData.dark());

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

  group('InnovareSideMenuThemes.fromInnovare', () {
    test('maps brand, status and motion tokens from the design theme', () {
      final theme = InnvPresets.aurora();
      final style = InnovareSideMenuThemes.fromInnovare(theme);

      expect(style.decoration!.color, theme.colors.surfaceContainer);
      expect(style.activeItemDecoration!.color, theme.colors.brandContainer);
      expect(style.activeItemTextColor, theme.colors.onBrandContainer);
      expect(style.activeItemIconColor, theme.colors.brand);
      expect(style.badgeColor, theme.colors.danger.content);
      expect(style.expandAnimationDuration, theme.motion.micro);
      expect(style.stateAnimationDuration, theme.motion.micro);
      expect(style.appearAnimationDuration, theme.motion.enter);
    });

    test('honors the corner shape (pill preset uses chip radius on items)', () {
      final theme = InnvPresets.vibe();
      final style = InnovareSideMenuThemes.fromInnovare(theme);

      expect(style.itemBorderRadius, theme.shape.chipRadius);
    });

    test('honors depth: bordered preset draws a border and no shadow', () {
      final style = InnovareSideMenuThemes.fromInnovare(InnvPresets.slate());

      expect(style.decoration!.border, isNotNull);
      expect(style.decoration!.boxShadow, isEmpty);
    });

    test('honors depth: soft preset casts a shadow', () {
      final style = InnovareSideMenuThemes.fromInnovare(InnvPresets.aurora());

      expect(style.decoration!.boxShadow, isNotEmpty);
    });

    test('resolves a dark scheme without exception', () {
      final dark = InnvPresets.aurora(brightness: Brightness.dark);
      final style = InnovareSideMenuThemes.fromInnovare(dark);

      expect(style.decoration!.color, dark.colors.surfaceContainer);
    });
  });
}
