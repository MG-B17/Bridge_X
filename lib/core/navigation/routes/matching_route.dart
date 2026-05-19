import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/feature/matching/presentation/screens/matching_process_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/no_teams_found_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/recommended_teams_screen.dart';
import 'package:go_router/go_router.dart';

GoRoute matchingRoute = GoRoute(
      path: BridgeXRoutePaths.matching,
      name: BridegeXRouteNames.matching,
      builder: (context, state) => const MatchingProcessScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.matchingProcess,
          name: BridegeXRouteNames.matchingProcess,
          builder: (context, state) => const MatchingProcessScreen(),
        ),
        GoRoute(
          path: BridgeXRoutePaths.noTeamsFound,
          name: BridegeXRouteNames.noTeamsFound,
          builder: (context, state) => const NoTeamsFoundScreen(),
        ),
        GoRoute(
          path: BridgeXRoutePaths.recommendedTeams,
          name: BridegeXRouteNames.recommendedTeams,
          builder: (context, state) => const RecommendedTeamsScreen(),
        ),
      ],
    );
