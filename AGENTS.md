# innovare_side_menu — Flutter (menu lateral)

Pacote compartilhado — provê: **ui-component**. `InnovareSideMenu` — menu lateral configurável (`InnovareSideMenuStyle`: cores, largura default 280, decoration/gradiente, item ativo). Usado pelo `innovare_app_kit` (shell) e direto por apps.

## Dev
- Instalar: `flutter pub get`   Testar: `flutter test`   Analisar: `flutter analyze`

## Layout
- `lib/` (widget + `InnovareSideMenuStyle`), `example/` (demo), `test/`.

## Distribuição
- `publish_to: none`; consumido via git+tag. Depende de `innovare_design` via git ref (propaga transitivamente — consumidor não precisa redeclarar override). `dependency_overrides: path` só para dev local.

## Dependências internas
- Consome: `innovare-design` (v0.0.1). Pra inspecionar → skill `resolve-dependency-source`.

## Nunca
- Editar `.dart_tool/`, `build/`.

## Pronto = `flutter analyze` limpo + `flutter test` verde.
