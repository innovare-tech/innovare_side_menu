import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

/// Golden (visual regression) snapshots for the side menu in its key states.
///
/// Regenerate after intentional visual changes with:
///   flutter test --update-goldens test/golden
/// Goldens are rendered with animations disabled for determinism.
void main() {
  Widget frame({
    required Widget child,
    Size size = const Size(280, 560),
  }) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          body: Center(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  List<InnovareSideMenuSection> sections({String active = 'inbox'}) => [
        InnovareSideMenuSection(
          title: 'MAIN',
          items: [
            InnovareSideMenuItem(
              id: 'dashboard',
              title: 'Dashboard',
              icon: Icons.dashboard_outlined,
              isActive: active == 'dashboard',
            ),
            InnovareSideMenuItem(
              id: 'inbox',
              title: 'Inbox',
              icon: Icons.inbox_outlined,
              badge: const InnovareSideMenuBadge.count(12),
              isActive: active == 'inbox',
            ),
            InnovareSideMenuItem(
              id: 'calendar',
              title: 'Calendar',
              icon: Icons.calendar_today_outlined,
              badge: const InnovareSideMenuBadge.dot(),
              isActive: active == 'calendar',
            ),
          ],
        ),
      ];

  group('Golden', () {
    testWidgets('expanded with active item and badges', (tester) async {
      await tester.pumpWidget(
        frame(
          child: InnovareSideMenu(
            mode: InnovareSideMenuMode.expanded,
            style: InnovareSideMenuThemes.lightDefault(),
            sections: sections(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(InnovareSideMenu),
        matchesGoldenFile('goldens/expanded.png'),
      );
    });

    testWidgets('collapsed rail with badges', (tester) async {
      await tester.pumpWidget(
        frame(
          size: const Size(72, 560),
          child: InnovareSideMenu(
            mode: InnovareSideMenuMode.collapsed,
            style: InnovareSideMenuThemes.lightDefault(),
            sections: sections(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(InnovareSideMenu),
        matchesGoldenFile('goldens/collapsed.png'),
      );
    });

    testWidgets('loading skeleton', (tester) async {
      await tester.pumpWidget(
        frame(
          child: InnovareSideMenu(
            mode: InnovareSideMenuMode.expanded,
            style: InnovareSideMenuThemes.lightDefault(),
            isLoading: true,
            loadingItemCount: 6,
            sections: sections(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(InnovareSideMenu),
        matchesGoldenFile('goldens/loading.png'),
      );
    });
  });
}
