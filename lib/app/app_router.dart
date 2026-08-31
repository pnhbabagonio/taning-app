import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/screens/home_screen.dart';
import 'package:taning/features/tanings/presentation/screens/create_screen.dart';
import 'package:taning/features/tanings/presentation/screens/detail_screen.dart';
import 'package:taning/features/tanings/presentation/screens/edit_screen.dart';
import 'package:taning/features/settings/presentation/screens/settings_screen.dart';
import 'package:taning/features/widgets/presentation/screens/widget_config_screen.dart';
import 'package:taning/features/tanings/presentation/screens/calendar_screen.dart';

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
        path: '/edit',
        name: 'edit',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra == null || extra['taning'] == null) {
            return const HomeScreen();
          }
          final taning = extra['taning'] as Taning;
          return EditScreen(taning: taning);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(), // ✅ Now uses correct screen
      ),
      GoRoute(
        path: '/widget-config',
        name: 'widget-config',
        builder: (context, state) => const WidgetConfigScreen(),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) => const CalendarScreen(),
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
});