import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    required List<InnovareSideMenuSection> sections,
    InnovareSideMenuStyle? style,
    bool Function(String permission)? permissionChecker,
    Widget? header,
    Widget? footer,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: InnovareSideMenu(
          sections: sections,
          style: style,
          permissionChecker: permissionChecker,
          header: header,
          footer: footer,
        ),
      ),
    );
  }

  group('InnovareSideMenu', () {
    testWidgets('renders both section titles with 2 sections', (tester) async {
      await tester.pumpWidget(buildApp(
        sections: [
          InnovareSideMenuSection(
            title: 'Section A',
            items: [
              InnovareSideMenuItem(
                id: 'a1',
                title: 'Item A1',
                icon: Icons.home,
              ),
            ],
          ),
          InnovareSideMenuSection(
            title: 'Section B',
            items: [
              InnovareSideMenuItem(
                id: 'b1',
                title: 'Item B1',
                icon: Icons.settings,
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Section A'), findsOneWidget);
      expect(find.text('Section B'), findsOneWidget);
      expect(find.text('Item A1'), findsOneWidget);
      expect(find.text('Item B1'), findsOneWidget);
    });

    testWidgets('active item uses activeItemDecoration from style',
        (tester) async {
      final activeDecoration = BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      );

      await tester.pumpWidget(buildApp(
        style: InnovareSideMenuStyle(
          activeItemDecoration: activeDecoration,
        ),
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'active',
                title: 'Active Item',
                icon: Icons.home,
                isActive: true,
              ),
            ],
          ),
        ],
      ));

      final container = tester.widgetList<Container>(find.byType(Container));
      final hasActiveDecoration = container.any(
        (c) => c.decoration == activeDecoration,
      );
      expect(hasActiveDecoration, isTrue);
    });

    testWidgets(
        'item with permission and permissionChecker returning false is hidden',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (_) => false,
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'admin',
                title: 'Admin Only',
                icon: Icons.admin_panel_settings,
                permission: 'admin',
              ),
              InnovareSideMenuItem(
                id: 'public',
                title: 'Public Item',
                icon: Icons.public,
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Admin Only'), findsNothing);
      expect(find.text('Public Item'), findsOneWidget);
    });

    testWidgets(
        'section where all items have denied permission is not rendered',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (_) => false,
        sections: [
          InnovareSideMenuSection(
            title: 'Hidden Section',
            items: [
              InnovareSideMenuItem(
                id: 's1',
                title: 'Secret 1',
                icon: Icons.lock,
                permission: 'admin',
              ),
              InnovareSideMenuItem(
                id: 's2',
                title: 'Secret 2',
                icon: Icons.lock,
                permission: 'superadmin',
              ),
            ],
          ),
          InnovareSideMenuSection(
            title: 'Visible Section',
            items: [
              InnovareSideMenuItem(
                id: 'vis',
                title: 'Visible Item',
                icon: Icons.visibility,
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Hidden Section'), findsNothing);
      expect(find.text('Secret 1'), findsNothing);
      expect(find.text('Secret 2'), findsNothing);
      expect(find.text('Visible Section'), findsOneWidget);
      expect(find.text('Visible Item'), findsOneWidget);
    });

    testWidgets('tap on expandable item shows sub-items', (tester) async {
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
                  InnovareSideMenuItem(
                    id: 'child2',
                    title: 'Child 2',
                    icon: Icons.file_copy,
                  ),
                ],
              ),
            ],
          ),
        ],
      ));

      // Sub-items should not be visible initially
      expect(find.text('Child 1'), findsNothing);
      expect(find.text('Child 2'), findsNothing);

      // Tap the parent to expand
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      // Sub-items should now be visible
      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });
  });
}
