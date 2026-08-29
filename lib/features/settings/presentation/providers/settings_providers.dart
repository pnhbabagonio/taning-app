import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_list.dart';
import 'package:taning/app/theme/theme_provider.dart';

// Settings state
class SettingsState {
  final ThemeModePreference themeMode;
  final Color accentColor;
  final TaningListVariant defaultView;
  final String defaultSort;
  final bool notificationsEnabled;

  const SettingsState({
    this.themeMode = ThemeModePreference.system,
    this.accentColor = const Color(0xFF4F46E5),
    this.defaultView = TaningListVariant.list,
    this.defaultSort = 'soonest',
    this.notificationsEnabled = true,
  });

  SettingsState copyWith({
    ThemeModePreference? themeMode,
    Color? accentColor,
    TaningListVariant? defaultView,
    String? defaultSort,
    bool? notificationsEnabled,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      defaultView: defaultView ?? this.defaultView,
      defaultSort: defaultSort ?? this.defaultSort,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

// Settings notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    final themeModeString = prefs.getString('settings_theme_mode');
    final themeMode = themeModeString != null
        ? ThemeModePreference.values.firstWhere(
            (e) => e.toString() == themeModeString,
            orElse: () => ThemeModePreference.system,
          )
        : ThemeModePreference.system;
    
    final accentColorValue = prefs.getInt('settings_accent_color');
    final accentColor = accentColorValue != null
        ? Color(accentColorValue)
        : const Color(0xFF4F46E5);
    
    final defaultViewString = prefs.getString('settings_default_view');
    final defaultView = defaultViewString != null
        ? TaningListVariant.values.firstWhere(
            (e) => e.toString() == defaultViewString,
            orElse: () => TaningListVariant.list,
          )
        : TaningListVariant.list;
    
    final defaultSort = prefs.getString('settings_default_sort') ?? 'soonest';
    final notificationsEnabled = prefs.getBool('settings_notifications') ?? true;

    state = SettingsState(
      themeMode: themeMode,
      accentColor: accentColor,
      defaultView: defaultView,
      defaultSort: defaultSort,
      notificationsEnabled: notificationsEnabled,
    );
  }

  Future<void> setThemeMode(ThemeModePreference mode) async {
    state = state.copyWith(themeMode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings_theme_mode', mode.toString());
    
    // Also update the app theme provider
    // This will be handled by the theme provider listening to settings
  }

  Future<void> setAccentColor(Color color) async {
    state = state.copyWith(accentColor: color);
    final prefs = await SharedPreferences.getInstance();
    // Use toARGB32() instead of deprecated .value
    await prefs.setInt('settings_accent_color', color.toARGB32());
  }

  Future<void> setDefaultView(TaningListVariant view) async {
    state = state.copyWith(defaultView: view);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings_default_view', view.toString());
  }

  Future<void> setDefaultSort(String sort) async {
    state = state.copyWith(defaultSort: sort);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings_default_sort', sort);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    state = state.copyWith(notificationsEnabled: enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('settings_notifications', enabled);
  }
}

// Providers
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

final accentColorProvider = Provider<Color>((ref) {
  return ref.watch(settingsProvider).accentColor;
});

final defaultViewProvider = Provider<TaningListVariant>((ref) {
  return ref.watch(settingsProvider).defaultView;
});

final defaultSortProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).defaultSort;
});

final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).notificationsEnabled;
});