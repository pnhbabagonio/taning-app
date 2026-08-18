// lib/app/app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taning/features/tanings/presentation/screens/home_screen.dart';
import 'package:taning/features/tanings/presentation/screens/create_screen.dart';
import 'package:taning/features/tanings/presentation/screens/detail_screen.dart';
import 'package:taning/features/settings/presentation/screens/settings_screen.dart';
import 'package:taning/features/onboarding/presentation/screens/onboarding_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/create',
        name: 'create',
        builder: (context, state) => const CreateScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: 'detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailScreen(id: id);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) {
      // Check if user has completed onboarding
      // For now, skip onboarding
      return null;
    },
  );
});