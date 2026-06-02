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
