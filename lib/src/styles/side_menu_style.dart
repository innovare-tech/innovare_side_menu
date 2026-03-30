import 'package:flutter/material.dart';

class InnovareSideMenuStyle {
  // Container principal
  final double width;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  // Header (apenas layout — widget é parâmetro do InnovareSideMenu)
  final EdgeInsets? headerPadding;
  final BoxDecoration? headerDecoration;
  final BorderSide? headerDivider;

  // Footer (apenas layout — widget é parâmetro do InnovareSideMenu)
  final EdgeInsets? footerPadding;
  final BoxDecoration? footerDecoration;
  final BorderSide? footerDivider;

  // Seções
  final TextStyle? sectionTitleStyle;
  final EdgeInsets? sectionTitlePadding;
  final EdgeInsets? sectionPadding;

  // Items do menu
  final EdgeInsets? itemPadding;
  final EdgeInsets? itemMargin;
  final BorderRadius? itemBorderRadius;
  final double? itemIconSize;
  final EdgeInsets? itemIconPadding;
  final BorderRadius? itemIconBorderRadius;

  // Item ativo
  final BoxDecoration? activeItemDecoration;
  final Color? activeItemTextColor;
  final Color? activeItemIconColor;
  final BoxDecoration? activeItemIconDecoration;
  final FontWeight? activeItemFontWeight;

  // Item inativo
  final BoxDecoration? inactiveItemDecoration;
  final Color? inactiveItemTextColor;
  final Color? inactiveItemIconColor;
  final BoxDecoration? inactiveItemIconDecoration;
  final FontWeight? inactiveItemFontWeight;

  // Item hover
  final Color? itemHoverColor;

  // Sub-items
  final EdgeInsets? subItemPadding;
  final EdgeInsets? subItemMargin;
  final double? subItemIndentation;
  final double? subItemIconSize;
  final BorderRadius? subItemBorderRadius;
  final BoxDecoration? activeSubItemDecoration;
  final BoxDecoration? inactiveSubItemDecoration;
  final Color? activeSubItemTextColor;
  final Color? inactiveSubItemTextColor;
  final Color? activeSubItemIconColor;
  final Color? inactiveSubItemIconColor;

  // Expansível
  final IconData? expandIcon;
  final double? expandIconSize;
  final Color? expandIconColor;
  final Duration? expandAnimationDuration;

  // Tipografia
  final double? itemFontSize;
  final double? subItemFontSize;

  // Modo colapsado (rail)
  final double collapsedWidth;
  final EdgeInsets? collapsedItemPadding;
  final double? collapsedIconSize;
  final BoxDecoration? collapsedActiveItemDecoration;
  final BoxDecoration? collapsedInactiveItemDecoration;

  // Badge
  final double badgeSize;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final TextStyle? badgeTextStyle;
  final EdgeInsets? badgeOffset;

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
  });

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
    );
  }
}
