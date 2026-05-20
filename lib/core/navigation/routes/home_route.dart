import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_up_transition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/notifications_details_args.dart';
import 'package:bridge_x/feature/home/presentation/screens/home_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/matching_process_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/no_teams_found_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/recommended_teams_screen.dart';
import 'package:bridge_x/feature/matching/presentation/screens/select_category_screen.dart';
import 'package:bridge_x/feature/notifications/presentation/screens/notification_details_screen.dart';
import 'package:bridge_x/feature/notifications/presentation/screens/notifications_screen.dart';
import 'package:go_router/go_router.dart';

final BottomSheetTransitionPage bottomSheetTransitionPage = BottomSheetTransitionPage();
final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

StatefulShellBranch homeRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.home,
      name: BridegeXRouteNames.home,
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.selectCategory,
          name: BridegeXRouteNames.selectCategory,
          pageBuilder: (context, state) => bottomSheetTransitionPage.build(child: const SelectCategoryScreen(), state: state),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.matchingProcess,
              name: BridegeXRouteNames.matchingProcess,
              pageBuilder: (context, state) => slideRightTransitionPage.build(
                child: const MatchingProcessScreen(),
                state: state,
              ),
              routes: [
                GoRoute(
                  path: BridgeXRoutePaths.noTeamsFound,
                  name: BridegeXRouteNames.noTeamsFound,
                  pageBuilder: (context, state) => slideRightTransitionPage.build(
                    child: const NoTeamsFoundScreen(),
                    state: state,
                  ),
                ),
                GoRoute(
                  path: BridgeXRoutePaths.recommendedTeams,
                  name: BridegeXRouteNames.recommendedTeams,
                  pageBuilder: (context, state) => slideRightTransitionPage.build(
                    child: const RecommendedTeamsScreen(),
                    state: state,
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.notifications,
          name: BridegeXRouteNames.notifications,
          pageBuilder: (context, state) => slideRightTransitionPage.build(
            child: const NotificationsScreen(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.notificationsDetails,
              name: BridegeXRouteNames.notificationsDetails,
              pageBuilder: (context, state) {
                final args = state.extra as NotificationsDetailsArgs;
                return slideRightTransitionPage.build(
                  child: NotificationDetailsScreen(
                    title: args.title,
                    subtitle: args.subtitle,
                    icon: args.icon,
                    iconBg: args.iconBg,
                    iconColor: args.iconColor,
                    time: args.time,
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
