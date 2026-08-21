// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:taning/app/theme/app_colors.dart';
import 'package:taning/app/theme/app_typography.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightSurface,
        background: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: AppColors.lightOnPrimary,
        onSecondary: AppColors.lightOnPrimary,
        onSurface: AppColors.lightOnSurface,
        onBackground: AppColors.lightOnBackground,
        onError: AppColors.lightOnPrimary,
        primaryContainer: AppColors.primaryVeryLight,
        secondaryContainer: AppColors.primarySurface,
      ),
      
      // Typography
      textTheme: AppTypography.lightTextTheme,
      
      // Card
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.lightCard,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.lightShadow,
        clipBehavior: Clip.antiAlias,
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnSurface,
          height: 1.3,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.lightOnSurface,
          size: 24,
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightDivider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(
          color: AppColors.lightOnSurfaceVariant,
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: AppColors.lightOnSurfaceVariant,
          fontSize: 14,
        ),
      ),
      
      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      
      // Dialog
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
      ),
      
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightOnBackground,
        contentTextStyle: const TextStyle(color: AppColors.lightOnBackground),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
        space: 24,
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.lightOnSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // Scrollbar
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(4),
        thickness: MaterialStateProperty.all(4),
        thumbColor: MaterialStateProperty.all(
          AppColors.lightOnSurfaceVariant.withOpacity(0.3),
        ),
      ),
    );
  }
  
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.darkOnPrimary,
        onSecondary: AppColors.darkOnPrimary,
        onSurface: AppColors.darkOnSurface,
        onBackground: AppColors.darkOnBackground,
        onError: AppColors.darkOnPrimary,
        primaryContainer: AppColors.primaryDark,
        secondaryContainer: AppColors.secondaryDark,
      ),
      
      textTheme: AppTypography.darkTextTheme,
      
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.darkCard,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.darkShadow,
        clipBehavior: Clip.antiAlias,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnSurface,
          height: 1.3,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.darkOnSurface,
          size: 24,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.darkOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkDivider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(
          color: AppColors.darkOnSurfaceVariant,
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: AppColors.darkOnSurfaceVariant,
          fontSize: 14,
        ),
      ),
      
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        backgroundColor: AppColors.darkSurface,
      ),
      
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkOnBackground,
        contentTextStyle: const TextStyle(color: AppColors.darkOnBackground),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
        space: 24,
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.darkOnSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(4),
        thickness: MaterialStateProperty.all(4),
        thumbColor: MaterialStateProperty.all(
          AppColors.darkOnSurfaceVariant.withOpacity(0.3),
        ),
      ),
    );
  }
}