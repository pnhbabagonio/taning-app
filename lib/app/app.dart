import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/app_router.dart';
import 'package:taning/app/theme/app_theme.dart';
import 'package:taning/app/theme/theme_provider.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class TaningApp extends ConsumerWidget {
  const TaningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accentColor = ref.watch(accentColorProvider);
    final router = ref.watch(appRouterProvider);

    // Create themes with accent color
    final lightTheme = AppTheme.withAccent(accentColor, brightness: Brightness.light);
    final darkTheme = AppTheme.withAccent(accentColor, brightness: Brightness.dark);

    return MaterialApp.router(
      title: 'Taning',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: const [],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fil', 'PH'),
      ],
    );
  }
}