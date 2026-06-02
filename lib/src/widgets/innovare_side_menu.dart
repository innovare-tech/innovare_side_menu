import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/side_menu_item.dart';
import '../models/side_menu_mode.dart';
import '../models/side_menu_section.dart';
import '../styles/side_menu_style.dart';
import '../utils/permission_filter.dart';
import 'collapsed_menu_item.dart';
import 'expandable_menu_item.dart';
import 'simple_menu_item.dart';

/// A declarative, customizable side menu widget for Flutter.
///
/// Displays a vertical navigation menu with sections, hierarchical items,
/// badges, and permission-based filtering. Supports both [InnovareSideMenuMode.expanded]
/// and [InnovareSideMenuMode.collapsed] modes with animated transitions.
///
/// {@tool snippet}
/// ```dart
/// InnovareSideMenu(
///   style: InnovareSideMenuThemes.darkDefault(),
///   sections: [
///     InnovareSideMenuSection(
///       title: 'MAIN',
///       items: [
///         InnovareSideMenuItem(
///           id: 'home',
///           icon: Icons.home,
///           title: 'Home',
///           isActive: true,
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
class InnovareSideMenu extends StatefulWidget {
  /// The list of sections to display in the menu.
  final List<InnovareSideMenuSection> sections;

  /// Visual styling configuration. Defaults to [InnovareSideMenuStyle] with
  /// default values if not provided.
  final InnovareSideMenuStyle style;

  /// The current route for matching active items by route.
  final String? currentRoute;

  /// Custom scroll physics for the menu's [ListView].
  final ScrollPhysics? scrollPhysics;

  /// Callback to determine if an item with a given permission should be shown.
  ///
  /// If `null`, all items are visible regardless of their [InnovareSideMenuItem.permission].
  final bool Function(String permission)? permissionChecker;

  /// Widget displayed at the top of the menu in expanded mode.
  final Widget? header;

  /// Widget displayed at the bottom of the menu in expanded mode.
  final Widget? footer;

  /// Widget displayed at the top of the menu in collapsed mode.
  final Widget? collapsedHeader;

  /// Widget displayed at the bottom of the menu in collapsed mode.
  final Widget? collapsedFooter;

  /// The current display mode. Defaults to [InnovareSideMenuMode.expanded].
  final InnovareSideMenuMode mode;

  /// Duration of the animated transition between expanded and collapsed modes.
  ///
  /// Defaults to `Duration(milliseconds: 300)`.
  final Duration? modeTransitionDuration;

  /// Accessibility label announced for the navigation region as a whole, e.g.
  /// "Main navigation". When `null` (default) no region label is added.
  final String? semanticsLabel;

  /// Creates an [InnovareSideMenu].
  ///
  /// The [sections] parameter is required.
  const InnovareSideMenu({
    super.key,
    required this.sections,
    InnovareSideMenuStyle? style,
    this.currentRoute,
    this.scrollPhysics,
    this.permissionChecker,
    this.header,
    this.footer,
    this.collapsedHeader,
    this.collapsedFooter,
    this.mode = InnovareSideMenuMode.expanded,
    this.modeTransitionDuration,
    this.semanticsLabel,
  }) : style = style ?? const InnovareSideMenuStyle();

  @override
  State<InnovareSideMenu> createState() => _InnovareSideMenuState();
}

class _InnovareSideMenuState extends State<InnovareSideMenu> {
  final ScrollController _scrollController = ScrollController();

  /// Stable [GlobalKey] per top-level item id, so wrapping items in a
  /// [KeyedSubtree] keeps their element/state identity across selection
  /// changes (no re-running the appear animation) while still letting us
  /// locate the active row for [Scrollable.ensureVisible].
  final Map<String, GlobalKey> _itemKeys = {};

  String? _scrolledToActiveId;

  /// Titles of sections currently collapsed (collapsible sections only).
  final Set<String> _collapsedSections = {};

  /// Whether the pointer is hovering the rail (drives expand-on-hover).
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    for (final section in widget.sections) {
      if (section.collapsible &&
          section.title != null &&
          !section.initiallyExpanded) {
        _collapsedSections.add(section.title!);
      }
    }
  }

  bool get _isCollapsed => widget.mode == InnovareSideMenuMode.collapsed;

  Duration get _transitionDuration =>
      widget.modeTransitionDuration ?? const Duration(milliseconds: 300);

  /// Scopes focus traversal to the menu so Home/End can target its edges.
  final FocusScopeNode _menuScope =
      FocusScopeNode(debugLabel: 'InnovareSideMenu');

  @override
  void dispose() {
    _menuScope.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  GlobalKey _keyFor(String id) => _itemKeys.putIfAbsent(id, () => GlobalKey());

  /// Moves focus to the first or last focusable item (Home/End keys).
  void _focusEdgeItem({required bool first}) {
    final nodes = _menuScope.traversalDescendants.toList();
    if (nodes.isEmpty) return;
    (first ? nodes.first : nodes.last).requestFocus();
  }

  void _toggleSection(String title) {
    if (widget.style.enableHaptics) HapticFeedback.selectionClick();
    setState(() {
      if (!_collapsedSections.remove(title)) {
        _collapsedSections.add(title);
      }
    });
  }

  /// Computa a rota mais específica (mais longa) dentre todos os itens
  /// declarados nas `sections` que dá match com `currentRoute` (match
  /// exato OU prefixo com separador `/`). Usada por `_resolveActiveState`
  /// para resolver conflitos onde múltiplos itens casariam por prefix.
  ///
  /// Exemplo: dado `currentRoute = '/home/settings/tags'`, e itens
  /// `settings` (`/home/settings`) + `tags` (`/home/settings/tags`), ambos
  /// "casam" via prefix. Sem esta resolução ambos ficariam ativos. Com
  /// ela, apenas `/home/settings/tags` (maior tamanho) fica ativo —
  /// comportamento esperado de breadcrumb invertido.
  ///
  /// Retorna `null` se nenhum item dá match, caso em que o usuário está
  /// numa rota não declarada no menu (ex.: detalhes de entidade) —
  /// ninguém fica ativo.
  String? _findLongestMatchingRoute() {
    final currentRoute = widget.currentRoute;
    if (currentRoute == null || currentRoute.isEmpty) return null;

    String? best;
    void visit(InnovareSideMenuItem item) {
      final route = item.route;
      if (route != null && route.isNotEmpty) {
        final isMatch =
            currentRoute == route || currentRoute.startsWith('$route/');
        if (isMatch && (best == null || route.length > best!.length)) {
          best = route;
        }
      }
      final subs = item.subItems;
      if (subs != null) {
        for (final sub in subs) {
          visit(sub);
        }
      }
    }

    for (final section in widget.sections) {
      for (final item in section.items) {
        visit(item);
      }
    }
    return best;
  }

  /// Id of the first visible top-level item that is active (itself, a
  /// descendant, or an ancestor of the active route). Drives scroll-to-active.
  String? _activeTopLevelId(String? longestMatch) {
    for (final section in widget.sections) {
      if (!shouldShowSection(section, widget.permissionChecker)) continue;
      for (final item in section.items) {
        if (!shouldShowItem(item, widget.permissionChecker)) continue;
        if (_isActiveOrAncestor(item, longestMatch)) return item.id;
      }
    }
    return null;
  }

  bool _isActiveOrAncestor(InnovareSideMenuItem item, String? longestMatch) {
    if (_resolveActiveState(item, longestMatch).isActive) return true;
    if (_hasActiveDescendant(item)) return true;
    return _isRouteAncestor(item, longestMatch);
  }

  bool _hasActiveDescendant(InnovareSideMenuItem item) {
    final subs = item.subItems;
    if (subs == null) return false;
    for (final sub in subs) {
      if (sub.isActive || _hasActiveDescendant(sub)) return true;
    }
    return false;
  }

  bool _isRouteAncestor(InnovareSideMenuItem item, String? longestMatch) {
    if (longestMatch == null) return false;
    final subs = item.subItems;
    if (subs == null) return false;
    for (final sub in subs) {
      if (sub.route == longestMatch || _isRouteAncestor(sub, longestMatch)) {
        return true;
      }
    }
    return false;
  }

  /// Schedules a post-frame [Scrollable.ensureVisible] on the active row when
  /// it changes. No-op if it has not moved, the row isn't built yet, or the
  /// list can't scroll (the call is harmless in that case).
  void _scheduleScrollToActive(BuildContext context, String? activeId) {
    if (activeId == null || activeId == _scrolledToActiveId) return;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctx = _itemKeys[activeId]?.currentContext;
      if (ctx == null) return;
      _scrolledToActiveId = activeId;
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.5,
        duration:
            reduceMotion ? Duration.zero : const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    // Responsive auto-rail: collapse below a screen-width breakpoint, no matter
    // what `mode` says.
    final screenWidth = MediaQuery.maybeSizeOf(context)?.width;
    final autoCollapse = style.autoCollapseBelowWidth != null &&
        screenWidth != null &&
        screenWidth < style.autoCollapseBelowWidth!;
    final collapsed = _isCollapsed || autoCollapse;
    final hoverExpand = collapsed && style.expandOnHover;
    final effectiveCollapsed = collapsed && !(hoverExpand && _hovering);
    final targetWidth =
        effectiveCollapsed ? style.collapsedWidth : style.width;
    // Computa uma única vez por build. Evita O(N) por item nos re-renders
    // de `_resolveActiveState` — custo amortizado no hot path.
    final longestMatch = _findLongestMatchingRoute();

    if (style.autoScrollToActive) {
      _scheduleScrollToActive(context, _activeTopLevelId(longestMatch));
    }

    final Widget menu = AnimatedContainer(
      duration: _transitionDuration,
      curve: Curves.easeInOut,
      width: targetWidth,
      height: double.infinity,
      padding: style.padding,
      decoration: style.decoration,
      clipBehavior: style.decoration != null ? Clip.hardEdge : Clip.none,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Switch content based on actual animated width, not the boolean flag,
          // to prevent overflow during the width transition animation.
          final widthThreshold = (style.width + style.collapsedWidth) / 2;
          final showCollapsed = constraints.maxWidth < widthThreshold;

          final activeHeader =
              showCollapsed ? widget.collapsedHeader : widget.header;
          final activeFooter =
              showCollapsed ? widget.collapsedFooter : widget.footer;

          return Column(
            children: [
              if (activeHeader != null)
                Container(
                  padding: style.headerPadding,
                  decoration: style.headerDecoration ??
                      (style.headerDivider != null
                          ? BoxDecoration(
                              border: Border(bottom: style.headerDivider!),
                            )
                          : null),
                  child: activeHeader,
                ),
              Expanded(
                // A SingleChildScrollView (not a lazy ListView) so every row is
                // mounted — keeps a bounded nav menu's stable keys reachable for
                // scroll-to-active regardless of viewport size.
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: style.sectionPadding,
                  physics: widget.scrollPhysics,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildListChildren(showCollapsed, longestMatch),
                  ),
                ),
              ),
              if (activeFooter != null)
                Container(
                  padding: style.footerPadding,
                  decoration: style.footerDecoration ??
                      (style.footerDivider != null
                          ? BoxDecoration(
                              border: Border(top: style.footerDivider!),
                            )
                          : null),
                  child: activeFooter,
                ),
            ],
          );
        },
      ),
    );

    Widget result = menu;
    if (hoverExpand) {
      result = MouseRegion(
        onEnter: (_) {
          if (!_hovering) setState(() => _hovering = true);
        },
        onExit: (_) {
          if (_hovering) setState(() => _hovering = false);
        },
        child: result,
      );
    }

    // Scope focus traversal to the menu and add Home/End shortcuts. Arrow keys
    // already move focus directionally via the app's default shortcuts.
    final Widget navigation = FocusScope(
      node: _menuScope,
      child: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.home): () =>
                _focusEdgeItem(first: true),
            const SingleActivator(LogicalKeyboardKey.end): () =>
                _focusEdgeItem(first: false),
          },
          child: result,
        ),
      ),
    );

    final semanticsLabel = widget.semanticsLabel;
    if (semanticsLabel == null) return navigation;
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: semanticsLabel,
      child: navigation,
    );
  }

  /// Flattens the visible sections/items into a single child list, wrapping
  /// each item in an [_Appear] so they cascade into view (staggered by index)
  /// and a [KeyedSubtree] with a stable key for scroll-to-active. Collapsible
  /// sections render a tappable header and roll their items in/out.
  List<Widget> _buildListChildren(bool showCollapsed, String? longestMatch) {
    final style = widget.style;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final children = <Widget>[];
    var appearIndex = 0;

    Widget buildItem(InnovareSideMenuItem item) {
      return KeyedSubtree(
        key: _keyFor(item.id),
        child: _Appear(
          index: appearIndex++,
          enabled: style.animateOnAppear,
          duration: style.appearAnimationDuration,
          interval: style.appearStaggerInterval,
          child: _buildMenuItem(item, showCollapsed, longestMatch),
        ),
      );
    }

    for (var i = 0; i < widget.sections.length; i++) {
      final section = widget.sections[i];
      if (!shouldShowSection(section, widget.permissionChecker)) continue;

      final visibleItems = [
        for (final item in section.items)
          if (shouldShowItem(item, widget.permissionChecker)) item,
      ];

      if (showCollapsed) {
        if (i > 0) children.add(const Divider(height: 1));
        children.addAll(visibleItems.map(buildItem));
        continue;
      }

      final collapsible = section.collapsible && section.title != null;
      final expanded =
          !collapsible || !_collapsedSections.contains(section.title);

      if (section.title != null) {
        children.add(
          collapsible
              ? _SectionHeader(
                  title: section.title!,
                  style: style,
                  expanded: expanded,
                  onTap: () => _toggleSection(section.title!),
                )
              : Padding(
                  padding: style.sectionTitlePadding ?? EdgeInsets.zero,
                  child: Text(
                    section.title!,
                    style: style.sectionTitleStyle,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
        );
      }

      final itemWidgets = visibleItems.map(buildItem).toList();

      if (collapsible) {
        children.add(
          _CollapsibleBody(
            expanded: expanded,
            duration: _transitionDuration,
            reduceMotion: reduceMotion,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemWidgets,
            ),
          ),
        );
      } else {
        children.addAll(itemWidgets);
      }
    }
    return children;
  }

  Widget _buildMenuItem(
    InnovareSideMenuItem item,
    bool showCollapsed,
    String? longestMatch,
  ) {
    final style = widget.style;
    // Auto-match: se currentRoute corresponde ao item.route E esse item
    // tem a rota mais específica dentre todos os matches, marca como
    // active. Isso evita que múltiplos itens (pai + filho) fiquem ativos
    // simultaneamente quando um é prefixo do outro.
    final resolvedItem = _resolveActiveState(item, longestMatch);

    if (showCollapsed) {
      return CollapsedMenuItem(
        item: resolvedItem,
        style: style,
        permissionChecker: widget.permissionChecker,
      );
    }

    final hasSubItems =
        resolvedItem.subItems != null && resolvedItem.subItems!.isNotEmpty;

    if (hasSubItems) {
      return ExpandableMenuItem(
        item: resolvedItem,
        style: style,
        currentRoute: widget.currentRoute,
        permissionChecker: widget.permissionChecker,
      );
    }

    return SimpleMenuItem(
      item: resolvedItem,
      style: style,
      isSubItem: false,
      isCollapsed: showCollapsed,
      transitionDuration: _transitionDuration,
    );
  }

  InnovareSideMenuItem _resolveActiveState(
    InnovareSideMenuItem item,
    String? longestMatch,
  ) {
    final currentRoute = widget.currentRoute;
    if (currentRoute == null || currentRoute.isEmpty) return item;
    if (item.route == null) return item;

    // Só fica ativo se este item tem EXATAMENTE a rota mais específica
    // dentre todos os matches. Itens que casariam por prefix (pais de
    // outro item ativo) perdem o active — evita double-highlight quando
    // dois itens do menu estão em rotas prefixadas.
    final isMatch = longestMatch != null && item.route == longestMatch;

    if (isMatch && !item.isActive) {
      return item.copyWith(isActive: true);
    }
    if (!isMatch && item.isActive) {
      return item.copyWith(isActive: false);
    }

    return item;
  }
}

/// A one-time fade + slide-in used to stagger menu items into view.
///
/// Animates only on first mount; subsequent rebuilds (e.g. selection changes)
/// keep the item fully visible. Honors `MediaQuery.disableAnimations`.
class _Appear extends StatefulWidget {
  final int index;
  final bool enabled;
  final Duration duration;
  final Duration interval;
  final Widget child;

  const _Appear({
    required this.index,
    required this.enabled,
    required this.duration,
    required this.interval,
    required this.child,
  });

  @override
  State<_Appear> createState() => _AppearState();
}

class _AppearState extends State<_Appear> with SingleTickerProviderStateMixin {
  static const _maxStaggerDelay = Duration(milliseconds: 360);

  late final AnimationController _controller = AnimationController(vsync: this);
  Animation<double> _animation = const AlwaysStoppedAnimation<double>(1);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (!widget.enabled || reduceMotion || widget.duration == Duration.zero) {
      return;
    }
    var delay = widget.interval * widget.index;
    if (delay > _maxStaggerDelay) delay = _maxStaggerDelay;
    // Fold the stagger delay into the curve (an Interval that stays flat for
    // the delay, then eases in) so we never schedule a raw timer — keeps the
    // widget test-friendly (no pending timers) while still cascading.
    final total = delay + widget.duration;
    _controller.duration = total;
    final startFraction =
        total.inMicroseconds == 0 ? 0.0 : delay.inMicroseconds / total.inMicroseconds;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(startFraction, 1, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        final t = _animation.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 8),
            child: child,
          ),
        );
      },
    );
  }
}

/// A tappable section title with a chevron that rotates with the
/// expanded/collapsed state. Used for collapsible sections in expanded mode.
class _SectionHeader extends StatelessWidget {
  final String title;
  final InnovareSideMenuStyle style;
  final bool expanded;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.style,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      expanded: expanded,
      child: InkWell(
        onTap: onTap,
        borderRadius: style.itemBorderRadius,
        child: Padding(
          padding: style.sectionTitlePadding ?? EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: style.sectionTitleStyle,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
              ),
              AnimatedRotation(
                turns: expanded ? 0.0 : -0.25,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: style.sectionTitleStyle?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rolls its [child] in/out vertically by animating a clipped height factor,
/// keeping the child mounted so its state (and stable keys) survive toggles.
class _CollapsibleBody extends StatelessWidget {
  final bool expanded;
  final Duration duration;
  final bool reduceMotion;
  final Widget child;

  const _CollapsibleBody({
    required this.expanded,
    required this.duration,
    required this.reduceMotion,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        alignment: Alignment.topCenter,
        heightFactor: expanded ? 1.0 : 0.0,
        duration: reduceMotion ? Duration.zero : duration,
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }
}
