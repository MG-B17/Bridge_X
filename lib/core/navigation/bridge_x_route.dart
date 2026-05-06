import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bridge_x/feature/splash/splash_screen.dart';
import 'bridge_x_route_constant.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoute.splash,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(state.uri.toString(), style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoute.splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      // ── Auth Flow ──────────────────────────────────────────────────────────
      GoRoute(path: AppRoute.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: AppRoute.login,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login'))),
      ),
      GoRoute(
        path: AppRoute.signUp,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Sign Up'))),
      ),
      GoRoute(
        path: AppRoute.forgotPassword,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Forgot Password'))),
      ),
      GoRoute(
        path: AppRoute.verifyCode,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Verify Code'))),
      ),
      GoRoute(
        path: AppRoute.completeProfile,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Complete Profile'))),
      ),
      GoRoute(
        path: AppRoute.matching,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Matching'))),
      ),

      // ── Main Shell ─────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoute.layout,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Layout'))),
      ),

      // ── Profile / Settings ─────────────────────────────────────────────────
      GoRoute(
        path: AppRoute.notifications,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Notifications'))),
      ),
      GoRoute(
        path: AppRoute.editProfile,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Edit Profile'))),
      ),
      GoRoute(
        path: AppRoute.settings,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Settings'))),
      ),
      GoRoute(
        path: AppRoute.changePassword,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Change Password'))),
      ),
      GoRoute(
        path: AppRoute.privacySecurity,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Privacy & Security'))),
      ),
      GoRoute(
        path: AppRoute.aboutUs,
        builder: (context, state) => const Scaffold(body: Center(child: Text('About Us'))),
      ),
    ],
  );
}
