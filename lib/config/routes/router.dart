import 'package:fivoza/core/constants/routes_name.dart';
import 'package:fivoza/presentation/pages/base/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Private Navigators
final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.splashPagePath,
  navigatorKey: rootNavigatorKey,
  routes: [
    /// Spash Page
    GoRoute(
      name: AppRoutes.splashPageName,
      path: AppRoutes.splashPagePath,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        );
      },
      redirect: (context, state) {},
    )
  ],
);
