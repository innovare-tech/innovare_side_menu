import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('Package exports', () {
    test('InnovareSideMenuMode has expanded and collapsed values', () {
      expect(InnovareSideMenuMode.values, hasLength(2));
      expect(InnovareSideMenuMode.values,
          contains(InnovareSideMenuMode.expanded));
      expect(InnovareSideMenuMode.values,
          contains(InnovareSideMenuMode.collapsed));
    });

    test('InnovareSideMenuBadge factories produce correct types', () {
      const count = InnovareSideMenuBadge.count(5);
      const dot = InnovareSideMenuBadge.dot();

      expect(count.count, 5);
      expect(count.isDot, false);
      expect(dot.isDot, true);
      expect(dot.count, isNull);
    });
  });
}
