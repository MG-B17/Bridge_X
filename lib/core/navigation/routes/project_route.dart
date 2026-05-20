import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/feature/create_team/presentation/screens/create_team_screen.dart';
import 'package:bridge_x/feature/projects/presentation/screens/projects_screen.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

StatefulShellBranch projectRoute = StatefulShellBranch(
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
      ],
    ),
  ],
);
