// profile_styles.dart
// Centralizes all style, color, and layout constants for the ProfileScreen.
// Makes theme modifications simple and code DRY.

import 'package:flutter/material.dart';

class ProfileStyles {
  // --- Main Colors ---
  static const bgColor = Color(0xFFEDECEC);      // App background color
  static const cardBg = Colors.white;            // Card/section background
  static const charcoal = Color(0xFF232325);     // Primary dark accent
  static const subtleGray = Color(0xFFEEEEEE);   // Icon bg/secondary

  // --- Layout & Sizing ---
  static const avatarRadius = 40.0;                    // Profile avatar size
  static const avatarBorder = 3.2;                     // Avatar border width
  static const cardPad = EdgeInsets.symmetric(vertical: 20, horizontal: 24); // Header card padding
  static const sectionPad = EdgeInsets.fromLTRB(24, 10, 24, 0); // Section padding
  static const sectionRadius = Radius.circular(24);    // Top corners of main card
  static const tileIconSize = 25.0;                    // Icon size in tiles
  static const tileIconBg = subtleGray;                // Tile icon background color
  static const tileRadius = 12.0;                      // Rounded tile corners
  static const tileLeadSize = 44.0;                    // Tile leading icon container size
  static const logoutBtnHeight = 50.0;                 // Logout button height
  static const logoutBtnRadius = 14.0;                 // Logout button corner radius
}
