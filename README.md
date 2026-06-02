# Innovare Side Menu

[![pub package](https://img.shields.io/pub/v/innovare_side_menu.svg)](https://pub.dev/packages/innovare_side_menu)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%E2%89%A53.27-02569B?logo=flutter)](https://flutter.dev)

A beautiful, highly customizable side menu widget for Flutter. Supports expanded and collapsed (rail) modes, hierarchical items, badges, permission-based filtering, accessibility, and ready-made theme factories — including first-class integration with the [Innovare Design System](https://github.com/innovare-tech/innovare_design).

## Features

- **Declarative API** — Define sections and items with simple data models
- **Expanded & collapsed (rail) modes** — Animated transition between full menu and icon-only rail, with optional **hover-to-expand** and **responsive auto-rail**
- **Imperative controller** — Collapse/expand and open/close sections from code (e.g. a hamburger button)
- **Hierarchical items** — Expandable items with nested sub-items (popup overlay when collapsed)
- **Collapsible sections** — Tappable section headers that roll their items in/out
- **Theme factories** — `darkDefault`, `lightDefault`, `minimal`, `glassmorphism`, `fromTheme`, plus `fromInnovare` (derives the style from the [Innovare Design System](https://github.com/innovare-tech/innovare_design) tokens)
- **Motion & haptics** — Animated active/hover states, staggered appearance and tactile press feedback — all reduce-motion aware
- **Frosted glass & full styling** — Real `BackdropFilter` blur, configurable density and label typography, 60+ style properties
- **Badge support** — Count, dot, and fully custom badge widgets
- **Loading & empty states** — Built-in skeleton placeholders and an overridable empty state
- **Permission-based filtering** — Show/hide items based on user permissions
- **Accessibility** — Labeled navigation region, badge-aware item semantics, disabled items and native focus traversal
- **Header & Footer** — Custom widgets for both expanded and collapsed modes
- **Design-system ready** — First-class `fromInnovare` integration with the Innovare Design System

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  innovare_side_menu: ^1.1.0
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

### From the Innovare Design System

If your app uses the [Innovare Design System](https://github.com/innovare-tech/innovare_design), derive the menu style straight from its tokens so the menu always matches the active client brand — color, corner shape, type scale and motion personality:

```dart
import 'package:innovare_design/innovare_design.dart';

InnovareSideMenu(
  style: InnovareSideMenuThemes.fromInnovare(context.innv),
  sections: [ /* ... */ ],
)
```

`fromInnovare` honors light/dark (via the scheme's `Brightness`) and the chosen `InnvDepthStyle` — a bordered preset draws a hairline outline, a soft preset casts a layered shadow.

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

### Imperative Control (collapse & sections)

Drive the rail from your own UI — a hamburger button, a shortcut, anything — with an `InnovareSideMenuController`. While attached, the controller is the source of truth for the collapse state (overriding `mode`) and for which collapsible sections are open. You own its lifecycle, so dispose it with your `State`.

```dart
class _ShellState extends State<Shell> {
  final _menu = InnovareSideMenuController(collapsed: false);

  @override
  void dispose() {
    _menu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _menu.toggleCollapsed, // collapse() / expand() too
        ),
      ),
      body: Row(
        children: [
          InnovareSideMenu(
            controller: _menu,
            sections: const [ /* ... */ ],
          ),
          const Expanded(child: SizedBox(/* page */)),
        ],
      ),
    );
  }
}
```

The controller also exposes `collapseSection(title)` / `expandSection(title)` / `toggleSection(title)` plus the `isCollapsed` / `isSectionExpanded(title)` getters. It's a `ChangeNotifier`, so you can listen to react to state changes.

### Collapsible Sections

Set `collapsible: true` on a section (it needs a `title`) to render a tappable header with a rotating chevron that rolls its items in/out. Use `initiallyExpanded` to control the starting state.

```dart
InnovareSideMenuSection(
  title: 'CONTENT',
  collapsible: true,
  initiallyExpanded: false,
  items: [ /* ... */ ],
)
```

### Responsive & Hover-to-Expand

```dart
InnovareSideMenu(
  style: InnovareSideMenuThemes.lightDefault().copyWith(
    // Expand a collapsed rail in place while hovered (desktop/web).
    expandOnHover: true,
    // Auto-collapse to a rail below this width, regardless of `mode`.
    autoCollapseBelowWidth: 700,
  ),
  sections: [ /* ... */ ],
)
```

For a mobile hamburger drawer, place the menu inside `Scaffold.drawer`.

### Loading & Empty States

```dart
// Skeleton placeholders while data loads.
InnovareSideMenu(
  isLoading: true,
  loadingItemCount: 6,
  sections: const [],
)

// Custom empty state when no items are visible (e.g. after permission filtering).
InnovareSideMenu(
  emptyState: const Center(child: Text('No menu items')),
  sections: sections,
)
```

### Disabled Items

```dart
InnovareSideMenuItem(
  id: 'reports',
  icon: Icons.bar_chart,
  title: 'Reports (soon)',
  enabled: false, // dimmed, non-focusable, taps ignored, announced as disabled
)
```

### Accessibility

```dart
InnovareSideMenu(
  semanticsLabel: 'Main navigation', // labels the whole region for screen readers
  sections: [
    InnovareSideMenuSection(
      items: [
        InnovareSideMenuItem(
          id: 'inbox',
          icon: Icons.inbox,
          title: 'Inbox',
          badge: InnovareSideMenuBadge.count(12),
          // Announced as "Inbox, 12 notifications".
          onTap: () {},
        ),
      ],
    ),
  ],
)
```

Items expose an `accessibleLabel` that combines `semanticLabel` (or `title`) with a short badge description. All motion honors `MediaQuery.disableAnimations`.

### Frosted Glass, Density & Typography

Every visual is a token on `InnovareSideMenuStyle`:

```dart
InnovareSideMenu(
  style: InnovareSideMenuThemes.glassmorphism().copyWith(
    // Real frosted glass: blurs whatever is rendered behind the rail.
    backdropBlur: 20,
    // Tune item spacing.
    visualDensity: VisualDensity.compact,
    // Full base label typography (active/inactive color, size & weight layer on top).
    itemTextStyle: const TextStyle(letterSpacing: 0.2, height: 1.2),
  ),
  sections: [ /* ... */ ],
)
```

> `backdropBlur` needs something behind the rail to blur — use it over a gradient or image background with a translucent `decoration` color (the `glassmorphism()` theme already sets one).

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
| `controller` | `InnovareSideMenuController?` | Imperative collapse/section control (overrides `mode` when set) |
| `isLoading` | `bool` | Render skeleton placeholders (default: `false`) |
| `loadingItemCount` | `int` | Number of skeleton rows while loading (default: `6`) |
| `emptyState` | `Widget?` | Shown when no items are visible after filtering |
| `semanticsLabel` | `String?` | Accessibility label for the navigation region |
| `currentRoute` | `String?` | Current route, to match active items by `route` |

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
| `enabled` | `bool` | Interactive state; `false` dims and disables (default: `true`) |
| `tooltip` | `String?` | Hover tooltip (defaults to `title`) |
| `route` | `String?` | Route key for active-by-route matching |
| `trailing` | `Widget?` | Trailing widget |
| `customLeading` | `Widget?` | Replaces the default leading icon |

### `InnovareSideMenuSection`

| Parameter | Type | Description |
|-----------|------|-------------|
| `items` | `List<InnovareSideMenuItem>` | Items in the section (required) |
| `title` | `String?` | Section title (expanded mode) |
| `collapsible` | `bool` | Tappable collapsible header; needs a `title` (default: `false`) |
| `initiallyExpanded` | `bool` | Starting state when `collapsible` (default: `true`) |

### `InnovareSideMenuController`

A `ChangeNotifier` for imperative control — construct it, pass it to `InnovareSideMenu(controller: ...)`, and dispose it yourself.

```dart
InnovareSideMenuController({
  bool collapsed = false,
  Iterable<String> collapsedSections = const [],
})
```

| Member | Description |
|--------|-------------|
| `collapse()` / `expand()` / `toggleCollapsed()` | Control the rail collapse state |
| `setCollapsed(bool)` | Set the collapse state explicitly |
| `isCollapsed` / `isExpanded` | Current collapse state |
| `collapseSection(title)` / `expandSection(title)` / `toggleSection(title)` | Open/close a collapsible section |
| `isSectionCollapsed(title)` / `isSectionExpanded(title)` | Query a section's state |

### `InnovareSideMenuStyle`

Comprehensive styling class with 60+ properties covering the container, header/footer, sections, items, sub-items, collapsed mode and badges — plus motion (`stateAnimationDuration`, `animateOnAppear`, `appearStaggerInterval`, `pressedScale`, `hoverScale`, `enableHaptics`), layout (`expandOnHover`, `autoCollapseBelowWidth`, `disabledOpacity`) and visuals (`backdropBlur`, `visualDensity`, `itemTextStyle`, `subItemTextStyle`). Use `copyWith()` to customize or start from a theme factory.

### `InnovareSideMenuThemes`

Extension on `InnovareSideMenuStyle` with these factory constructors:

- `darkDefault()` — Dark gradient with blue accents
- `lightDefault()` — Light background with blue active items
- `fromTheme(ThemeData)` — Adapts to any Flutter `ThemeData`
- `fromInnovare(InnovareDesignTheme)` — Derives the style from Innovare Design System tokens (brand, shape, type, depth, motion)
- `minimal()` — Clean, borderless design with left-border active indicator
- `glassmorphism()` — Translucent glass effect with rounded corners

## Example

See the [example app](example/) for a full interactive demo with theme switching, mode toggle, collapsible sections, hover-expand, responsive auto-rail, loading state, badges, and permission simulation.

```bash
cd example
flutter run -d chrome
```

## License

MIT — see [LICENSE](LICENSE) for details.
