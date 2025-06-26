// cart/cart_styles.dart
// Centralizes all colors, padding, radii, and sizing for cart UI.

import 'package:flutter/material.dart';

class CartStyles {
  static const bgColor = Color(0xFFEDECEC);
  static const cardBg = Colors.white;
  static const charcoal = Color(0xFF232325);
  static const subtleGray = Color(0xFFEEEEEE);

  static const appBarFontSize = 22.0;
  static const appBarFontWeight = FontWeight.bold;

  static const sectionRadius = Radius.circular(24);
  static const cardPad = EdgeInsets.fromLTRB(18, 18, 18, 8);

  static const addressPad = EdgeInsets.symmetric(vertical: 24, horizontal: 18);
  static const addressTitleFontSize = 18.0;
  static const addressTitleWeight = FontWeight.w800;

  static const cartItemImageSize = 60.0;
  static const cartItemBorderRadius = 14.0;
  static const cartItemNameFontSize = 16.5;
  static const cartItemNameWeight = FontWeight.w800;
  static const cartItemRestaurantFontSize = 13.5;
  static const cartItemRestaurantWeight = FontWeight.w500;

  static const tagPad = EdgeInsets.symmetric(horizontal: 9, vertical: 4);
  static const tagFontSize = 13.0;
  static const tagFontWeight = FontWeight.w600;
  static const tagBorderRadius = 6.0;

  static const quantityButtonSize = 32.0;
  static const quantityIconSize = 18.0;
  static const quantityTextFontSize = 17.0;

  static const checkoutBtnHeight = 52.0;
  static const checkoutBtnRadius = 14.0;
  static const checkoutBtnFontSize = 18.0;
}
