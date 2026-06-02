import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp(
    InnovareSideMenuController controller, {
    InnovareSideMenuMode mode = InnovareSideMenuMode.expanded,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              controller: controller,
              mode: mode,
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
                InnovareSideMenuSection(
                  title: 'GROUP',
                  collapsible: true,
                  items: [
                    InnovareSideMenuItem(
                      id: 'child',
                      title: 'Child',
                      icon: Icons.circle_outlined,
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

  // The collapsible body keeps its child mounted (clipped), so assert on the
  // rolled height of the AnimatedAlign instead of widget presence.
  double bodyHeight(WidgetTester tester) =>
      tester.getSize(find.byType(AnimatedAlign)).height;

  group('InnovareSideMenuController', () {
    testWidgets('collapse() and expand() change the rail width',
        (tester) async {
      final controller = InnovareSideMenuController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(buildApp(controller));
      await tester.pumpAndSettle();
      final expandedWidth = tester.getSize(find.byType(InnovareSideMenu)).width;

      controller.collapse();
      await tester.pumpAndSettle();
      final collapsedWidth =
          tester.getSize(find.byType(InnovareSideMenu)).width;
      expect(collapsedWidth, lessThan(expandedWidth));

      controller.expand();
      await tester.pumpAndSettle();
      expect(
          tester.getSize(find.byType(InnovareSideMenu)).width, expandedWidth);
    });

    testWidgets('toggleCollapsed() flips the state', (tester) async {
      final controller = InnovareSideMenuController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(buildApp(controller));
      await tester.pumpAndSettle();
      final expandedWidth = tester.getSize(find.byType(InnovareSideMenu)).width;

      controller.toggleCollapsed();
      await tester.pumpAndSettle();
      expect(controller.isCollapsed, isTrue);
      expect(
        tester.getSize(find.byType(InnovareSideMenu)).width,
        lessThan(expandedWidth),
      );

      controller.toggleCollapsed();
      await tester.pumpAndSettle();
      expect(controller.isCollapsed, isFalse);
    });

    testWidgets('overrides mode (collapsed controller beats expanded mode)',
        (tester) async {
      final controller = InnovareSideMenuController(collapsed: true);
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        buildApp(controller, mode: InnovareSideMenuMode.expanded),
      );
      await tester.pumpAndSettle();

      // Collapsed rail renders icons only, so the label is not shown.
      expect(find.text('Dashboard'), findsNothing);
    });

    testWidgets('collapseSection()/expandSection() roll the body in and out',
        (tester) async {
      final controller = InnovareSideMenuController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(buildApp(controller));
      await tester.pumpAndSettle();
      expect(bodyHeight(tester), greaterThan(0));

      controller.collapseSection('GROUP');
      await tester.pumpAndSettle();
      expect(bodyHeight(tester), 0);

      controller.expandSection('GROUP');
      await tester.pumpAndSettle();
      expect(bodyHeight(tester), greaterThan(0));
    });

    testWidgets('starts with a section collapsed when seeded', (tester) async {
      final controller =
          InnovareSideMenuController(collapsedSections: const ['GROUP']);
      addTearDown(controller.dispose);

      await tester.pumpWidget(buildApp(controller));
      await tester.pumpAndSettle();

      expect(bodyHeight(tester), 0);
      expect(controller.isSectionCollapsed('GROUP'), isTrue);
    });
  });
}
