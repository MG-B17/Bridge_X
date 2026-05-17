import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/feature/create_team/presentation/screens/create_team_screen.dart';
import 'package:bridge_x/feature/projects/presentation/screens/projects_screen.dart';
import 'package:go_router/go_router.dart';

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
          builder: (context, state) => const CreateTeamScreen(),
        ),
      ],
    ),
  ],
);
