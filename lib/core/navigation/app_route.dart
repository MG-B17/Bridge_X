import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constant.dart';

import 'package:bridgex/features/auth/login/screen/login_page.dart';
import 'package:bridgex/features/auth/register/screen/register_page.dart';
import 'package:bridgex/features/auth/forget_password/screen/forget_password_page.dart';
import 'package:bridgex/features/auth/otp_verification/screen/otp_verification_page.dart';
import 'package:bridgex/features/onboarding/screen/onboarding_page.dart';
import 'package:bridgex/features/splash/splash_page.dart';

import 'package:bridgex/features/layout/screen/main_layout_page.dart';
import 'package:bridgex/features/home/screen/home_page.dart';
import 'package:bridgex/features/chat/screen/chat_page.dart';
import 'package:bridgex/features/chat/screen/chat_room_page.dart';
import 'package:bridgex/features/projects/screen/projects_page.dart';

import 'package:bridgex/features/profile/presentation/screens/profile_screen.dart';
import 'package:bridgex/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:bridgex/features/profile/presentation/screens/complete_profile_screen.dart';
import 'package:bridgex/features/profile/presentation/screens/logout_screen.dart';

import 'package:bridgex/features/settings/presentation/screens/privacy_security_screen.dart';
import 'package:bridgex/features/settings/presentation/screens/change_password_screen.dart';
import 'package:bridgex/features/settings/presentation/screens/about_us_screen.dart';

import 'package:bridgex/features/tasks/presentation/screens/my_tasks_screen.dart';
import 'package:bridgex/features/tasks/presentation/screens/task_details_screen.dart';

import 'package:bridgex/features/skills/presentation/screens/skills_experience_screen.dart';

import 'package:bridgex/features/matching/presentation/screens/matching_screen.dart';
import 'package:bridgex/features/matching/presentation/screens/recommended_teams_screen.dart';
import 'package:bridgex/features/matching/presentation/screens/no_teams_screen.dart';
import 'package:bridgex/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:bridgex/features/workspace/presentation/screens/workspace_screen.dart';
import 'package:bridgex/features/level/presentation/screens/level_screen.dart';
import 'package:bridgex/features/teams/presentation/screens/create_team_screen.dart';

import 'package:bridgex/features/projects/screen/project_details_page.dart';
import 'package:bridgex/features/projects/screen/mentor_project_details_page.dart';
import 'package:bridgex/features/projects/screen/team_settings_page.dart';

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
        builder: (context, state) => const CompleteProfileScreen(),
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
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      // Other top-level flat routes
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
      GoRoute(
        path: AppRouteConstant.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.myTasksScreen,
        builder: (context, state) => const MyTasksScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.taskDetails,
        builder: (context, state) => const TaskDetailsScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.skillsExperience,
        builder: (context, state) => const SkillsExperienceScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.privacySecurity,
        builder: (context, state) => const PrivacySecurityScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.changePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.aboutUsScreen,
        builder: (context, state) => const AboutUsScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.logoutScreen,
        builder: (context, state) => const LogoutScreen(),
      ),
      GoRoute(
        path: AppRouteConstant.projectDetails,
        builder: (context, state) => const ProjectDetailsPage(),
      ),
      GoRoute(
        path: AppRouteConstant.mentorProjectDetails,
        builder: (context, state) => const MentorProjectDetailsPage(),
      ),
      GoRoute(
        path: AppRouteConstant.teamSettings,
        builder: (context, state) => const TeamSettingsPage(),
      ),
    ],
  );
}
