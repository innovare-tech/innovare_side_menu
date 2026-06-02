import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget app(Widget body) => MaterialApp(
        home: MediaQuery(
          // Simulate the OS "reduce motion" / "disable animations" setting.
          data: const MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: Row(
              children: [body, const Expanded(child: SizedBox())],
            ),
          ),
        ),
      );

  testWidgets(
    'disposing under reduce-motion does not crash (no lazy Ticker in dispose)',
    (tester) async {
      await tester.pumpWidget(
        app(
          InnovareSideMenu(
            sections: [
              InnovareSideMenuSection(
                items: [
                  InnovareSideMenuItem(
                    id: 'a',
                    title: 'Alpha',
                    icon: Icons.circle_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Swap the whole tree so the menu and its per-item _Appear states are
      // disposed. Before the fix this lazily built an AnimationController in
      // dispose(), triggering an unsafe TickerMode lookup.
      await tester.pumpWidget(app(const SizedBox()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    },
  );
}
