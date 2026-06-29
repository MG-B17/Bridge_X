import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/features/settings/presentation/screen/about_screen.dart';
import 'package:bridge_x/features/levels/presentation/screen/your_level_screens.dart';
import 'package:bridge_x/features/settings/presentation/screen/notification_settings_screen.dart';
import 'package:bridge_x/features/settings/presentation/screen/privacy_security_screen.dart';
import 'package:bridge_x/features/profile/presentation/screen/edit_profile.dart';
import 'package:bridge_x/features/profile/presentation/screen/profile_screen.dart';
import 'package:bridge_x/features/settings/presentation/screen/settings_screen.dart';
import 'package:bridge_x/features/settings/presentation/screen/change_password_screen.dart';
import 'package:bridge_x/features/skills_and_experience/presentation/screen/skills_and_experience_screen.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_cubit.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/screen/my_tasks_screen.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/screen/task_details_screen.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/widget/my_tasks_widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

StatefulShellBranch profileRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      name: BridgeXRouteNames.profile,
      path: BridgeXRoutePaths.profile,
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.editProfile,
          name: BridgeXRouteNames.editProfile,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const EditProfileScreen(),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.settings,
          name: BridgeXRouteNames.settings,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const SettingsScreen(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.notificationsSettings,
              name: BridgeXRouteNames.notificationsSettings,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const NotificationSettingsScreen(),
                state: state,
              ),
            ),
            GoRoute(
              path: BridgeXRoutePaths.privacySecurity,
              name: BridgeXRouteNames.privacySecurity,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const PrivacySecurityScreen(),
                state: state,
              ),
              routes: [
                GoRoute(
                  path: BridgeXRoutePaths.changePassword,
                  name: BridgeXRouteNames.changePassword,
                  pageBuilder: (context, state) => slideRightTransitionPage.build(
                    child: const ChangePasswordScreen(),
                    state: state,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: BridgeXRoutePaths.aboutUs,
              name: BridgeXRouteNames.aboutUs,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const AboutScreen(),
                state: state,
              ),
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myTasks,
          name: BridgeXRouteNames.myTasks,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: BlocProvider<MyTasksCubit>(
              create: (_) => sl<MyTasksCubit>()..fetchAllTasks(),
              child: const MyTasksScreen(),
            ),
            state: state,
          ),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.myTasksDetails,
              name: BridgeXRouteNames.myTasksDetails,
              pageBuilder: (context, state) {
                sl<ScrollCubit>().show();
                final task = state.extra as TaskItem?;
                final taskId =
                    task != null ? int.tryParse(task.id) : null;
                return slideRightTransitionPage.build(
                  child: BlocProvider<MyTasksCubit>(
                    create: (_) => sl<MyTasksCubit>(),
                    child: TaskDetailsScreen(
                      task: task,
                      taskId: taskId,
                    ),
                  ),
                  state: state,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myProjects,
          name: BridgeXRouteNames.myProjects,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const Scaffold(body: Center(child: Text('myProjects'))),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.level,
          name: BridgeXRouteNames.level,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const YourLevelScreen(),
            state: state,
          ),
        ),
        GoRoute(
          path: BridgeXRoutePaths.skillsAndExperience,
          name: BridgeXRouteNames.skillsAndExperience,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const SkillsAndExperienceScreen(),
            state: state,
          ),
        ),
      ],
    ),
  ],
);
