import 'package:admin_v4/core/auth/auth_notifier.dart';
import 'package:admin_v4/core/routes/route_names.dart';
import 'package:admin_v4/ui/forgot_password/forgot_password_screen.dart';
import 'package:admin_v4/ui/home/home_screen.dart';
import 'package:admin_v4/ui/home/settings/settings_screen.dart';
import 'package:admin_v4/ui/login/login_screen.dart';
import 'package:admin_v4/ui/signup/sign_up_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer';

part 'go_router_notifier.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // Watch the auth state so the router rebuilds when it changes
  final isLoggedIn = ref.watch(authNotifierProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      log('GoRouter: Redirect called - isLoggedIn: $isLoggedIn, location: ${state.matchedLocation}');
      
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSignUp = state.matchedLocation == '/signup';
      final isGoingToForgotPassword = state.matchedLocation == '/login/forgotPassword';

      // If user is logged in and trying to access auth pages, redirect to home
      if (isLoggedIn) {
        if (isGoingToLogin || isGoingToSignUp || isGoingToForgotPassword) {
          log('GoRouter: Redirecting logged in user to /home');
          return '/home';
        }
      } else {
        // If user is not logged in and trying to access protected pages, redirect to login
        if (!isGoingToLogin && !isGoingToSignUp && !isGoingToForgotPassword) {
          log('GoRouter: Redirecting non-logged in user to /login');
          return '/login';
        }
      }
      
      log('GoRouter: No redirect needed');
      return null;
    },
    routes: [
      GoRoute(
          path: '/login',
          name: loginRoute,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'forgotPassword',
              name: forgotPasswordRoute,
              builder: (context, state) => const ForgotPasswordScreen(),
            ),
          ]),
      GoRoute(
        path: '/signup',
        name: singUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
          path: '/home',
          name: homeRoute,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'setting',
              name: settingRoute,
              builder: (context, state) => const SettingsScreen(),
            ),
          ]),
    ],
  );
}

// Add this provider to trigger router refresh when auth state changes
@riverpod
class RouterRefresh extends _$RouterRefresh {
  @override
  int build() {
    // Watch the auth state
    ref.watch(authNotifierProvider);
    // Invalidate the router when auth state changes
    ref.invalidate(goRouterProvider);
    return 0;
  }
}
