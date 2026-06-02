import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp(List<String> tapped) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: InnovareSideMenuMode.expanded,
              sections: [
                InnovareSideMenuSection(
                  items: [
                    InnovareSideMenuItem(
                      id: 'a',
                      title: 'Alpha',
                      icon: Icons.circle_outlined,
                      onTap: () => tapped.add('a'),
                    ),
                    InnovareSideMenuItem(
                      id: 'b',
                      title: 'Beta',
                      icon: Icons.circle_outlined,
                      onTap: () => tapped.add('b'),
                    ),
                    InnovareSideMenuItem(
                      id: 'c',
                      title: 'Gamma',
                      icon: Icons.circle_outlined,
                      onTap: () => tapped.add('c'),
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

  group('Keyboard navigation', () {
    testWidgets('arrow down moves focus, Enter activates', (tester) async {
      final tapped = <String>[];
      await tester.pumpWidget(buildApp(tapped));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab); // focus first (a)
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown); // -> b
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(tapped, ['b']);
    });

    testWidgets('End focuses last, Home focuses first', (tester) async {
      final tapped = <String>[];
      await tester.pumpWidget(buildApp(tapped));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab); // focus first (a)
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.end); // -> c
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(tapped, ['c']);

      await tester.sendKeyEvent(LogicalKeyboardKey.home); // -> a
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(tapped, ['c', 'a']);
    });
  });
}
