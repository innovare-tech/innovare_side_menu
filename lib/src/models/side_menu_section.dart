import 'side_menu_item.dart';

/// A logical grouping of menu items within [InnovareSideMenu].
///
/// Sections can have an optional [title] displayed above the items.
/// In collapsed mode, sections are separated by dividers instead of titles.
class InnovareSideMenuSection {
  /// Optional title displayed above the section items in expanded mode.
  final String? title;

  /// The list of menu items in this section.
  final List<InnovareSideMenuItem> items;

  /// Creates a menu section.
  ///
  /// The [items] parameter is required. The [title] is optional and only
  /// displayed in expanded mode.
  const InnovareSideMenuSection({this.title, required this.items});
}
