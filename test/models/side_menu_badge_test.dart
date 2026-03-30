import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('InnovareSideMenuBadge', () {
    test('count() sets count and isDot false', () {
      const badge = InnovareSideMenuBadge.count(3);

      expect(badge.count, 3);
      expect(badge.isDot, false);
      expect(badge.customWidget, isNull);
    });

    test('count() accepts color and textColor', () {
      const badge = InnovareSideMenuBadge.count(
        5,
        color: Color(0xFFFF0000),
        textColor: Color(0xFFFFFFFF),
      );

      expect(badge.count, 5);
      expect(badge.color, const Color(0xFFFF0000));
      expect(badge.textColor, const Color(0xFFFFFFFF));
    });

    test('dot() sets isDot true and count null', () {
      const badge = InnovareSideMenuBadge.dot();

      expect(badge.isDot, true);
      expect(badge.count, isNull);
      expect(badge.customWidget, isNull);
    });

    test('dot() accepts color', () {
      const badge = InnovareSideMenuBadge.dot(color: Color(0xFF00FF00));

      expect(badge.isDot, true);
      expect(badge.color, const Color(0xFF00FF00));
    });

    test('custom() sets customWidget and isDot false', () {
      const widget = SizedBox(width: 10, height: 10);
      const badge = InnovareSideMenuBadge.custom(widget);

      expect(badge.customWidget, isNotNull);
      expect(badge.isDot, false);
      expect(badge.count, isNull);
      expect(badge.color, isNull);
      expect(badge.textColor, isNull);
    });
  });
}
