import 'package:flutter/foundation.dart';

/// Imperatively controls an `InnovareSideMenu`: collapse/expand the rail and
/// open/close collapsible sections from your own code (for example, a hamburger
/// button in an app bar).
///
/// Provide it via `InnovareSideMenu(controller: controller, ...)`. When a
/// controller is attached it becomes the source of truth for the collapse state
/// (overriding `mode`) and for which collapsible sections are open, so seed the
/// desired starting state through this constructor. You own the controller's
/// lifecycle — remember to call [dispose].
///
/// ```dart
/// final controller = InnovareSideMenuController(collapsed: false);
///
/// IconButton(
///   icon: const Icon(Icons.menu),
///   onPressed: controller.toggleCollapsed,
/// );
/// ```
class InnovareSideMenuController extends ChangeNotifier {
  /// Creates a controller, optionally starting [collapsed] and with a set of
  /// initially [collapsedSections] (by section title).
  InnovareSideMenuController({
    bool collapsed = false,
    Iterable<String> collapsedSections = const [],
  })  : _collapsed = collapsed,
        _collapsedSections = {...collapsedSections};

  bool _collapsed;
  final Set<String> _collapsedSections;

  /// Whether the rail is currently collapsed (icons only).
  bool get isCollapsed => _collapsed;

  /// Whether the rail is currently expanded (labels visible).
  bool get isExpanded => !_collapsed;

  /// Collapses the rail to an icon-only rail.
  void collapse() => setCollapsed(true);

  /// Expands the rail to show labels.
  void expand() => setCollapsed(false);

  /// Toggles between collapsed and expanded.
  void toggleCollapsed() => setCollapsed(!_collapsed);

  /// Sets the collapsed state explicitly. Notifies listeners only on change.
  void setCollapsed(bool value) {
    if (_collapsed == value) return;
    _collapsed = value;
    notifyListeners();
  }

  /// Whether the collapsible section with [title] is currently collapsed.
  bool isSectionCollapsed(String title) => _collapsedSections.contains(title);

  /// Whether the collapsible section with [title] is currently expanded.
  bool isSectionExpanded(String title) => !_collapsedSections.contains(title);

  /// Collapses the section with [title]. Notifies listeners only on change.
  void collapseSection(String title) {
    if (_collapsedSections.add(title)) notifyListeners();
  }

  /// Expands the section with [title]. Notifies listeners only on change.
  void expandSection(String title) {
    if (_collapsedSections.remove(title)) notifyListeners();
  }

  /// Toggles the collapsed state of the section with [title].
  void toggleSection(String title) {
    if (!_collapsedSections.remove(title)) _collapsedSections.add(title);
    notifyListeners();
  }
}
