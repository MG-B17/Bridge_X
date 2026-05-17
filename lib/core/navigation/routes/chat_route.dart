import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

StatefulShellBranch chatRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.chat,
      name: BridegeXRouteNames.chat,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Chats'))),
    ),
  ],
);
