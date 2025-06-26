import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'theme_extensions.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.black,
        secondary: AppColors.grayButton,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadowColor: AppColors.shadowLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: const TextTheme(
        // Large headline for titles/app bars
        displayLarge: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: AppColors.textPrimary,
        ),
        // Card titles, product names
        headlineLarge: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: AppColors.textPrimary,
        ),
        // Medium titles (e.g. Vendor name)
        titleMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        // Main body
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        // Subtle or line-through (e.g. old price)
        bodyMedium: TextStyle(
          fontSize: 16,
          color: AppColors.muted,
          decoration: TextDecoration.lineThrough,
        ),
        // Button text
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        // Small info (e.g. location, reviews)
        bodySmall: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.tagBg,
        labelStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        selectedColor: AppColors.primary.withOpacity(0.2),
        secondarySelectedColor: AppColors.success.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        fillColor: MaterialStatePropertyAll(AppColors.primary),
        checkColor: MaterialStatePropertyAll(Colors.black),
        side: const BorderSide(width: 1.2, color: AppColors.border),
      ),
      dividerColor: AppColors.border,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppSpacing(),
      ], // <--- this line is CRITICAL!
    );
  }
}
