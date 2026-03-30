import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    InnovareSideMenuMode mode = InnovareSideMenuMode.collapsed,
    InnovareSideMenuStyle? style,
    List<InnovareSideMenuSection>? sections,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: mode,
              style: style ?? InnovareSideMenuStyle(collapsedWidth: 72),
              sections: sections ??
                  [
                    InnovareSideMenuSection(
                      title: 'Section A',
                      items: [
                        InnovareSideMenuItem(
                          id: 'home',
                          title: 'Home',
                          icon: Icons.home,
                        ),
                        InnovareSideMenuItem(
                          id: 'settings',
                          title: 'Settings',
                          icon: Icons.settings,
                        ),
                      ],
                    ),
                  ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  group('Collapsed Mode', () {
    testWidgets('menu with mode collapsed has collapsedWidth',
        (tester) async {
      await tester.pumpWidget(buildApp(
        style: InnovareSideMenuStyle(collapsedWidth: 80),
      ));
      await tester.pumpAndSettle();

      final renderBox = tester.renderObject<RenderBox>(
        find.byType(AnimatedContainer).first,
      );
      expect(renderBox.size.width, 80.0);
    });

    testWidgets('items in collapsed mode do not render title Text',
        (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsNothing);
      expect(find.text('Settings'), findsNothing);
    });

    testWidgets('tap on expandable item in collapsed mode creates OverlayEntry',
        (tester) async {
      await tester.pumpWidget(buildApp(
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'parent',
                title: 'Parent',
                icon: Icons.folder,
                subItems: [
                  InnovareSideMenuItem(
                    id: 'child1',
                    title: 'Child 1',
                    icon: Icons.file_copy,
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      // Sub-items should not be visible
      expect(find.text('Child 1'), findsNothing);

      // Tap the collapsed parent item icon
      await tester.tap(find.byIcon(Icons.folder));
      await tester.pumpAndSettle();

      // Sub-items should now be visible in the overlay popup
      expect(find.text('Child 1'), findsOneWidget);
    });

    testWidgets(
        'transition from expanded to collapsed uses AnimatedContainer',
        (tester) async {
      await tester.pumpWidget(buildApp(
        mode: InnovareSideMenuMode.expanded,
        style: InnovareSideMenuStyle(width: 280, collapsedWidth: 72),
      ));
      await tester.pumpAndSettle();

      // Verify AnimatedContainer exists
      expect(find.byType(AnimatedContainer), findsOneWidget);

      final renderBox = tester.renderObject<RenderBox>(
        find.byType(AnimatedContainer).first,
      );
      expect(renderBox.size.width, 280.0);

      // Rebuild with collapsed mode
      await tester.pumpWidget(buildApp(
        mode: InnovareSideMenuMode.collapsed,
        style: InnovareSideMenuStyle(width: 280, collapsedWidth: 72),
      ));

      // Pump partially — animation should be in progress
      await tester.pump(Duration(milliseconds: 150));
      final midBox = tester.renderObject<RenderBox>(
        find.byType(AnimatedContainer).first,
      );
      // Width should be between 72 and 280 during animation
      expect(midBox.size.width, greaterThan(72.0));
      expect(midBox.size.width, lessThan(280.0));

      // Pump to completion
      await tester.pumpAndSettle();
      final finalBox = tester.renderObject<RenderBox>(
        find.byType(AnimatedContainer).first,
      );
      expect(finalBox.size.width, 72.0);
    });
  });
}
