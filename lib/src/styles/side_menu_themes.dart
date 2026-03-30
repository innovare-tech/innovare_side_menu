import 'package:flutter/material.dart';

import 'side_menu_style.dart';

/// Built-in theme factories for [InnovareSideMenuStyle].
///
/// Provides 5 ready-to-use themes:
/// - [darkDefault] — Dark gradient with blue accents.
/// - [fromTheme] — Adapts to any Flutter [ThemeData].
/// - [lightDefault] — Light background with blue active items.
/// - [minimal] — Clean, borderless design with left-border indicator.
/// - [glassmorphism] — Translucent glass effect.
extension InnovareSideMenuThemes on InnovareSideMenuStyle {
  /// Dark theme with gradient background, blue accent active items,
  /// and white text. Suitable for dark-mode applications.
  static InnovareSideMenuStyle darkDefault() {
    return InnovareSideMenuStyle(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1a1a1a), Color(0xFF0f0f0f)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(5, 0),
          ),
        ],
      ),
      headerPadding: EdgeInsets.all(20),
      headerDivider:
          BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      footerPadding: EdgeInsets.all(12),
      footerDivider:
          BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      sectionTitleStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      sectionTitlePadding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
      sectionPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemMargin: EdgeInsets.only(bottom: 2),
      itemBorderRadius: BorderRadius.circular(10),
      itemIconSize: 18,
      itemIconPadding: EdgeInsets.all(8),
      itemIconBorderRadius: BorderRadius.circular(8),
      activeItemDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade500, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      activeItemTextColor: Colors.white,
      activeItemIconColor: Colors.white,
      activeItemIconDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      activeItemFontWeight: FontWeight.w600,
      inactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      inactiveItemTextColor: Colors.white.withValues(alpha: 0.8),
      inactiveItemIconColor: Colors.white.withValues(alpha: 0.7),
      inactiveItemIconDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      inactiveItemFontWeight: FontWeight.w400,
      itemHoverColor: Colors.white.withValues(alpha: 0.05),
      subItemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      subItemMargin: EdgeInsets.only(bottom: 2, left: 12, right: 4),
      subItemIndentation: 8,
      subItemIconSize: 16,
      subItemBorderRadius: BorderRadius.circular(8),
      activeSubItemDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withValues(alpha: 0.3),
            Colors.blue.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1),
      ),
      inactiveSubItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      activeSubItemTextColor: Colors.white,
      inactiveSubItemTextColor: Colors.white.withValues(alpha: 0.6),
      activeSubItemIconColor: Colors.white,
      inactiveSubItemIconColor: Colors.white.withValues(alpha: 0.5),
      expandIcon: Icons.expand_more,
      expandIconSize: 20,
      expandIconColor: Colors.white.withValues(alpha: 0.5),
      expandAnimationDuration: Duration(milliseconds: 200),
      itemFontSize: 14,
      subItemFontSize: 13,
      collapsedWidth: 72,
      collapsedItemPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      collapsedIconSize: 22,
      collapsedActiveItemDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade500, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedInactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      badgeSize: 8,
      badgeColor: Colors.red,
      badgeTextColor: Colors.white,
      badgeTextStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    );
  }

  /// Creates a style that adapts to the given [theme].
  ///
  /// Uses the theme's color scheme for all colors, making the menu
  /// consistent with the rest of the application.
  static InnovareSideMenuStyle fromTheme(ThemeData theme) {
    return InnovareSideMenuStyle(
      width: 280,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      headerPadding: EdgeInsets.all(20),
      headerDivider: BorderSide(
        color: theme.colorScheme.outlineVariant,
        width: 1,
      ),
      footerPadding: EdgeInsets.all(12),
      footerDivider: BorderSide(
        color: theme.colorScheme.outlineVariant,
        width: 1,
      ),
      sectionTitleStyle: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      sectionTitlePadding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
      sectionPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemMargin: EdgeInsets.only(bottom: 4),
      itemBorderRadius: BorderRadius.circular(12),
      itemIconSize: 20,
      itemIconPadding: EdgeInsets.all(8),
      itemIconBorderRadius: BorderRadius.circular(10),
      activeItemDecoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      activeItemTextColor: theme.colorScheme.onPrimaryContainer,
      activeItemIconColor: theme.colorScheme.primary,
      activeItemIconDecoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      activeItemFontWeight: FontWeight.w600,
      inactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      inactiveItemTextColor: theme.colorScheme.onSurface,
      inactiveItemIconColor: theme.colorScheme.onSurfaceVariant,
      inactiveItemIconDecoration: BoxDecoration(
        color:
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      inactiveItemFontWeight: FontWeight.w500,
      itemHoverColor:
          theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      subItemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      subItemMargin: EdgeInsets.only(bottom: 2, left: 12, right: 4),
      subItemIndentation: 8,
      subItemIconSize: 18,
      subItemBorderRadius: BorderRadius.circular(10),
      activeSubItemDecoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      inactiveSubItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      activeSubItemTextColor: theme.colorScheme.onSecondaryContainer,
      inactiveSubItemTextColor: theme.colorScheme.onSurfaceVariant,
      activeSubItemIconColor: theme.colorScheme.secondary,
      inactiveSubItemIconColor: theme.colorScheme.onSurfaceVariant,
      expandIcon: Icons.expand_more,
      expandIconSize: 20,
      expandIconColor: theme.colorScheme.onSurfaceVariant,
      expandAnimationDuration: Duration(milliseconds: 200),
      itemFontSize: 14,
      subItemFontSize: 13,
      collapsedWidth: 72,
      collapsedItemPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      collapsedIconSize: 22,
      collapsedActiveItemDecoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedInactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      badgeSize: 8,
      badgeColor: theme.colorScheme.error,
      badgeTextColor: theme.colorScheme.onError,
      badgeTextStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    );
  }

  /// Light theme with subtle shadows and blue active items.
  /// Suitable for light-mode applications.
  static InnovareSideMenuStyle lightDefault() {
    return InnovareSideMenuStyle(
      width: 280,
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      headerPadding: EdgeInsets.all(20),
      headerDivider: BorderSide(color: Color(0xFFE0E0E0), width: 1),
      footerPadding: EdgeInsets.all(12),
      footerDivider: BorderSide(color: Color(0xFFE0E0E0), width: 1),
      sectionTitleStyle: TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      sectionTitlePadding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
      sectionPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemMargin: EdgeInsets.only(bottom: 4),
      itemBorderRadius: BorderRadius.circular(10),
      itemIconSize: 20,
      itemIconPadding: EdgeInsets.all(8),
      itemIconBorderRadius: BorderRadius.circular(8),
      activeItemDecoration: BoxDecoration(
        color: Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      activeItemTextColor: Colors.white,
      activeItemIconColor: Colors.white,
      activeItemIconDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      activeItemFontWeight: FontWeight.w600,
      inactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      inactiveItemTextColor: Color(0xFF374151),
      inactiveItemIconColor: Color(0xFF6B7280),
      inactiveItemIconDecoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      inactiveItemFontWeight: FontWeight.w500,
      itemHoverColor: Color(0xFFF3F4F6),
      subItemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      subItemMargin: EdgeInsets.only(bottom: 2, left: 12, right: 4),
      subItemIndentation: 8,
      subItemIconSize: 18,
      subItemBorderRadius: BorderRadius.circular(8),
      activeSubItemDecoration: BoxDecoration(
        color: Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(8),
      ),
      inactiveSubItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      activeSubItemTextColor: Color(0xFF1E40AF),
      inactiveSubItemTextColor: Color(0xFF6B7280),
      activeSubItemIconColor: Color(0xFF3B82F6),
      inactiveSubItemIconColor: Color(0xFF9CA3AF),
      expandIcon: Icons.expand_more,
      expandIconSize: 20,
      expandIconColor: Color(0xFF9CA3AF),
      expandAnimationDuration: Duration(milliseconds: 200),
      itemFontSize: 14,
      subItemFontSize: 13,
      collapsedWidth: 72,
      collapsedItemPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      collapsedIconSize: 22,
      collapsedActiveItemDecoration: BoxDecoration(
        color: Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedInactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      badgeSize: 8,
      badgeColor: Color(0xFFEF4444),
      badgeTextColor: Colors.white,
      badgeTextStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    );
  }

  /// Minimal theme with no rounded corners, left-border active indicator,
  /// and clean typography. Suitable for content-focused applications.
  static InnovareSideMenuStyle minimal() {
    return InnovareSideMenuStyle(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      headerPadding: EdgeInsets.all(16),
      headerDivider: BorderSide(color: Color(0xFFF3F4F6), width: 1),
      footerPadding: EdgeInsets.all(12),
      footerDivider: BorderSide(color: Color(0xFFF3F4F6), width: 1),
      sectionTitleStyle: TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      sectionTitlePadding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
      sectionPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemMargin: EdgeInsets.zero,
      itemBorderRadius: BorderRadius.zero,
      itemIconSize: 18,
      itemIconPadding: EdgeInsets.zero,
      itemIconBorderRadius: BorderRadius.zero,
      activeItemDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFF3B82F6), width: 3),
        ),
        color: Color(0xFFF8FAFC),
      ),
      activeItemTextColor: Color(0xFF1E293B),
      activeItemIconColor: Color(0xFF3B82F6),
      activeItemFontWeight: FontWeight.w600,
      inactiveItemDecoration: BoxDecoration(color: Colors.transparent),
      inactiveItemTextColor: Color(0xFF64748B),
      inactiveItemIconColor: Color(0xFF94A3B8),
      inactiveItemFontWeight: FontWeight.w400,
      itemHoverColor: Color(0xFFF8FAFC),
      subItemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      subItemMargin: EdgeInsets.only(left: 16),
      subItemIndentation: 0,
      subItemIconSize: 16,
      subItemBorderRadius: BorderRadius.zero,
      activeSubItemDecoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
      ),
      inactiveSubItemDecoration: BoxDecoration(color: Colors.transparent),
      activeSubItemTextColor: Color(0xFF1E293B),
      inactiveSubItemTextColor: Color(0xFF94A3B8),
      activeSubItemIconColor: Color(0xFF3B82F6),
      inactiveSubItemIconColor: Color(0xFFCBD5E1),
      expandIcon: Icons.chevron_right,
      expandIconSize: 18,
      expandIconColor: Color(0xFFCBD5E1),
      expandAnimationDuration: Duration(milliseconds: 150),
      itemFontSize: 14,
      subItemFontSize: 13,
      collapsedWidth: 64,
      collapsedItemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      collapsedIconSize: 20,
      collapsedActiveItemDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFF3B82F6), width: 3),
        ),
        color: Color(0xFFF8FAFC),
      ),
      collapsedInactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
      badgeSize: 6,
      badgeColor: Color(0xFFEF4444),
      badgeTextColor: Colors.white,
      badgeTextStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
    );
  }

  /// Glassmorphism theme with translucent backgrounds, frosted-glass
  /// borders, and soft shadows. Best used over gradient or image backgrounds.
  static InnovareSideMenuStyle glassmorphism() {
    return InnovareSideMenuStyle(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.15),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      headerPadding: EdgeInsets.all(20),
      headerDivider: BorderSide(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1,
      ),
      footerPadding: EdgeInsets.all(12),
      footerDivider: BorderSide(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1,
      ),
      sectionTitleStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.5),
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      sectionTitlePadding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
      sectionPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemMargin: EdgeInsets.only(bottom: 4),
      itemBorderRadius: BorderRadius.circular(14),
      itemIconSize: 20,
      itemIconPadding: EdgeInsets.all(8),
      itemIconBorderRadius: BorderRadius.circular(10),
      activeItemDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      activeItemTextColor: Colors.white,
      activeItemIconColor: Colors.white,
      activeItemIconDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      activeItemFontWeight: FontWeight.w600,
      inactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      inactiveItemTextColor: Colors.white.withValues(alpha: 0.8),
      inactiveItemIconColor: Colors.white.withValues(alpha: 0.6),
      inactiveItemIconDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      inactiveItemFontWeight: FontWeight.w400,
      itemHoverColor: Colors.white.withValues(alpha: 0.08),
      subItemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      subItemMargin: EdgeInsets.only(bottom: 2, left: 12, right: 4),
      subItemIndentation: 8,
      subItemIconSize: 18,
      subItemBorderRadius: BorderRadius.circular(10),
      activeSubItemDecoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      inactiveSubItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      activeSubItemTextColor: Colors.white,
      inactiveSubItemTextColor: Colors.white.withValues(alpha: 0.6),
      activeSubItemIconColor: Colors.white,
      inactiveSubItemIconColor: Colors.white.withValues(alpha: 0.4),
      expandIcon: Icons.expand_more,
      expandIconSize: 20,
      expandIconColor: Colors.white.withValues(alpha: 0.5),
      expandAnimationDuration: Duration(milliseconds: 250),
      itemFontSize: 14,
      subItemFontSize: 13,
      collapsedWidth: 72,
      collapsedItemPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      collapsedIconSize: 22,
      collapsedActiveItemDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      collapsedInactiveItemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      badgeSize: 8,
      badgeColor: Color(0xFFEF4444),
      badgeTextColor: Colors.white,
      badgeTextStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    );
  }
}
