## 1.1.0

- Add `InnovareSideMenuThemes.fromInnovare(InnovareDesignTheme)` — derives the
  menu style directly from the [Innovare Design System](https://github.com/innovare-tech/innovare_design)
  tokens (brand color, corner shape, type scale, depth and motion personality),
  so the menu re-skins per client from a single source of truth.
- Add `innovare_design` as a dependency (used by the new factory).
- Raise minimum SDK to Dart 3.6 / Flutter 3.27 (required by `innovare_design`).
- Motion: items now animate their active/hover state (decoration, label and
  icon color crossfade) and cascade into view on first appearance. Honors
  `MediaQuery.disableAnimations` (reduce motion). Tunable via new
  `InnovareSideMenuStyle` fields `stateAnimationDuration`, `animateOnAppear`,
  `appearAnimationDuration` and `appearStaggerInterval`. `fromInnovare` maps
  these from the client's motion personality.
- Tactile feedback: items respond to touch with a subtle press scale
  (`pressedScale`, default 0.97), an optional hover scale (`hoverScale`) and a
  selection haptic on tap (`enableHaptics`, default true) — including the
  collapsed rail and expandable rows.
- Fix (collapsed mode): selecting a sub-item in the fly-out popup now dismisses
  the popup, and a collapsed parent reads as active while its popup is open or
  when any of its sub-items is active.
- Auto scroll-to-active: the menu reveals the active item on mount and whenever
  it changes (`autoScrollToActive`, default true). Items keep stable keys so the
  appearance animation never re-runs on selection changes.
- Collapsible sections: set `collapsible: true` (and optional `initiallyExpanded`)
  on an `InnovareSideMenuSection` to render a tappable header with a rotating
  chevron that rolls its items in/out (expanded mode). Reduce-motion aware.
- Hover-to-expand: set `expandOnHover: true` so a collapsed rail expands in place
  while the pointer hovers it (desktop/web), revealing labels via the existing
  width transition, then collapses on exit.
- Responsive auto-rail: set `autoCollapseBelowWidth` so the menu auto-collapses
  to a rail on narrow screens regardless of `mode`. For a mobile hamburger
  drawer, place the menu inside `Scaffold.drawer`.
- Keyboard navigation: arrow keys move focus between items, Home/End jump to the
  first/last item, and Enter/Space activate. The menu is a scoped focus
  traversal group and each item is now a single focus stop (the inner `ListTile`
  is excluded from traversal), fixing erratic arrow-key focus.

## 1.0.1

- Fix layout overflow errors during expanded/collapsed mode transitions
- Use `LayoutBuilder` to switch content based on actual animated width instead of boolean flag
- Add `clipBehavior: Clip.hardEdge` to `AnimatedContainer` as safety net
- Add `overflow: TextOverflow.clip` and `maxLines: 1` to section titles

## 1.0.0

- Initial release
- Expanded and collapsed (rail) modes
- 5 built-in themes
- Badge support (count, dot, custom)
- Permission-based filtering
- Full accessibility support

## 0.0.1

- Initial development release.
