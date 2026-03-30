import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    required List<InnovareSideMenuSection> sections,
    bool Function(String permission)? permissionChecker,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: InnovareSideMenu(
          sections: sections,
          permissionChecker: permissionChecker,
        ),
      ),
    );
  }

  group('Permission Filter', () {
    testWidgets('item without permission is always visible', (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (_) => false,
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'public',
                title: 'Public',
                icon: Icons.public,
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Public'), findsOneWidget);
    });

    testWidgets('item with permission and checker returning true is visible',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (p) => p == 'admin',
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'admin',
                title: 'Admin Panel',
                icon: Icons.admin_panel_settings,
                permission: 'admin',
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Admin Panel'), findsOneWidget);
    });

    testWidgets('item with permission and checker returning false is hidden',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (p) => p != 'blocked',
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'blocked',
                title: 'Blocked Item',
                icon: Icons.block,
                permission: 'blocked',
              ),
              InnovareSideMenuItem(
                id: 'allowed',
                title: 'Allowed Item',
                icon: Icons.check,
                permission: 'allowed',
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Blocked Item'), findsNothing);
      expect(find.text('Allowed Item'), findsOneWidget);
    });

    testWidgets('section with all items denied is completely hidden',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (_) => false,
        sections: [
          InnovareSideMenuSection(
            title: 'Secret Section',
            items: [
              InnovareSideMenuItem(
                id: 's1',
                title: 'Secret 1',
                icon: Icons.lock,
                permission: 'admin',
              ),
            ],
          ),
          InnovareSideMenuSection(
            title: 'Visible Section',
            items: [
              InnovareSideMenuItem(
                id: 'v1',
                title: 'Visible',
                icon: Icons.visibility,
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Secret Section'), findsNothing);
      expect(find.text('Secret 1'), findsNothing);
      expect(find.text('Visible Section'), findsOneWidget);
      expect(find.text('Visible'), findsOneWidget);
    });

    testWidgets(
        'expandable item hidden when no sub-items have permission',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (_) => false,
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
                    permission: 'admin',
                  ),
                  InnovareSideMenuItem(
                    id: 'child2',
                    title: 'Child 2',
                    icon: Icons.file_copy,
                    permission: 'superadmin',
                  ),
                ],
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Parent'), findsNothing);
    });

    testWidgets(
        'expandable item visible when at least one sub-item has permission',
        (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: (p) => p == 'user',
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
                    permission: 'admin',
                  ),
                  InnovareSideMenuItem(
                    id: 'child2',
                    title: 'Child 2',
                    icon: Icons.file_copy,
                    permission: 'user',
                  ),
                ],
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Parent'), findsOneWidget);
    });

    testWidgets('null permissionChecker shows all items', (tester) async {
      await tester.pumpWidget(buildApp(
        permissionChecker: null,
        sections: [
          InnovareSideMenuSection(
            items: [
              InnovareSideMenuItem(
                id: 'a',
                title: 'Item A',
                icon: Icons.home,
                permission: 'admin',
              ),
              InnovareSideMenuItem(
                id: 'b',
                title: 'Item B',
                icon: Icons.settings,
                permission: 'superadmin',
              ),
            ],
          ),
        ],
      ));

      expect(find.text('Item A'), findsOneWidget);
      expect(find.text('Item B'), findsOneWidget);
    });
  });
}
