import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/core/theme/theme_extensions.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto', // Or your preferred sans-serif
      extensions: <ThemeExtension<dynamic>>[
        const AppSpacing(),
      ],
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme(
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
          fontFamily: 'Merriweather', // Or a similar serif font
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
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
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
        // Display: main app bar or feature headers
        displayLarge: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: AppColors.textPrimary,
        ),
        // Headline: Card titles, product names
        headlineLarge: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: AppColors.textPrimary,
        ),
        // Body: main text, details
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        // Secondary body: muted, old prices
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
        fillColor: MaterialStateProperty.all(AppColors.primary),
        checkColor: MaterialStateProperty.all(Colors.black),
        side: const BorderSide(width: 1.2, color: AppColors.border),
      ),
      dividerColor: AppColors.border,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
