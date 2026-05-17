import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/notifications_details_args.dart';
import 'package:bridge_x/feature/home/presentation/screens/home_screen.dart';
import 'package:bridge_x/feature/notifications/presentation/screens/notification_details_screen.dart';
import 'package:bridge_x/feature/notifications/presentation/screens/notifications_screen.dart';
import 'package:go_router/go_router.dart';

StatefulShellBranch homeRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.home,
      name: BridegeXRouteNames.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.notifications,
          name: BridegeXRouteNames.notifications,
          builder: (context, state) => const NotificationsScreen(),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.notificationsDetails,
              name: BridegeXRouteNames.notificationsDetails,
              builder: (context, state) {
                final args = state.extra as NotificationsDetailsArgs;
                return NotificationDetailsScreen(
                  title: args.title,
                  subtitle: args.subtitle,
                  icon: args.icon,
                  iconBg: args.iconBg,
                  iconColor: args.iconColor,
                  time: args.time,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
