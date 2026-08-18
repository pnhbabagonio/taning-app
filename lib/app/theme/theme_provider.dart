// lib/app/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModePreference {
  system,
  light,
  dark,
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemePreference();
  }
  
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('theme_mode');
    if (saved != null) {
      final mode = ThemeModePreference.values.firstWhere(
        (e) => e.toString() == saved,
        orElse: () => ThemeModePreference.system,
      );
      state = _convertToThemeMode(mode);
    }
  }
  
  void setThemeMode(ThemeModePreference mode) async {
    state = _convertToThemeMode(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }
  
  ThemeMode _convertToThemeMode(ThemeModePreference mode) {
    switch (mode) {
      case ThemeModePreference.system:
        return ThemeMode.system;
      case ThemeModePreference.light:
        return ThemeMode.light;
      case ThemeModePreference.dark:
        return ThemeMode.dark;
    }
  }
}

// High contrast mode
final highContrastProvider = StateProvider<bool>((ref) => false);