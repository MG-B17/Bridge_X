import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_up_transition.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/create_task_args.dart';
import 'package:bridge_x/core/navigation/screens_args/project_dashboard_args.dart';
import 'package:bridge_x/core/navigation/screens_args/project_details_args.dart';
import 'package:bridge_x/core/navigation/screens_args/team_settings_args.dart';
import 'package:bridge_x/core/navigation/screens_args/view_task_args.dart';
import 'package:bridge_x/core/navigation/screens_args/report_user_args.dart';
import 'package:bridge_x/feature/create_team/presentation/screens/create_team_screen.dart';
import 'package:bridge_x/feature/projects_management/presentation/screens/completed_project_details_screen.dart';
import 'package:bridge_x/feature/projects_management/presentation/screens/project_dashboard_screen.dart';
import 'package:bridge_x/feature/projects_management/presentation/screens/project_details_screen.dart';
import 'package:bridge_x/feature/projects_management/presentation/screens/projects_screen.dart';
import 'package:bridge_x/feature/projects_management/presentation/screens/team_settings_screen.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/task_management/presentation/screens/create_task_screen.dart';
import 'package:bridge_x/feature/task_management/presentation/screens/view_task_screen.dart';
import 'package:bridge_x/feature/report/presentation/screen/report_user_screen.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/cubit/team_evaluation_cubit.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/screens/team_evaluation_screen.dart';
import 'package:bridge_x/core/navigation/screens_args/team_evaluation_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();
final BottomSheetTransitionPage _bottomSheetTransition = BottomSheetTransitionPage();

StatefulShellBranch projectRoute = StatefulShellBranch(
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.projects,
          name: BridegeXRouteNames.projects,
          builder: (context, state) => const ProjectsScreen(),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.createTeam,
              name: BridegeXRouteNames.createTeam,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const CreateTeamScreen(),
                state: state,
              ),
            ),
            GoRoute(
              path: BridgeXRoutePaths.projectDetails,
              name: BridegeXRouteNames.projectDetails,
              pageBuilder: (context, state) {
                final args = state.extra as ProjectDetailsArgs;
                return slideRightTransitionPage.build(
                  child: ProjectDetailsScreen(
                    projectId: args.projectId,
                    status: args.status,
                  ),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.projectDashboard,
              name: BridegeXRouteNames.projectDashboard,
              pageBuilder: (context, state) {
                final args = state.extra as ProjectDashboardArgs;
                return slideRightTransitionPage.build(
                  child: ProjectDashboardScreen(
                    projectId: args.projectId,
                  ),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.teamSettings,
              name: BridegeXRouteNames.teamSettings,
              pageBuilder: (context, state) {
                final args = state.extra as TeamSettingsArgs;
                return slideRightTransitionPage.build(
                  child: TeamSettingsScreen(
                    projectId: args.projectId,
                  ),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.completedProjectDetails,
              name: BridegeXRouteNames.completedProjectDetails,
              pageBuilder: (context, state) {
                final args = state.extra as ProjectDetailsArgs;
                return slideRightTransitionPage.build(
                  child: CompletedProjectDetailsScreen(
                    projectId: args.projectId,
                  ),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.createTask,
              name: BridegeXRouteNames.createTask,
              pageBuilder: (context, state) {
                final args = state.extra as CreateTaskArgs;
                return _bottomSheetTransition.build(
                  child: BlocProvider<CreateTaskCubit>(
                    create: (_) => sl<CreateTaskCubit>()..loadMembers(args.projectId),
                    child: CreateTaskScreen(projectId: args.projectId),
                  ),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.viewTask,
              name: BridegeXRouteNames.viewTask,
              pageBuilder: (context, state) {
                final args = state.extra as ViewTaskArgs;
                return slideRightTransitionPage.build(
                  child: ViewTaskScreen(projectId: args.projectId),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.reportUser,
              name: BridegeXRouteNames.reportUser,
              pageBuilder: (context, state) {
                final args = state.extra as ReportUserArgs;
                return _bottomSheetTransition.build(
                  child: ReportUserScreen(userId: args.userId),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: BridgeXRoutePaths.teamEvaluation,
              name: BridegeXRouteNames.teamEvaluation,
              pageBuilder: (context, state) {
                final args = state.extra as TeamEvaluationArgs;
                return slideRightTransitionPage.build(
                  child: BlocProvider<TeamEvaluationCubit>(
                    create: (_) => sl<TeamEvaluationCubit>()
                      ..loadMembers(args.teamId),
                    child: TeamEvaluationScreen(teamId: args.teamId),
                  ),
                  state: state,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
