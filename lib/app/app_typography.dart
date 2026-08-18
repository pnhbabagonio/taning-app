// lib/app/theme/app_typography.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taning/app/theme/app_colors.dart';

class AppTypography {
  static TextTheme get lightTextTheme {
    return TextTheme(
      // Display (Countdown numbers)
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: -2,
        color: AppColors.lightOnSurface,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: -1,
        color: AppColors.lightOnSurface,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColors.lightOnSurface,
      ),
      
      // Headlines (UI headings)
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: AppColors.lightOnSurface,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.lightOnSurface,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.lightOnSurface,
      ),
      
      // Body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.lightOnSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.lightOnSurfaceVariant,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: AppColors.lightOnSurfaceVariant,
      ),
      
      // Labels
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.lightOnSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.lightOnSurfaceVariant,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.lightOnSurfaceVariant,
      ),
      
      // Title (for cards, etc.)
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.lightOnSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: AppColors.lightOnSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: AppColors.lightOnSurfaceVariant,
      ),
    );
  }
  
  static TextTheme get darkTextTheme {
    return lightTextTheme.copyWith(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: -2,
        color: AppColors.darkOnSurface,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: -1,
        color: AppColors.darkOnSurface,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColors.darkOnSurface,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: AppColors.darkOnSurface,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.darkOnSurface,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.darkOnSurface,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.darkOnSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.darkOnSurfaceVariant,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: AppColors.darkOnSurfaceVariant,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.darkOnSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.darkOnSurfaceVariant,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.darkOnSurfaceVariant,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.darkOnSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: AppColors.darkOnSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: AppColors.darkOnSurfaceVariant,
      ),
    );
  }
}