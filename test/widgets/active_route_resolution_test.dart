import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';
// Import direto do widget interno para inspecionar estado `isActive`
// resolvido. `SimpleMenuItem` não é exportado na API pública, mas é um
// detalhe de implementação estável do package.
import 'package:innovare_side_menu/src/widgets/simple_menu_item.dart';

/// Testes de resolução automática de `isActive` baseado em `currentRoute`.
///
/// Regra: quando múltiplos itens do menu casam com a rota atual (via match
/// exato ou prefix), apenas o item com a rota MAIS ESPECÍFICA (maior
/// comprimento) fica ativo. Evita double-highlight de pai + filho quando
/// ambos estão declarados no menu em rotas prefixadas.
///
/// Regressão: antes dessa resolução, `/home/settings/tags` marcaria tanto
/// "Configurações" (`/home/settings`) quanto "Tags" (`/home/settings/tags`)
/// como ativos — o usuário relatou isso como bug após mover o item Tags
/// pra dentro da seção Organização de um consumer.

Future<void> _pumpMenu(
  WidgetTester tester, {
  required List<InnovareSideMenuSection> sections,
  String? currentRoute,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: InnovareSideMenu(
          sections: sections,
          currentRoute: currentRoute,
        ),
      ),
    ),
  );
}

/// Inspeciona o estado `isActive` do `SimpleMenuItem` renderizado que
/// contém o texto `itemTitle`. Estratégia mais confiável que ler
/// `Semantics` (que varia por plataforma de teste) ou decoration (que
/// depende do tema aplicado).
///
/// Retorna `true` se o item foi renderizado com `item.isActive == true`.
bool _itemIsActive(WidgetTester tester, String itemTitle) {
  // Tenta encontrar um SimpleMenuItem cujo Text filho seja o esperado.
  final allSimpleItems = find.byType(SimpleMenuItem);
  for (final element in allSimpleItems.evaluate()) {
    final widget = element.widget as SimpleMenuItem;
    if (widget.item.title == itemTitle) {
      return widget.item.isActive;
    }
  }
  fail('SimpleMenuItem com título "$itemTitle" não encontrado');
}

void main() {
  group('InnovareSideMenu — resolução de currentRoute → isActive', () {
    testWidgets('match exato marca o item correspondente como ativo',
        (tester) async {
      await _pumpMenu(
        tester,
        currentRoute: '/home/dashboard',
        sections: [
          InnovareSideMenuSection(
            title: 'Geral',
            items: [
              InnovareSideMenuItem(
                id: 'dashboard',
                title: 'Dashboard',
                icon: Icons.home,
                route: '/home/dashboard',
              ),
              InnovareSideMenuItem(
                id: 'reports',
                title: 'Relatórios',
                icon: Icons.bar_chart,
                route: '/home/reports',
              ),
            ],
          ),
        ],
      );

      expect(_itemIsActive(tester, 'Dashboard'), isTrue);
      expect(_itemIsActive(tester, 'Relatórios'), isFalse);
    });

    testWidgets(
      'quando currentRoute é sub-rota de um item e NÃO há filho declarado, '
      'apenas o pai fica ativo (comportamento de prefix legado preservado)',
      (tester) async {
        await _pumpMenu(
          tester,
          currentRoute: '/home/settings/webhooks',
          sections: [
            InnovareSideMenuSection(
              title: 'Org',
              items: [
                InnovareSideMenuItem(
                  id: 'settings',
                  title: 'Configurações',
                  icon: Icons.settings,
                  route: '/home/settings',
                ),
                InnovareSideMenuItem(
                  id: 'account',
                  title: 'Conta',
                  icon: Icons.person,
                  route: '/home/account',
                ),
              ],
            ),
          ],
        );

        expect(_itemIsActive(tester, 'Configurações'), isTrue);
        expect(_itemIsActive(tester, 'Conta'), isFalse);
      },
    );

    testWidgets(
      'quando dois itens casam por prefix vs exato, SOMENTE o mais '
      'específico fica ativo (REGRESSÃO: settings + tags ativos juntos)',
      (tester) async {
        // Cenário reportado pelo usuário: item "Tags" foi adicionado na
        // rota /home/settings/tags, mas "Configurações" (/home/settings)
        // continuava ficando ativo também quando a URL era /tags.
        await _pumpMenu(
          tester,
          currentRoute: '/home/settings/tags',
          sections: [
            InnovareSideMenuSection(
              title: 'Org',
              items: [
                InnovareSideMenuItem(
                  id: 'settings',
                  title: 'Configurações',
                  icon: Icons.settings,
                  route: '/home/settings',
                ),
                InnovareSideMenuItem(
                  id: 'tags',
                  title: 'Tags',
                  icon: Icons.label,
                  route: '/home/settings/tags',
                ),
              ],
            ),
          ],
        );

        // Apenas "Tags" ativo. "Configurações" perde o active mesmo sendo
        // prefixo da URL.
        expect(_itemIsActive(tester, 'Tags'), isTrue);
        expect(_itemIsActive(tester, 'Configurações'), isFalse);
      },
    );

    testWidgets(
      'ordem de declaração NÃO importa — a resolução é baseada em '
      'comprimento da rota, não em ordem',
      (tester) async {
        // Declara Tags ANTES de Configurações. O resultado deve ser o
        // mesmo: Tags vence por ter rota mais longa.
        await _pumpMenu(
          tester,
          currentRoute: '/home/settings/tags',
          sections: [
            InnovareSideMenuSection(
              title: 'Org',
              items: [
                InnovareSideMenuItem(
                  id: 'tags',
                  title: 'Tags',
                  icon: Icons.label,
                  route: '/home/settings/tags',
                ),
                InnovareSideMenuItem(
                  id: 'settings',
                  title: 'Configurações',
                  icon: Icons.settings,
                  route: '/home/settings',
                ),
              ],
            ),
          ],
        );

        expect(_itemIsActive(tester, 'Tags'), isTrue);
        expect(_itemIsActive(tester, 'Configurações'), isFalse);
      },
    );

    testWidgets(
      'currentRoute null → nenhum item fica ativo automaticamente',
      (tester) async {
        await _pumpMenu(
          tester,
          currentRoute: null,
          sections: [
            InnovareSideMenuSection(
              title: 'Geral',
              items: [
                InnovareSideMenuItem(
                  id: 'dashboard',
                  title: 'Dashboard',
                  icon: Icons.home,
                  route: '/home/dashboard',
                ),
              ],
            ),
          ],
        );

        expect(_itemIsActive(tester, 'Dashboard'), isFalse);
      },
    );

    testWidgets(
      'isActive declarado como true é REMOVIDO quando currentRoute não bate '
      '— resolução é determinística, não aditiva',
      (tester) async {
        // Item com isActive=true hardcoded, mas currentRoute aponta pra
        // outra rota. O widget deve sobrescrever o isActive para false.
        await _pumpMenu(
          tester,
          currentRoute: '/home/dashboard',
          sections: [
            InnovareSideMenuSection(
              title: 'Geral',
              items: [
                InnovareSideMenuItem(
                  id: 'dashboard',
                  title: 'Dashboard',
                  icon: Icons.home,
                  route: '/home/dashboard',
                ),
                InnovareSideMenuItem(
                  id: 'reports',
                  title: 'Relatórios',
                  icon: Icons.bar_chart,
                  route: '/home/reports',
                  isActive: true, // hardcoded, mas não bate com rota
                ),
              ],
            ),
          ],
        );

        expect(_itemIsActive(tester, 'Dashboard'), isTrue);
        // Relatórios perde o isActive porque a rota não bate.
        expect(_itemIsActive(tester, 'Relatórios'), isFalse);
      },
    );

    testWidgets(
      'item sem route declarado é ignorado pela resolução (mantém isActive '
      'original)',
      (tester) async {
        await _pumpMenu(
          tester,
          currentRoute: '/home/dashboard',
          sections: [
            InnovareSideMenuSection(
              title: 'Geral',
              items: [
                InnovareSideMenuItem(
                  id: 'dashboard',
                  title: 'Dashboard',
                  icon: Icons.home,
                  route: '/home/dashboard',
                ),
                InnovareSideMenuItem(
                  id: 'no-route',
                  title: 'Sem Rota',
                  icon: Icons.help,
                  isActive: true, // mantido porque não tem route
                ),
              ],
            ),
          ],
        );

        expect(_itemIsActive(tester, 'Dashboard'), isTrue);
        expect(_itemIsActive(tester, 'Sem Rota'), isTrue);
      },
    );
  });
}
