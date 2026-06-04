import '../models/side_menu_item.dart';
import '../models/side_menu_section.dart';

bool shouldShowItem(
  InnovareSideMenuItem item,
  bool Function(String permission)? permissionChecker,
) {
  final hasSubItems = item.subItems != null && item.subItems!.isNotEmpty;
  if (hasSubItems) {
    return item.subItems!.any((sub) => shouldShowItem(sub, permissionChecker));
  }

  if (item.permission != null &&
      permissionChecker != null &&
      !permissionChecker(item.permission!)) {
    return false;
  }
  // `permissionsAny` aplica semântica **OR** — o item é exibido se
  // **pelo menos uma** das permissões na lista for autorizada pelo
  // [permissionChecker]. Quando `permission` E `permissionsAny` são
  // fornecidos, AMBOS precisam passar (AND da `permission` única com
  // o OR da lista).
  if (item.permissionsAny != null &&
      item.permissionsAny!.isNotEmpty &&
      permissionChecker != null &&
      !item.permissionsAny!.any(permissionChecker)) {
    return false;
  }
  return true;
}

bool shouldShowSection(
  InnovareSideMenuSection section,
  bool Function(String permission)? permissionChecker,
) {
  return section.items.any((item) => shouldShowItem(item, permissionChecker));
}
