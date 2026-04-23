import '../../features/auth/login/screen/login_page.dart';
import '../../features/auth/register/screen/register_page.dart';
import '../../features/auth/forget_password/screen/forget_password_page.dart';
import '../../features/auth/otp_verification/screen/otp_verification_page.dart';
import '../../features/onboarding/screen/onboarding_page.dart';
import 'package:bridgex/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constant.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConstant.splash,
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'), // Will be branded later
        ),
      );
    },
    routes: [
      GoRoute(
        path: AppRouteConstant.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteConstant.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRouteConstant.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRouteConstant.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRouteConstant.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      GoRoute(
        path: AppRouteConstant.otpVerification,
        builder: (context, state) => const OtpVerificationPage(),
      ),
      GoRoute(
        path: AppRouteConstant.profileSetup,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Profile Setup Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.home,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.teams,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Teams Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.workspace,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Workspace Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.chat,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Chat Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.profile,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Profile Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.notifications,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Notifications Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.company,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Company Stub'))),
      ),
    ],
  );
}
