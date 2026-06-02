import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({
    required List<InnovareSideMenuItem> items,
    InnovareSideMenuStyle? style,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 300,
          child: Row(
            children: [
              InnovareSideMenu(
                style: style,
                sections: [InnovareSideMenuSection(items: items)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<InnovareSideMenuItem> manyItems({required int activeIndex}) {
    return List.generate(
      30,
      (i) => InnovareSideMenuItem(
        id: 'item$i',
        title: 'Item $i',
        icon: Icons.circle_outlined,
        isActive: i == activeIndex,
      ),
    );
  }

  double scrollOffset(WidgetTester tester) {
    final scrollable =
        tester.state<ScrollableState>(find.byType(Scrollable).first);
    return scrollable.position.pixels;
  }

  group('Scroll to active', () {
    testWidgets('auto-scrolls to reveal the active item on mount',
        (tester) async {
      await tester.pumpWidget(buildApp(items: manyItems(activeIndex: 25)));
      await tester.pumpAndSettle();

      // The far-down active item should have forced the list to scroll.
      expect(scrollOffset(tester), greaterThan(0));
    });

    testWidgets('does not scroll when no item is active', (tester) async {
      await tester.pumpWidget(buildApp(items: manyItems(activeIndex: -1)));
      await tester.pumpAndSettle();

      expect(scrollOffset(tester), 0);
    });

    testWidgets('respects autoScrollToActive: false', (tester) async {
      await tester.pumpWidget(buildApp(
        items: manyItems(activeIndex: 25),
        style: const InnovareSideMenuStyle(autoScrollToActive: false),
      ));
      await tester.pumpAndSettle();

      expect(scrollOffset(tester), 0);
    });
  });
}
