import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({required bool expandOnHover}) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: InnovareSideMenuMode.collapsed,
              style: InnovareSideMenuStyle(
                width: 280,
                collapsedWidth: 72,
                expandOnHover: expandOnHover,
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

  group('Expand on hover', () {
    testWidgets('widens the rail while hovered, collapses on exit',
        (tester) async {
      await tester.pumpWidget(buildApp(expandOnHover: true));
      await tester.pumpAndSettle();

      expect(menuWidth(tester), 72);

      final gesture =
          await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(
        location: tester.getCenter(find.byIcon(Icons.home)),
      );
      addTearDown(gesture.removePointer);
      await tester.pumpAndSettle();

      expect(menuWidth(tester), 280);

      await gesture.moveTo(const Offset(1000, 1000));
      await tester.pumpAndSettle();

      expect(menuWidth(tester), 72);
    });

    testWidgets('does nothing when expandOnHover is false', (tester) async {
      await tester.pumpWidget(buildApp(expandOnHover: false));
      await tester.pumpAndSettle();

      final gesture =
          await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(
        location: tester.getCenter(find.byIcon(Icons.home)),
      );
      addTearDown(gesture.removePointer);
      await tester.pumpAndSettle();

      expect(menuWidth(tester), 72);
    });
  });
}
