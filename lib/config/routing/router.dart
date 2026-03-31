import 'package:fintech_app/common/widgets/dashboard/dashboard_body.dart';
import 'package:fintech_app/features/auth/presentation/login_page.dart';
import 'package:fintech_app/features/cards/presentation/cards_page.dart';
import 'package:fintech_app/features/home/presentation/home_page.dart';
import 'package:fintech_app/features/stats/presentation/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/home';
  static const String profile = '/profile';
  static const String cards = '/cards';
  static const String settings = '/settings';
  static const String stats = '/stats';
  static const String transactions = '/transactions';
  static const String login = '/login';
  static const String register = '/register';
}

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(path: AppRoutes.settings, builder: (context, state) => const Placeholder()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginPage()),
      GoRoute(path: AppRoutes.register, builder: (context, state) => const Placeholder()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => DashboardBody(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.home, builder: (context, state) => const HomePage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.cards, builder: (context, state) => const CardsPage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.stats, builder: (context, state) => const StatsPage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.profile, builder: (context, state) => const Placeholder())],
          ),
        ],
      ),
    ],
  );
}
