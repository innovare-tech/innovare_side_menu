import 'package:flutter/material.dart';
import 'package:innovare_side_menu/innovare_side_menu.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovare Side Menu Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const ExampleScreen(),
    );
  }
}

enum ThemeOption {
  darkDefault('Dark Default'),
  lightDefault('Light Default'),
  fromTheme('From ThemeData'),
  minimal('Minimal'),
  glassmorphism('Glassmorphism');

  final String label;
  const ThemeOption(this.label);
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  ThemeOption _selectedTheme = ThemeOption.darkDefault;
  InnovareSideMenuMode _mode = InnovareSideMenuMode.expanded;
  String _activeItemId = 'dashboard';
  bool _isAdmin = true;
  String _contentTitle = 'Dashboard';

  InnovareSideMenuStyle _getStyle(BuildContext context) {
    switch (_selectedTheme) {
      case ThemeOption.darkDefault:
        return InnovareSideMenuThemes.darkDefault();
      case ThemeOption.lightDefault:
        return InnovareSideMenuThemes.lightDefault();
      case ThemeOption.fromTheme:
        return InnovareSideMenuThemes.fromTheme(Theme.of(context));
      case ThemeOption.minimal:
        return InnovareSideMenuThemes.minimal();
      case ThemeOption.glassmorphism:
        return InnovareSideMenuThemes.glassmorphism();
    }
  }

  void _onItemTap(String id, String title) {
    setState(() {
      _activeItemId = id;
      _contentTitle = title;
    });
  }

  List<InnovareSideMenuSection> _buildSections() {
    return [
      InnovareSideMenuSection(
        title: 'MAIN',
        items: [
          InnovareSideMenuItem(
            id: 'dashboard',
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            isActive: _activeItemId == 'dashboard',
            onTap: () => _onItemTap('dashboard', 'Dashboard'),
          ),
          InnovareSideMenuItem(
            id: 'inbox',
            icon: Icons.inbox_outlined,
            title: 'Inbox',
            badge: const InnovareSideMenuBadge.count(12),
            isActive: _activeItemId == 'inbox',
            onTap: () => _onItemTap('inbox', 'Inbox'),
          ),
          InnovareSideMenuItem(
            id: 'calendar',
            icon: Icons.calendar_today_outlined,
            title: 'Calendar',
            badge: const InnovareSideMenuBadge.dot(),
            isActive: _activeItemId == 'calendar',
            onTap: () => _onItemTap('calendar', 'Calendar'),
          ),
        ],
      ),
      InnovareSideMenuSection(
        title: 'CONTENT',
        items: [
          InnovareSideMenuItem(
            id: 'products',
            icon: Icons.inventory_2_outlined,
            title: 'Products',
            subItems: [
              InnovareSideMenuItem(
                id: 'catalog',
                icon: Icons.list_outlined,
                title: 'Catalog',
                isActive: _activeItemId == 'catalog',
                onTap: () => _onItemTap('catalog', 'Product Catalog'),
              ),
              InnovareSideMenuItem(
                id: 'categories',
                icon: Icons.category_outlined,
                title: 'Categories',
                isActive: _activeItemId == 'categories',
                onTap: () => _onItemTap('categories', 'Categories'),
              ),
              InnovareSideMenuItem(
                id: 'inventory',
                icon: Icons.warehouse_outlined,
                title: 'Inventory',
                isActive: _activeItemId == 'inventory',
                onTap: () => _onItemTap('inventory', 'Inventory'),
              ),
            ],
          ),
          InnovareSideMenuItem(
            id: 'orders',
            icon: Icons.shopping_cart_outlined,
            title: 'Orders',
            badge: const InnovareSideMenuBadge.count(3),
            isActive: _activeItemId == 'orders',
            onTap: () => _onItemTap('orders', 'Orders'),
          ),
        ],
      ),
      InnovareSideMenuSection(
        title: 'ADMIN',
        items: [
          InnovareSideMenuItem(
            id: 'users',
            icon: Icons.people_outlined,
            title: 'Users',
            permission: 'admin',
            isActive: _activeItemId == 'users',
            onTap: () => _onItemTap('users', 'User Management'),
          ),
          InnovareSideMenuItem(
            id: 'settings',
            icon: Icons.settings_outlined,
            title: 'Settings',
            permission: 'admin',
            subItems: [
              InnovareSideMenuItem(
                id: 'general',
                icon: Icons.tune_outlined,
                title: 'General',
                permission: 'admin',
                isActive: _activeItemId == 'general',
                onTap: () => _onItemTap('general', 'General Settings'),
              ),
              InnovareSideMenuItem(
                id: 'security',
                icon: Icons.security_outlined,
                title: 'Security',
                permission: 'admin',
                isActive: _activeItemId == 'security',
                onTap: () => _onItemTap('security', 'Security Settings'),
              ),
            ],
          ),
          InnovareSideMenuItem(
            id: 'logs',
            icon: Icons.article_outlined,
            title: 'Audit Logs',
            permission: 'admin',
            isActive: _activeItemId == 'logs',
            onTap: () => _onItemTap('logs', 'Audit Logs'),
          ),
        ],
      ),
    ];
  }

  bool _needsDarkBackground() {
    return _selectedTheme == ThemeOption.darkDefault ||
        _selectedTheme == ThemeOption.glassmorphism;
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(context);
    final darkBg = _needsDarkBackground();

    return Scaffold(
      backgroundColor: darkBg ? const Color(0xFF0a0a0a) : null,
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: InnovareSideMenu(
              style: style,
              mode: _mode,
              modeTransitionDuration: const Duration(milliseconds: 300),
              permissionChecker: (permission) {
                if (permission == 'admin') return _isAdmin;
                return true;
              },
              header: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.hexagon_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Innovare',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: darkBg ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              collapsedHeader: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.hexagon_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        'J',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: darkBg
                              ? Colors.white.withValues(alpha: 0.8)
                              : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              collapsedFooter: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      'J',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              sections: _buildSections(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildToolbar(),
                  const SizedBox(height: 24),
                  Text(
                    _contentTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selected item: $_activeItemId',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.touch_app_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap a menu item to navigate',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        DropdownButton<ThemeOption>(
          value: _selectedTheme,
          underline: const SizedBox.shrink(),
          borderRadius: BorderRadius.circular(8),
          items: ThemeOption.values.map((t) {
            return DropdownMenuItem(value: t, child: Text(t.label));
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedTheme = value);
          },
        ),
        FilledButton.tonalIcon(
          onPressed: () {
            setState(() {
              _mode = _mode == InnovareSideMenuMode.expanded
                  ? InnovareSideMenuMode.collapsed
                  : InnovareSideMenuMode.expanded;
            });
          },
          icon: Icon(
            _mode == InnovareSideMenuMode.expanded
                ? Icons.view_sidebar_outlined
                : Icons.menu,
          ),
          label: Text(
            _mode == InnovareSideMenuMode.expanded ? 'Collapse' : 'Expand',
          ),
        ),
        FilterChip(
          label: const Text('Admin Mode'),
          selected: _isAdmin,
          onSelected: (value) => setState(() => _isAdmin = value),
        ),
      ],
    );
  }
}
