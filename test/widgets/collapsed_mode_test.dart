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

    testWidgets('tapping a sub-item in the popup closes the popup',
        (tester) async {
      var childTapped = false;
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
                    onTap: () => childTapped = true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.folder));
      await tester.pumpAndSettle();
      expect(find.text('Child 1'), findsOneWidget);

      // Selecting a sub-item should fire its onTap AND dismiss the popup.
      await tester.tap(find.text('Child 1'));
      await tester.pumpAndSettle();

      expect(childTapped, isTrue);
      expect(find.text('Child 1'), findsNothing);
    });

    testWidgets('collapsed parent shows active decoration while its popup is open',
        (tester) async {
      const activeDecoration = BoxDecoration(color: Colors.red);
      await tester.pumpWidget(buildApp(
        style: InnovareSideMenuStyle(
          collapsedWidth: 72,
          collapsedActiveItemDecoration: activeDecoration,
        ),
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

      bool hasActiveDecoration() => tester
          .widgetList<Container>(find.byType(Container))
          .any((c) => c.decoration == activeDecoration);

      expect(hasActiveDecoration(), isFalse);

      await tester.tap(find.byIcon(Icons.folder));
      await tester.pumpAndSettle();

      expect(hasActiveDecoration(), isTrue);
    });

    testWidgets('collapsed parent is active when one of its sub-items is active',
        (tester) async {
      const activeDecoration = BoxDecoration(color: Colors.red);
      await tester.pumpWidget(buildApp(
        style: InnovareSideMenuStyle(
          collapsedWidth: 72,
          collapsedActiveItemDecoration: activeDecoration,
        ),
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
                    isActive: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      final hasActiveDecoration = tester
          .widgetList<Container>(find.byType(Container))
          .any((c) => c.decoration == activeDecoration);
      expect(hasActiveDecoration, isTrue);
    });

    testWidgets(
        'transition from expanded to collapsed uses AnimatedContainer',
        (tester) async {
      await tester.pumpWidget(buildApp(
        mode: InnovareSideMenuMode.expanded,
        style: InnovareSideMenuStyle(width: 280, collapsedWidth: 72),
      ));
      await tester.pumpAndSettle();

      // Verify an AnimatedContainer drives the width. Menu items now animate
      // their state too, so several may exist; the outer one (first) is the
      // width container asserted below.
      expect(find.byType(AnimatedContainer), findsWidgets);

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
