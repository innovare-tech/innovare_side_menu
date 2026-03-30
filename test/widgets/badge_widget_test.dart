import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    required InnovareSideMenuBadge? badge,
    InnovareSideMenuStyle? style,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: InnovareSideMenu(
          sections: [
            InnovareSideMenuSection(
              items: [
                InnovareSideMenuItem(
                  id: 'test',
                  title: 'Test Item',
                  icon: Icons.home,
                  badge: badge,
                ),
              ],
            ),
          ],
          style: style,
        ),
      ),
    );
  }

  group('BadgeWidget', () {
    testWidgets('count(5) renders Text "5"', (tester) async {
      await tester.pumpWidget(buildApp(
        badge: InnovareSideMenuBadge.count(5),
      ));

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('count(150) renders Text "99+"', (tester) async {
      await tester.pumpWidget(buildApp(
        badge: InnovareSideMenuBadge.count(150),
      ));

      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('dot() renders circular Container with badgeSize',
        (tester) async {
      await tester.pumpWidget(buildApp(
        badge: InnovareSideMenuBadge.dot(),
        style: InnovareSideMenuStyle(badgeSize: 10),
      ));

      final containers = tester.widgetList<Container>(find.byType(Container));
      final dotContainer = containers.where((c) {
        final dec = c.decoration;
        if (dec is BoxDecoration) {
          return dec.shape == BoxShape.circle;
        }
        return false;
      });
      expect(dotContainer, isNotEmpty);

      final dot = dotContainer.first;
      expect(dot.constraints, BoxConstraints.tightFor(width: 10, height: 10));
    });

    testWidgets('item without badge does not contain Stack', (tester) async {
      await tester.pumpWidget(buildApp(badge: null));

      // Find all Stacks — there should be none wrapping the icon
      // The item should render a plain Container for the icon, not a Stack
      final stacks = find.byType(Stack);
      // MaterialApp/Scaffold may have internal Stacks, so we check
      // that there's no Stack as a descendant of ListTile
      final listTile = find.byType(ListTile);
      expect(listTile, findsOneWidget);

      final stacksInListTile = find.descendant(
        of: listTile,
        matching: find.byType(Stack),
      );
      expect(stacksInListTile, findsNothing);
    });
  });
}
