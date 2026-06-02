import 'package:flutter/material.dart';

/// Comprehensive styling configuration for [InnovareSideMenu].
///
/// Controls the visual appearance of the entire menu including container,
/// header/footer, sections, items, sub-items, collapsed mode, and badges.
///
/// Use [copyWith] to create a modified copy, or use one of the built-in
/// theme factories from [InnovareSideMenuThemes].
class InnovareSideMenuStyle {
  /// Width of the menu in expanded mode. Defaults to `280`.
  final double width;

  /// Decoration applied to the menu container.
  final BoxDecoration? decoration;

  /// Padding inside the menu container.
  final EdgeInsets? padding;

  /// Border radius of the menu container.
  final BorderRadius? borderRadius;

  /// Padding around the header widget.
  final EdgeInsets? headerPadding;

  /// Decoration for the header container.
  final BoxDecoration? headerDecoration;

  /// Divider line below the header. Used when [headerDecoration] is `null`.
  final BorderSide? headerDivider;

  /// Padding around the footer widget.
  final EdgeInsets? footerPadding;

  /// Decoration for the footer container.
  final BoxDecoration? footerDecoration;

  /// Divider line above the footer. Used when [footerDecoration] is `null`.
  final BorderSide? footerDivider;

  /// Text style for section titles.
  final TextStyle? sectionTitleStyle;

  /// Padding around section titles.
  final EdgeInsets? sectionTitlePadding;

  /// Padding around the scrollable section list.
  final EdgeInsets? sectionPadding;

  /// Padding inside each menu item.
  final EdgeInsets? itemPadding;

  /// Margin around each menu item.
  final EdgeInsets? itemMargin;

  /// Border radius of menu items.
  final BorderRadius? itemBorderRadius;

  /// Size of the menu item icon.
  final double? itemIconSize;

  /// Padding around the icon container.
  final EdgeInsets? itemIconPadding;

  /// Border radius of the icon container.
  final BorderRadius? itemIconBorderRadius;

  /// Decoration for the active (selected) menu item.
  final BoxDecoration? activeItemDecoration;

  /// Text color of the active menu item.
  final Color? activeItemTextColor;

  /// Icon color of the active menu item.
  final Color? activeItemIconColor;

  /// Decoration for the icon container of the active item.
  final BoxDecoration? activeItemIconDecoration;

  /// Font weight of the active menu item text.
  final FontWeight? activeItemFontWeight;

  /// Decoration for inactive menu items.
  final BoxDecoration? inactiveItemDecoration;

  /// Text color of inactive menu items.
  final Color? inactiveItemTextColor;

  /// Icon color of inactive menu items.
  final Color? inactiveItemIconColor;

  /// Decoration for the icon container of inactive items.
  final BoxDecoration? inactiveItemIconDecoration;

  /// Font weight of inactive menu item text.
  final FontWeight? inactiveItemFontWeight;

  /// Background color applied on hover.
  final Color? itemHoverColor;

  /// Padding inside each sub-item.
  final EdgeInsets? subItemPadding;

  /// Margin around each sub-item.
  final EdgeInsets? subItemMargin;

  /// Additional left indentation for sub-items.
  final double? subItemIndentation;

  /// Icon size for sub-items.
  final double? subItemIconSize;

  /// Border radius of sub-items.
  final BorderRadius? subItemBorderRadius;

  /// Decoration for the active sub-item.
  final BoxDecoration? activeSubItemDecoration;

  /// Decoration for inactive sub-items.
  final BoxDecoration? inactiveSubItemDecoration;

  /// Text color of the active sub-item.
  final Color? activeSubItemTextColor;

  /// Text color of inactive sub-items.
  final Color? inactiveSubItemTextColor;

  /// Icon color of the active sub-item.
  final Color? activeSubItemIconColor;

  /// Icon color of inactive sub-items.
  final Color? inactiveSubItemIconColor;

  /// Icon used for the expand/collapse indicator.
  final IconData? expandIcon;

  /// Size of the expand/collapse icon.
  final double? expandIconSize;

  /// Color of the expand/collapse icon.
  final Color? expandIconColor;

  /// Duration of the expand/collapse animation.
  final Duration? expandAnimationDuration;

  /// Font size for menu item text.
  final double? itemFontSize;

  /// Font size for sub-item text.
  final double? subItemFontSize;

  /// Width of the menu in collapsed (rail) mode. Defaults to `72`.
  final double collapsedWidth;

  /// Padding inside each item in collapsed mode.
  final EdgeInsets? collapsedItemPadding;

  /// Icon size in collapsed mode.
  final double? collapsedIconSize;

  /// Decoration for the active item in collapsed mode.
  final BoxDecoration? collapsedActiveItemDecoration;

  /// Decoration for inactive items in collapsed mode.
  final BoxDecoration? collapsedInactiveItemDecoration;

  /// Base size for badge indicators. Defaults to `8`.
  final double badgeSize;

  /// Background color for badges.
  final Color? badgeColor;

  /// Text color for count badges.
  final Color? badgeTextColor;

  /// Text style for count badge labels.
  final TextStyle? badgeTextStyle;

  /// Positional offset for the badge relative to the icon.
  final EdgeInsets? badgeOffset;

  /// Duration for animating active/hover state changes on items (decoration,
  /// text and icon color). Set to [Duration.zero] to disable. Defaults to 200ms.
  final Duration stateAnimationDuration;

  /// Whether items animate (fade + slide) into view on first appearance.
  /// Defaults to `true`.
  final bool animateOnAppear;

  /// Duration of each item's appearance animation. Defaults to 350ms.
  final Duration appearAnimationDuration;

  /// Stagger delay added per item index for the appearance cascade.
  /// Defaults to 45ms.
  final Duration appearStaggerInterval;

  /// Whether a selection haptic fires when an item is tapped. Defaults to `true`.
  final bool enableHaptics;

  /// Scale applied while an item is pressed (tap-down). Defaults to `0.97`;
  /// set to `1.0` to disable the press effect.
  final double pressedScale;

  /// Scale applied while an item is hovered on desktop/web. Defaults to `1.0`
  /// (no scale — relies on the hover color).
  final double hoverScale;

  /// Whether the menu auto-scrolls to reveal the active item on mount and when
  /// the active item changes. Defaults to `true`.
  final bool autoScrollToActive;

  /// When collapsed, expand the rail in place while the pointer hovers over it
  /// (desktop/web). Defaults to `false`.
  final bool expandOnHover;

  /// When the screen is narrower than this width (logical px), the menu renders
  /// as a collapsed rail regardless of `mode`. `null` disables it (default).
  final double? autoCollapseBelowWidth;

  /// Opacity applied to disabled items (when `InnovareSideMenuItem.enabled` is
  /// `false`). Defaults to `0.38` (Material's disabled opacity).
  final double disabledOpacity;

  /// Creates a style configuration with sensible defaults.
  ///
  /// All parameters are optional. The default [width] is `280` and
  /// [collapsedWidth] is `72`.
  const InnovareSideMenuStyle({
    this.width = 280,
    this.decoration,
    this.padding,
    this.borderRadius,
    this.headerPadding,
    this.headerDecoration,
    this.headerDivider,
    this.footerPadding,
    this.footerDecoration,
    this.footerDivider,
    this.sectionTitleStyle,
    this.sectionTitlePadding,
    this.sectionPadding,
    this.itemPadding,
    this.itemMargin,
    this.itemBorderRadius,
    this.itemIconSize,
    this.itemIconPadding,
    this.itemIconBorderRadius,
    this.activeItemDecoration,
    this.activeItemTextColor,
    this.activeItemIconColor,
    this.activeItemIconDecoration,
    this.activeItemFontWeight,
    this.inactiveItemDecoration,
    this.inactiveItemTextColor,
    this.inactiveItemIconColor,
    this.inactiveItemIconDecoration,
    this.inactiveItemFontWeight,
    this.itemHoverColor,
    this.subItemPadding,
    this.subItemMargin,
    this.subItemIndentation,
    this.subItemIconSize,
    this.subItemBorderRadius,
    this.activeSubItemDecoration,
    this.inactiveSubItemDecoration,
    this.activeSubItemTextColor,
    this.inactiveSubItemTextColor,
    this.activeSubItemIconColor,
    this.inactiveSubItemIconColor,
    this.expandIcon,
    this.expandIconSize,
    this.expandIconColor,
    this.expandAnimationDuration,
    this.itemFontSize,
    this.subItemFontSize,
    this.collapsedWidth = 72,
    this.collapsedItemPadding,
    this.collapsedIconSize,
    this.collapsedActiveItemDecoration,
    this.collapsedInactiveItemDecoration,
    this.badgeSize = 8,
    this.badgeColor,
    this.badgeTextColor,
    this.badgeTextStyle,
    this.badgeOffset,
    this.stateAnimationDuration = const Duration(milliseconds: 200),
    this.animateOnAppear = true,
    this.appearAnimationDuration = const Duration(milliseconds: 350),
    this.appearStaggerInterval = const Duration(milliseconds: 45),
    this.enableHaptics = true,
    this.pressedScale = 0.97,
    this.hoverScale = 1.0,
    this.autoScrollToActive = true,
    this.expandOnHover = false,
    this.autoCollapseBelowWidth,
    this.disabledOpacity = 0.38,
  });

  /// Creates a copy of this style with the given fields replaced.
  InnovareSideMenuStyle copyWith({
    double? width,
    BoxDecoration? decoration,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    EdgeInsets? headerPadding,
    BoxDecoration? headerDecoration,
    BorderSide? headerDivider,
    EdgeInsets? footerPadding,
    BoxDecoration? footerDecoration,
    BorderSide? footerDivider,
    TextStyle? sectionTitleStyle,
    EdgeInsets? sectionTitlePadding,
    EdgeInsets? sectionPadding,
    EdgeInsets? itemPadding,
    EdgeInsets? itemMargin,
    BorderRadius? itemBorderRadius,
    double? itemIconSize,
    EdgeInsets? itemIconPadding,
    BorderRadius? itemIconBorderRadius,
    BoxDecoration? activeItemDecoration,
    Color? activeItemTextColor,
    Color? activeItemIconColor,
    BoxDecoration? activeItemIconDecoration,
    FontWeight? activeItemFontWeight,
    BoxDecoration? inactiveItemDecoration,
    Color? inactiveItemTextColor,
    Color? inactiveItemIconColor,
    BoxDecoration? inactiveItemIconDecoration,
    FontWeight? inactiveItemFontWeight,
    Color? itemHoverColor,
    EdgeInsets? subItemPadding,
    EdgeInsets? subItemMargin,
    double? subItemIndentation,
    double? subItemIconSize,
    BorderRadius? subItemBorderRadius,
    BoxDecoration? activeSubItemDecoration,
    BoxDecoration? inactiveSubItemDecoration,
    Color? activeSubItemTextColor,
    Color? inactiveSubItemTextColor,
    Color? activeSubItemIconColor,
    Color? inactiveSubItemIconColor,
    IconData? expandIcon,
    double? expandIconSize,
    Color? expandIconColor,
    Duration? expandAnimationDuration,
    double? itemFontSize,
    double? subItemFontSize,
    double? collapsedWidth,
    EdgeInsets? collapsedItemPadding,
    double? collapsedIconSize,
    BoxDecoration? collapsedActiveItemDecoration,
    BoxDecoration? collapsedInactiveItemDecoration,
    double? badgeSize,
    Color? badgeColor,
    Color? badgeTextColor,
    TextStyle? badgeTextStyle,
    EdgeInsets? badgeOffset,
    Duration? stateAnimationDuration,
    bool? animateOnAppear,
    Duration? appearAnimationDuration,
    Duration? appearStaggerInterval,
    bool? enableHaptics,
    double? pressedScale,
    double? hoverScale,
    bool? autoScrollToActive,
    bool? expandOnHover,
    double? autoCollapseBelowWidth,
    double? disabledOpacity,
  }) {
    return InnovareSideMenuStyle(
      width: width ?? this.width,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      headerPadding: headerPadding ?? this.headerPadding,
      headerDecoration: headerDecoration ?? this.headerDecoration,
      headerDivider: headerDivider ?? this.headerDivider,
      footerPadding: footerPadding ?? this.footerPadding,
      footerDecoration: footerDecoration ?? this.footerDecoration,
      footerDivider: footerDivider ?? this.footerDivider,
      sectionTitleStyle: sectionTitleStyle ?? this.sectionTitleStyle,
      sectionTitlePadding: sectionTitlePadding ?? this.sectionTitlePadding,
      sectionPadding: sectionPadding ?? this.sectionPadding,
      itemPadding: itemPadding ?? this.itemPadding,
      itemMargin: itemMargin ?? this.itemMargin,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemIconSize: itemIconSize ?? this.itemIconSize,
      itemIconPadding: itemIconPadding ?? this.itemIconPadding,
      itemIconBorderRadius: itemIconBorderRadius ?? this.itemIconBorderRadius,
      activeItemDecoration:
          activeItemDecoration ?? this.activeItemDecoration,
      activeItemTextColor:
          activeItemTextColor ?? this.activeItemTextColor,
      activeItemIconColor:
          activeItemIconColor ?? this.activeItemIconColor,
      activeItemIconDecoration:
          activeItemIconDecoration ?? this.activeItemIconDecoration,
      activeItemFontWeight:
          activeItemFontWeight ?? this.activeItemFontWeight,
      inactiveItemDecoration:
          inactiveItemDecoration ?? this.inactiveItemDecoration,
      inactiveItemTextColor:
          inactiveItemTextColor ?? this.inactiveItemTextColor,
      inactiveItemIconColor:
          inactiveItemIconColor ?? this.inactiveItemIconColor,
      inactiveItemIconDecoration:
          inactiveItemIconDecoration ?? this.inactiveItemIconDecoration,
      inactiveItemFontWeight:
          inactiveItemFontWeight ?? this.inactiveItemFontWeight,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      subItemPadding: subItemPadding ?? this.subItemPadding,
      subItemMargin: subItemMargin ?? this.subItemMargin,
      subItemIndentation: subItemIndentation ?? this.subItemIndentation,
      subItemIconSize: subItemIconSize ?? this.subItemIconSize,
      subItemBorderRadius:
          subItemBorderRadius ?? this.subItemBorderRadius,
      activeSubItemDecoration:
          activeSubItemDecoration ?? this.activeSubItemDecoration,
      inactiveSubItemDecoration:
          inactiveSubItemDecoration ?? this.inactiveSubItemDecoration,
      activeSubItemTextColor:
          activeSubItemTextColor ?? this.activeSubItemTextColor,
      inactiveSubItemTextColor:
          inactiveSubItemTextColor ?? this.inactiveSubItemTextColor,
      activeSubItemIconColor:
          activeSubItemIconColor ?? this.activeSubItemIconColor,
      inactiveSubItemIconColor:
          inactiveSubItemIconColor ?? this.inactiveSubItemIconColor,
      expandIcon: expandIcon ?? this.expandIcon,
      expandIconSize: expandIconSize ?? this.expandIconSize,
      expandIconColor: expandIconColor ?? this.expandIconColor,
      expandAnimationDuration:
          expandAnimationDuration ?? this.expandAnimationDuration,
      itemFontSize: itemFontSize ?? this.itemFontSize,
      subItemFontSize: subItemFontSize ?? this.subItemFontSize,
      collapsedWidth: collapsedWidth ?? this.collapsedWidth,
      collapsedItemPadding:
          collapsedItemPadding ?? this.collapsedItemPadding,
      collapsedIconSize: collapsedIconSize ?? this.collapsedIconSize,
      collapsedActiveItemDecoration:
          collapsedActiveItemDecoration ?? this.collapsedActiveItemDecoration,
      collapsedInactiveItemDecoration:
          collapsedInactiveItemDecoration ??
              this.collapsedInactiveItemDecoration,
      badgeSize: badgeSize ?? this.badgeSize,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
      badgeOffset: badgeOffset ?? this.badgeOffset,
      stateAnimationDuration:
          stateAnimationDuration ?? this.stateAnimationDuration,
      animateOnAppear: animateOnAppear ?? this.animateOnAppear,
      appearAnimationDuration:
          appearAnimationDuration ?? this.appearAnimationDuration,
      appearStaggerInterval:
          appearStaggerInterval ?? this.appearStaggerInterval,
      enableHaptics: enableHaptics ?? this.enableHaptics,
      pressedScale: pressedScale ?? this.pressedScale,
      hoverScale: hoverScale ?? this.hoverScale,
      autoScrollToActive: autoScrollToActive ?? this.autoScrollToActive,
      expandOnHover: expandOnHover ?? this.expandOnHover,
      autoCollapseBelowWidth:
          autoCollapseBelowWidth ?? this.autoCollapseBelowWidth,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    );
  }
}
