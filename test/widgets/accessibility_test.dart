import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    List<InnovareSideMenuSection>? sections,
    InnovareSideMenuMode mode = InnovareSideMenuMode.expanded,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: mode,
              style: InnovareSideMenuStyle(width: 280, collapsedWidth: 72),
              sections: sections ??
                  [
                    InnovareSideMenuSection(
                      title: 'Main',
                      items: [
                        InnovareSideMenuItem(
                          id: 'dashboard',
                          title: 'Dashboard',
                          icon: Icons.dashboard,
                          semanticLabel: 'Dashboard',
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

  group('Accessibility', () {
    testWidgets(
        'item with semanticLabel has Semantics with that label',
        (tester) async {
      await tester.pumpWidget(buildApp(
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'dash',
                title: 'Dashboard',
                icon: Icons.dashboard,
                semanticLabel: 'Dashboard',
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      final finder = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'Dashboard',
      );
      expect(finder, findsOneWidget);
    });

    testWidgets(
        'item with isActive true has Semantics selected true',
        (tester) async {
      await tester.pumpWidget(buildApp(
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'home',
                title: 'Home',
                icon: Icons.home,
                isActive: true,
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      final finder = find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            w.properties.label == 'Home' &&
            w.properties.selected == true,
      );
      expect(finder, findsOneWidget);
    });

    testWidgets(
        'sending Enter key on focused item triggers onTap',
        (tester) async {
      bool tapped = false;

      await tester.pumpWidget(buildApp(
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'item1',
                title: 'Item 1',
                icon: Icons.star,
                onTap: () => tapped = true,
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      // Focus the item by sending Tab keys
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      // Send Enter to activate
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(tapped, true);
    });

    testWidgets(
        'expandable item expanded has Semantics expanded true',
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
                    id: 'child',
                    title: 'Child',
                    icon: Icons.file_copy,
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
      await tester.pumpAndSettle();

      // Before expanding — Semantics should have expanded: false
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Semantics &&
              w.properties.label == 'Parent' &&
              w.properties.expanded == false,
        ),
        findsOneWidget,
      );

      // Tap to expand
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      // After expanding — Semantics should have expanded: true
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Semantics &&
              w.properties.label == 'Parent' &&
              w.properties.expanded == true,
        ),
        findsOneWidget,
      );
    });
  });
}
