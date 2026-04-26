import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constant.dart';
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
import '../../features/layout/screen/main_layout_page.dart';
import '../../features/matching/presentation/screens/matching_screen.dart';
import '../../features/matching/presentation/screens/recommended_teams_screen.dart';
import '../../features/matching/presentation/screens/no_teams_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/workspace/presentation/screens/workspace_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/level/presentation/screens/level_screen.dart';
import '../../features/teams/presentation/screens/create_team_screen.dart';



class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConstant.splash,
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'),
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'homeNav'),
            routes: [
              GoRoute(
                path: AppRouteConstant.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'chatNav'),
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
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'projectsNav'),
            routes: [
              GoRoute(
                path: AppRouteConstant.projects,
                builder: (context, state) => const ProjectsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'profileNav'),
            routes: [
              GoRoute(
                path: AppRouteConstant.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
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
    ],
  );
}
