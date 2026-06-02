import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp() {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: InnovareSideMenuMode.expanded,
              style: const InnovareSideMenuStyle(
                width: 280,
                collapsedWidth: 72,
                autoCollapseBelowWidth: 600,
              ),
              sections: const [
                InnovareSideMenuSection(
                  items: [
                    InnovareSideMenuItem(
                      id: 'home',
                      title: 'Home',
                      icon: Icons.home,
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

  double menuWidth(WidgetTester tester) =>
      tester.getSize(find.byType(AnimatedContainer).first).width;

  group('Responsive auto-collapse', () {
    testWidgets('collapses to a rail below the breakpoint', (tester) async {
      tester.view.physicalSize = const Size(500, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // 500 < 600 → forced rail even though mode is expanded.
      expect(menuWidth(tester), 72);
    });

    testWidgets('stays expanded above the breakpoint', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(menuWidth(tester), 280);
    });
  });
}
