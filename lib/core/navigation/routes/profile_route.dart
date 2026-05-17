import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/feature/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          builder: (context, state) => const Scaffold(body: Center(child: Text('Edit Profile'))),
        ),
        GoRoute(
          path: BridgeXRoutePaths.settings,
          name: BridegeXRouteNames.settings,
          builder: (context, state) => const Scaffold(body: Center(child: Text('Settings'))),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.notificationsSettings,
              name: BridegeXRouteNames.notificationsSettings,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('notificationsSettings'))),
            ),
            GoRoute(
              path: BridgeXRoutePaths.privacySecurity,
              name: BridegeXRouteNames.privacySecurity,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('privacySecurity'))),
              routes: [
                GoRoute(
                  path: BridgeXRoutePaths.changePassword,
                  name: BridegeXRouteNames.changePassword,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text('changePassword'))),
                ),
              ],
            ),
            GoRoute(
              path: BridgeXRoutePaths.aboutUs,
              name: BridegeXRouteNames.aboutUs,
              builder: (context, state) => const Scaffold(body: Center(child: Text('aboutUs'))),
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myTasks,
          name: BridegeXRouteNames.myTasks,
          builder: (context, state) => const Scaffold(body: Center(child: Text('myTasks'))),
          routes: [
            GoRoute(
              path: BridgeXRoutePaths.myTasksDetails,
              name: BridegeXRouteNames.myTasksDetails,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('myTasksDetails'))),
            ),
          ],
        ),
        GoRoute(
          path: BridgeXRoutePaths.myProjects,
          name: BridegeXRouteNames.myProjects,
          builder: (context, state) => const Scaffold(body: Center(child: Text('myProjects'))),
        ),
        GoRoute(
          path: BridgeXRoutePaths.level,
          name: BridegeXRouteNames.level,
          builder: (context, state) => const Scaffold(body: Center(child: Text('level'))),
        ),
        GoRoute(
          path: BridgeXRoutePaths.skillsAndExperience,
          name: BridegeXRouteNames.skillsAndExperience,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('skillsAndExperience'))),
        ),
      ],
    ),
  ],
);
