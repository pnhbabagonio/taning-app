import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModePreference {
  system,
  light,
  dark,
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final Ref ref;

  ThemeModeNotifier(this.ref) : super(ThemeMode.system) {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('settings_theme_mode');
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
    await prefs.setString('settings_theme_mode', mode.toString());
    // Settings provider will also save this, but we already did
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