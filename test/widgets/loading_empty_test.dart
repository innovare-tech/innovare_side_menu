import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  group('Loading and empty states', () {
    testWidgets('isLoading hides items and announces loading', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  isLoading: true,
                  loadingItemCount: 5,
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
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );
      // Skeleton pulses forever, so advance a single frame (no pumpAndSettle).
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Alpha'), findsNothing);
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('empty sections show the default empty state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  sections: [],
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('custom emptyState overrides the default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InnovareSideMenu(
                  mode: InnovareSideMenuMode.expanded,
                  sections: [],
                  emptyState: Center(child: Text('Nothing here')),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('No items'), findsNothing);
    });
  });
}
