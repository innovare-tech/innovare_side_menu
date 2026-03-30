# Innovare Side Menu

[![pub package](https://img.shields.io/pub/v/innovare_side_menu.svg)](https://pub.dev/packages/innovare_side_menu)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%E2%89%A53.10-02569B?logo=flutter)](https://flutter.dev)

A beautiful, highly customizable side menu widget for Flutter. Supports expanded and collapsed (rail) modes, hierarchical items, badges, permission-based filtering, accessibility, and 5 built-in themes — all with zero external dependencies.

## Features

- **Declarative API** — Define sections and items with simple data models
- **Expanded & Collapsed modes** — Animated transition between full menu and icon-only rail
- **Hierarchical items** — Expandable items with nested sub-items
- **5 built-in themes** — `darkDefault`, `lightDefault`, `minimal`, `glassmorphism`, and `fromTheme`
- **Badge support** — Count, dot, and fully custom badge widgets
- **Permission-based filtering** — Show/hide items based on user permissions
- **Full accessibility** — `Semantics` labels, keyboard navigation (Tab/Enter/Escape), focus indicators
- **Header & Footer** — Custom widgets for both expanded and collapsed modes
- **Zero external dependencies** — Only depends on Flutter SDK

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  innovare_side_menu: ^1.0.0
```

Then import it:

```dart
import 'package:innovare_side_menu/innovare_side_menu.dart';
```

## Usage

### Basic

```dart
InnovareSideMenu(
  sections: [
    InnovareSideMenuSection(
      title: 'MAIN',
      items: [
        InnovareSideMenuItem(
          id: 'home',
          icon: Icons.home,
          title: 'Home',
          isActive: true,
          onTap: () => print('Home tapped'),
        ),
        InnovareSideMenuItem(
          id: 'settings',
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => print('Settings tapped'),
        ),
      ],
    ),
  ],
)
```

### With Permissions

Filter menu items based on user roles. Items without a `permission` field are always visible. If `permissionChecker` is `null`, all items are shown.

```dart
InnovareSideMenu(
  permissionChecker: (permission) => userPermissions.contains(permission),
  sections: [
    InnovareSideMenuSection(
      title: 'ADMIN',
      items: [
        InnovareSideMenuItem(
          id: 'users',
          icon: Icons.people,
          title: 'Users',
          permission: 'manage_users',
          onTap: () {},
        ),
        InnovareSideMenuItem(
          id: 'logs',
          icon: Icons.list_alt,
          title: 'Audit Logs',
          permission: 'view_logs',
          onTap: () {},
        ),
      ],
    ),
  ],
)
```

### With Badges

Three badge variants: `count`, `dot`, and `custom`.

```dart
InnovareSideMenuItem(
  id: 'inbox',
  icon: Icons.inbox,
  title: 'Inbox',
  badge: InnovareSideMenuBadge.count(5),
  onTap: () {},
),
InnovareSideMenuItem(
  id: 'alerts',
  icon: Icons.notifications,
  title: 'Alerts',
  badge: InnovareSideMenuBadge.dot(),
  onTap: () {},
),
InnovareSideMenuItem(
  id: 'status',
  icon: Icons.circle,
  title: 'Status',
  badge: InnovareSideMenuBadge.custom(
    Container(width: 8, height: 8, color: Colors.green),
  ),
  onTap: () {},
),
```

### Collapsed Mode (Rail)

Toggle between expanded and collapsed modes with animated transitions. Provide separate header/footer widgets for each mode.

```dart
InnovareSideMenu(
  mode: isCollapsed
      ? InnovareSideMenuMode.collapsed
      : InnovareSideMenuMode.expanded,
  modeTransitionDuration: Duration(milliseconds: 300),
  header: Text('My App'),
  collapsedHeader: Icon(Icons.menu),
  footer: Text('v1.0.0'),
  collapsedFooter: SizedBox.shrink(),
  sections: [ /* ... */ ],
)
```

### Themes

Use one of the 5 built-in themes, or create your own `InnovareSideMenuStyle`:

```dart
// Dark theme (default)
InnovareSideMenu(
  style: InnovareSideMenuThemes.darkDefault(),
  sections: [ /* ... */ ],
)

// Adapt to the app's ThemeData
InnovareSideMenu(
  style: InnovareSideMenuThemes.fromTheme(Theme.of(context)),
  sections: [ /* ... */ ],
)

// Light theme
InnovareSideMenu(
  style: InnovareSideMenuThemes.lightDefault(),
  sections: [ /* ... */ ],
)

// Minimal theme
InnovareSideMenu(
  style: InnovareSideMenuThemes.minimal(),
  sections: [ /* ... */ ],
)

// Glassmorphism theme
InnovareSideMenu(
  style: InnovareSideMenuThemes.glassmorphism(),
  sections: [ /* ... */ ],
)
```

### Expandable Items

Items with `subItems` automatically render as expandable. In collapsed mode, sub-items appear in a popup overlay.

```dart
InnovareSideMenuItem(
  id: 'products',
  icon: Icons.inventory,
  title: 'Products',
  subItems: [
    InnovareSideMenuItem(
      id: 'catalog',
      icon: Icons.list,
      title: 'Catalog',
      onTap: () {},
    ),
    InnovareSideMenuItem(
      id: 'categories',
      icon: Icons.category,
      title: 'Categories',
      onTap: () {},
    ),
  ],
),
```

## API Reference

### `InnovareSideMenu`

The main widget. Key parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `sections` | `List<InnovareSideMenuSection>` | Menu sections with items (required) |
| `style` | `InnovareSideMenuStyle?` | Visual styling configuration |
| `mode` | `InnovareSideMenuMode` | `expanded` or `collapsed` (default: `expanded`) |
| `permissionChecker` | `bool Function(String)?` | Callback to check item permissions |
| `header` / `footer` | `Widget?` | Custom widgets for expanded mode |
| `collapsedHeader` / `collapsedFooter` | `Widget?` | Custom widgets for collapsed mode |
| `modeTransitionDuration` | `Duration?` | Animation duration (default: 300ms) |

### `InnovareSideMenuItem`

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `String` | Unique identifier (required) |
| `icon` | `IconData` | Menu item icon (required) |
| `title` | `String` | Display text (required) |
| `subItems` | `List<InnovareSideMenuItem>?` | Nested items (makes item expandable) |
| `onTap` | `VoidCallback?` | Tap callback |
| `isActive` | `bool` | Active/selected state (default: `false`) |
| `badge` | `InnovareSideMenuBadge?` | Badge to display |
| `permission` | `String?` | Permission key for filtering |
| `semanticLabel` | `String?` | Accessibility label override |

### `InnovareSideMenuStyle`

Comprehensive styling class with 50+ properties covering container, header/footer, sections, items, sub-items, collapsed mode, and badges. Use `copyWith()` to customize or start from a theme factory.

### `InnovareSideMenuThemes`

Extension on `InnovareSideMenuStyle` with 5 factory constructors:

- `darkDefault()` — Dark gradient with blue accents
- `lightDefault()` — Light background with blue active items
- `fromTheme(ThemeData)` — Adapts to any Flutter `ThemeData`
- `minimal()` — Clean, borderless design with left-border active indicator
- `glassmorphism()` — Translucent glass effect with rounded corners

## Example

See the [example app](example/) for a full interactive demo with theme switching, mode toggle, badges, and permission simulation.

```bash
cd example
flutter run -d chrome
```

## License

MIT — see [LICENSE](LICENSE) for details.
