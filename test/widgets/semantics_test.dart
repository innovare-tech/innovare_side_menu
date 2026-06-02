import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('Semantics', () {
    testWidgets(
        'item labels include badge descriptions; menu has a region label',
        (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  semanticsLabel: 'Main navigation',
                  sections: const [
                    InnovareSideMenuSection(
                      items: [
                        InnovareSideMenuItem(
                          id: 'inbox',
                          title: 'Inbox',
                          icon: Icons.inbox,
                          badge: InnovareSideMenuBadge.count(12),
                        ),
                        InnovareSideMenuItem(
                          id: 'alerts',
                          title: 'Alerts',
                          icon: Icons.notifications,
                          badge: InnovareSideMenuBadge.dot(),
                        ),
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
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Inbox, 12 notifications'), findsOneWidget);
      expect(find.bySemanticsLabel('Alerts, notification'), findsOneWidget);
      expect(find.bySemanticsLabel('Main navigation'), findsOneWidget);

      handle.dispose();
    });
  });
}
