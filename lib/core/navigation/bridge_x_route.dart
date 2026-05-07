import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../feature/onboarding/presentation/screens/onboarding_screen.dart';
import '../../feature/splash/splash_screen.dart';
import 'bridge_x_route_constant.dart';


final appRouter = GoRouter(
    initialLocation: AppRoute.splash,
    routes: [
      GoRoute(
        path: AppRoute.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoute.splash,
        builder: (context, state) => const SplashScreen(),
      ),
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
      GoRoute(
        path: AppRoute.layout,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Layout'))),
      ),
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
        builder: (context, state) => const Scaffold(body: Center(child: Text('Privacy & Security'))),
      ),
      GoRoute(
        path: AppRoute.aboutUs,
        builder: (context, state) => const Scaffold(body: Center(child: Text('About Us'))),
      ),
    ],
);
