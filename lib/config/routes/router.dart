import 'package:fivoza/core/constants/routes_name.dart';
import 'package:fivoza/core/utils/enum.dart';
import 'package:fivoza/presentation/blocs/auth/auth_bloc.dart';
import 'package:fivoza/presentation/pages/auth/forgot_password_page.dart';
import 'package:fivoza/presentation/pages/auth/sign_in_page.dart';
import 'package:fivoza/presentation/pages/auth/sign_up_page.dart';
import 'package:fivoza/presentation/pages/base/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      redirect: (context, state) {
        final authState = context.watch<AuthBloc>().state;

        if (authState.status == BlocStatus.success) {
          if (authState.user!.emailVerified) {
            // if (authState.userType == UserTypes.admin.name) {
            //   return state.namedLocation(AppRoutes.adminPageName);
            // }
            // if (authState.userType == UserTypes.user.name) {
            //   return state.namedLocation(AppRoutes.homePageName);
            // }
          } else {
            return state.namedLocation(AppRoutes.signInPageName);
          }
        } else if (authState.status == BlocStatus.error ||
            authState.status == BlocStatus.initial) {
          return state.namedLocation(AppRoutes.signInPageName);
        }
        return state.namedLocation(AppRoutes.splashPageName);
      },
    ),

    /// Auth Page
    GoRoute(
      name: AppRoutes.signInPageName,
      path: AppRoutes.signInPagePath,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SignInPage(),
        );
      },
    ),

    GoRoute(
      name: AppRoutes.signUpPageName,
      path: AppRoutes.signUpPagePath,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SignUpPage(),
        );
      },
    ),

    GoRoute(
      name: AppRoutes.forgotPasswordPageName,
      path: AppRoutes.forgotPasswordPagePath,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ForgotPasswordPage(),
        );
      },
    ),
  ],
);
