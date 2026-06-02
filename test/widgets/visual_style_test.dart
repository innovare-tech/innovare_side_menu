import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({required InnovareSideMenuStyle style}) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              style: style,
              sections: [
                InnovareSideMenuSection(
                  items: [
                    InnovareSideMenuItem(
                      id: 'dashboard',
                      title: 'Dashboard',
                      icon: Icons.dashboard_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  group('Visual expression', () {
    testWidgets('backdropBlur wraps the rail in a BackdropFilter',
        (tester) async {
      await tester.pumpWidget(
        buildApp(style: const InnovareSideMenuStyle(backdropBlur: 18)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('no BackdropFilter when backdropBlur is null', (tester) async {
      await tester.pumpWidget(buildApp(style: const InnovareSideMenuStyle()));
      await tester.pumpAndSettle();

      expect(find.byType(BackdropFilter), findsNothing);
    });

    testWidgets('visualDensity is forwarded to item tiles', (tester) async {
      await tester.pumpWidget(
        buildApp(
          style: const InnovareSideMenuStyle(
            visualDensity: VisualDensity.compact,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final tile = tester.widget<ListTile>(find.byType(ListTile).first);
      expect(tile.visualDensity, VisualDensity.compact);
    });

    testWidgets('itemTextStyle is the base label style with overrides on top',
        (tester) async {
      await tester.pumpWidget(
        buildApp(
          style: const InnovareSideMenuStyle(
            itemTextStyle: TextStyle(letterSpacing: 2.5, fontFamily: 'Foo'),
            inactiveItemTextColor: Color(0xFFFF0000),
            itemFontSize: 17,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final animated = tester.widget<AnimatedDefaultTextStyle>(
        find
            .ancestor(
              of: find.text('Dashboard'),
              matching: find.byType(AnimatedDefaultTextStyle),
            )
            .first,
      );
      // Base typography is preserved...
      expect(animated.style.letterSpacing, 2.5);
      expect(animated.style.fontFamily, 'Foo');
      // ...while color/size from the active/inactive resolution layer on top.
      expect(animated.style.color, const Color(0xFFFF0000));
      expect(animated.style.fontSize, 17);
    });
  });
}
