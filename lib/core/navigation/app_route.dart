import 'package:bridgex/features/auth/login/screen/login_page.dart';
 import 'package:bridgex/features/auth/register/screen/register_page.dart';
import 'package:bridgex/features/onboarding/screen/onboarding_page.dart';
import 'package:bridgex/features/splash/splash_page.dart';
import 'package:bridgex/features/matching/presentation/screens/matching_screen.dart';
import 'package:bridgex/features/matching/presentation/screens/recommended_teams_screen.dart';
import 'package:bridgex/features/matching/presentation/screens/no_teams_screen.dart';
import 'package:bridgex/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:bridgex/features/workspace/presentation/screens/workspace_screen.dart';
import 'package:bridgex/features/profile/presentation/screens/profile_screen.dart';
import 'package:bridgex/features/level/presentation/screens/level_screen.dart';
import 'package:bridgex/features/teams/presentation/screens/create_team_screen.dart';
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
        path: AppRouteConstant.otp,
        builder: (context, state) => const Scaffold(body: Center(child: Text('OTP Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.forgotPassword,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Forgot Password Stub'))),
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
        builder: (context, state) => const RecommendedTeamsScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.workspace,
        builder: (context, state) => const WorkspaceScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.chat,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Chat Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.matching,
        builder: (context, state) => const MatchingScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.createTeam,
        builder: (context, state) => const CreateTeamScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.noTeams,
        builder: (context, state) => const NoTeamsScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.level,
        builder: (context, state) => const LevelScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.company,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Company Stub'))),
      ),
    ],
  );
}
