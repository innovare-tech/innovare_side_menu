import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  Widget buildApp({required List<InnovareSideMenuSection> sections}) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            InnovareSideMenu(
              mode: InnovareSideMenuMode.expanded,
              style: const InnovareSideMenuStyle(width: 280),
              sections: sections,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  InnovareSideMenuSection sectionWith({
    bool collapsible = true,
    bool initiallyExpanded = true,
  }) {
    return InnovareSideMenuSection(
      title: 'Group',
      collapsible: collapsible,
      initiallyExpanded: initiallyExpanded,
      items: const [
        InnovareSideMenuItem(id: 'a', title: 'Alpha', icon: Icons.circle_outlined),
        InnovareSideMenuItem(id: 'b', title: 'Beta', icon: Icons.circle_outlined),
      ],
    );
  }

  double bodyHeight(WidgetTester tester) =>
      tester.getSize(find.byType(AnimatedAlign)).height;

  group('Collapsible sections', () {
    testWidgets('header tap collapses and expands the body', (tester) async {
      await tester.pumpWidget(buildApp(sections: [sectionWith()]));
      await tester.pumpAndSettle();

      expect(bodyHeight(tester), greaterThan(0));

      await tester.tap(find.text('Group'));
      await tester.pumpAndSettle();
      expect(bodyHeight(tester), 0);

      await tester.tap(find.text('Group'));
      await tester.pumpAndSettle();
      expect(bodyHeight(tester), greaterThan(0));
    });

    testWidgets('initiallyExpanded: false starts collapsed', (tester) async {
      await tester.pumpWidget(
        buildApp(sections: [sectionWith(initiallyExpanded: false)]),
      );
      await tester.pumpAndSettle();

      expect(bodyHeight(tester), 0);
    });

    testWidgets('non-collapsible section renders no collapsible body',
        (tester) async {
      await tester.pumpWidget(
        buildApp(sections: [sectionWith(collapsible: false)]),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedAlign), findsNothing);
      expect(find.text('Alpha'), findsOneWidget);
    });
  });
}
