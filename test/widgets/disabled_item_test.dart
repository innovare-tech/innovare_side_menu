import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('Disabled items', () {
    testWidgets('ignores taps and is dimmed by disabledOpacity',
        (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  sections: [
                    InnovareSideMenuSection(
                      items: [
                        InnovareSideMenuItem(
                          id: 'x',
                          title: 'Disabled',
                          icon: Icons.block,
                          enabled: false,
                          onTap: () => taps++,
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

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();
      expect(taps, 0);

      final opacities = tester.widgetList<Opacity>(
        find.ancestor(
          of: find.text('Disabled'),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacities.any((o) => o.opacity == 0.38), isTrue);
    });

    testWidgets('is skipped by keyboard focus traversal', (tester) async {
      var enabledTaps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  sections: [
                    InnovareSideMenuSection(
                      items: [
                        const InnovareSideMenuItem(
                          id: 'x',
                          title: 'Disabled',
                          icon: Icons.block,
                          enabled: false,
                        ),
                        InnovareSideMenuItem(
                          id: 'y',
                          title: 'Enabled',
                          icon: Icons.check,
                          onTap: () => enabledTaps++,
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

      await tester
          .sendKeyEvent(LogicalKeyboardKey.tab); // skips disabled -> Enabled
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(enabledTaps, 1);
    });
  });
}
