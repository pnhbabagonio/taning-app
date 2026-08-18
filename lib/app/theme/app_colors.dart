// lib/app/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryVeryLight = Color(0xFFE0E7FF);
  static const Color primarySurface = Color(0xFFF5F3FF);
  
  // Secondary
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryLight = Color(0xFFA78BFA);
  static const Color secondaryDark = Color(0xFF5B21B6);
  
  // Accent (Filipino-inspired)
  static const Color accentGold = Color(0xFFFCD34D);
  static const Color accentWarm = Color(0xFFF97316);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentRose = Color(0xFFF43F5E);
  static const Color accentTeal = Color(0xFF14B8A6);
  static const Color accentSky = Color(0xFF0EA5E9);
  
  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  
  // Light Theme Neutrals
  static const Color lightBackground = Color(0xFFFAFAF9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F4);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE5E5E5);
  static const Color lightShadow = Color.fromRGBO(15, 23, 42, 0.08);
  
  static const Color lightOnBackground = Color(0xFF1C1917);
  static const Color lightOnSurface = Color(0xFF292524);
  static const Color lightOnSurfaceVariant = Color(0xFF57534E);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  
  // Dark Theme Neutrals
  static const Color darkBackground = Color(0xFF0F0F0F);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = Color(0xFF262626);
  static const Color darkCard = Color(0xFF1F1F1F);
  static const Color darkDivider = Color(0xFF2E2E2E);
  static const Color darkShadow = Color.fromRGBO(0, 0, 0, 0.3);
  
  static const Color darkOnBackground = Color(0xFFE5E5E5);
  static const Color darkOnSurface = Color(0xFFF5F5F5);
  static const Color darkOnSurfaceVariant = Color(0xFFA3A3A3);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  
  // Countdown specific
  static const Color countdownPrimary = Color(0xFF0F172A);
  static const Color countdownSecondary = Color(0xFF334155);
  static const Color countdownLight = Color(0xFFF8FAFC);
  
  // Preset color palettes for customization
  static const List<Color> presetColors = [
    Color(0xFF4F46E5), // Indigo
    Color(0xFF7C3AED), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFFEF4444), // Red
    Color(0xFFF97316), // Orange
    Color(0xFFFCD34D), // Gold
    Color(0xFF22C55E), // Green
    Color(0xFF14B8A6), // Teal
    Color(0xFF0EA5E9), // Sky
  ];
  
  const AppColors._();
}