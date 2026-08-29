import 'package:flutter/material.dart';
import 'package:taning/app/theme/app_colors.dart';
import 'package:taning/app/theme/app_typography.dart';

class AppTheme {
  static ThemeData get light => _createTheme(Brightness.light);
  static ThemeData get dark => _createTheme(Brightness.dark);

  static ThemeData _createTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    final colorScheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.primaryLight,
            secondary: AppColors.secondaryLight,
            surface: AppColors.darkSurface,
            surfaceContainerHighest: AppColors.darkSurfaceVariant,
            onSurface: AppColors.darkOnSurface,
            onSurfaceVariant: AppColors.darkOnSurfaceVariant,
            error: AppColors.error,
            onPrimary: AppColors.darkOnPrimary,
            onSecondary: AppColors.darkOnPrimary,
            onError: AppColors.darkOnPrimary,
            primaryContainer: AppColors.primaryDark,
            secondaryContainer: AppColors.secondaryDark,
          )
        : const ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.lightSurface,
            surfaceContainerHighest: AppColors.lightSurfaceVariant,
            onSurface: AppColors.lightOnSurface,
            onSurfaceVariant: AppColors.lightOnSurfaceVariant,
            error: AppColors.error,
            onPrimary: AppColors.lightOnPrimary,
            onSecondary: AppColors.lightOnPrimary,
            onError: AppColors.lightOnPrimary,
            primaryContainer: AppColors.primaryVeryLight,
            secondaryContainer: AppColors.primarySurface,
          );

    final textTheme = isDark 
        ? AppTypography.darkTextTheme 
        : AppTypography.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      
      cardTheme: const CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          height: 1.3,
        ),
        actionsIconTheme: IconThemeData(
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          size: 24,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          foregroundColor: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
          foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          side: BorderSide(
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.primaryLight : AppColors.primary,
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
        labelStyle: TextStyle(
          color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
          fontSize: 14,
        ),
      ),
      
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      
      dialogTheme: DialogThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 8,
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground,
        contentTextStyle: const TextStyle(
          color: Colors.white, // White text on dark background for visibility
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        thickness: 1,
        space: 24,
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant,
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(4),
        thickness: WidgetStateProperty.all(4),
        thumbColor: WidgetStateProperty.all(
          (isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant)
              .withValues(alpha: 0.3),
        ),
      ),
    );
  }

  /// Create a theme with a custom accent color
  static ThemeData withAccent(Color accentColor, {Brightness? brightness}) {
    final isDark = brightness == Brightness.dark;
    final base = isDark ? dark : light;
    
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: accentColor,
        secondary: accentColor,
        primaryContainer: accentColor.withValues(alpha: 0.2),
        secondaryContainer: accentColor.withValues(alpha: 0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
          foregroundColor: accentColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentColor,
          side: BorderSide(color: accentColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
    );
  }
}