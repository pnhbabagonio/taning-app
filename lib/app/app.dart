// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/app_router.dart';
import 'package:taning/app/theme/app_theme.dart';
import 'package:taning/app/theme/theme_provider.dart';

class TaningApp extends ConsumerWidget {
  const TaningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'Taning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      
      // Accessibility
      highContrast: ref.watch(highContrastProvider),
      supportDisplay: true,
      
      // Localization
      localizationsDelegates: const [
        // Add localization delegates
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fil', 'PH'),
      ],
    );
  }
}