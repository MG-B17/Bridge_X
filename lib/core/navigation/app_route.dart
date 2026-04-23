import '../../features/auth/login/screen/login_page.dart';
import '../../features/auth/register/screen/register_page.dart';
import '../../features/auth/forget_password/screen/forget_password_page.dart';
import '../../features/auth/otp_verification/screen/otp_verification_page.dart';
import '../../features/onboarding/screen/onboarding_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/home/screen/home_page.dart';
import '../../features/chat/screen/chat_page.dart';
import '../../features/chat/screen/chat_room_page.dart';
import '../../features/projects/screen/projects_page.dart';
import '../../features/profile/screen/profile_page.dart';
import '../../features/layout/screen/main_layout_page.dart';
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
      // Stateful shell route for bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstant.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstant.chat,
                builder: (context, state) => const ChatPage(),
                routes: [
                  GoRoute(
                    path: AppRouteConstant.chatRoom,
                    builder: (context, state) => const ChatRoomPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstant.projects,
                builder: (context, state) => const ProjectsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouteConstant.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      // Other top-level flat routes
      GoRoute(
        path: AppRouteConstant.teams,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Teams Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.workspace,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Workspace Stub'))),
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
