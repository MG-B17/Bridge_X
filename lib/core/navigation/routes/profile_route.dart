import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/feature/settings/presentation/screen/about_screen.dart';
import 'package:bridge_x/feature/levels/presentation/screen/your_level_screens.dart';
import 'package:bridge_x/feature/settings/presentation/screen/notification_settings_screen.dart';
import 'package:bridge_x/feature/settings/presentation/screen/privacy_security_screen.dart';
import 'package:bridge_x/feature/profile/presentation/screen/edit_profile.dart';
import 'package:bridge_x/feature/profile/presentation/screen/profile_screen.dart';
import 'package:bridge_x/feature/settings/presentation/screen/settings_screen.dart';
import 'package:bridge_x/feature/settings/presentation/screen/change_password_screen.dart';
import 'package:bridge_x/feature/skills_and_experience/presentation/screen/skills_and_experience_screen.dart';
import 'package:bridge_x/feature/my_tasks/presentation/screen/my_tasks_screen.dart';
import 'package:bridge_x/feature/my_tasks/presentation/screen/task_details_screen.dart';
import 'package:bridge_x/feature/my_tasks/presentation/widget/my_tasks_widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

StatefulShellBranch profileRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      name: BridegeXRouteNames.profile,
      path: BridgeXRoutePaths.profile,
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.editProfile,
          name: BridegeXRouteNames.editProfile,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const EditProfileScreen(),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.settings,
          name: BridegeXRouteNames.settings,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const SettingsScreen(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.notificationsSettings,
              name: BridegeXRouteNames.notificationsSettings,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const NotificationSettingsScreen(),
                state: state,
              ),
            ),
            GoRoute(
              path: BridgeXRoutePaths.privacySecurity,
              name: BridegeXRouteNames.privacySecurity,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const PrivacySecurityScreen(),
                state: state,
              ),
              routes: [
                GoRoute(
                  path: BridgeXRoutePaths.changePassword,
                  name: BridegeXRouteNames.changePassword,
                  pageBuilder: (context, state) => slideRightTransitionPage.build(
                    child: const ChangePasswordScreen(),
                    state: state,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: BridgeXRoutePaths.aboutUs,
              name: BridegeXRouteNames.aboutUs,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const AboutScreen(),
                state: state,
              ),
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myTasks,
          name: BridegeXRouteNames.myTasks,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const MyTasksScreen(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.myTasksDetails,
              name: BridegeXRouteNames.myTasksDetails,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: TaskDetailsScreen(task: state.extra as TaskItem?),
                state: state,
              ),
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myProjects,
          name: BridegeXRouteNames.myProjects,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const Scaffold(body: Center(child: Text('myProjects'))),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.level,
          name: BridegeXRouteNames.level,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const YourLevelScreen(),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.skillsAndExperience,
          name: BridegeXRouteNames.skillsAndExperience,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const SkillsAndExperienceScreen(),
            state: state,
          ),
        ),
      ],
    ),
  ],
);
