import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/chats/presentation/screens/chat_details_screen.dart';
import '../../../feature/chats/presentation/screens/chat_list_screen.dart';

final chatRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.chat,
      name: BridegeXRouteNames.chat,
      builder: (context, state) => const ChatListScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.chatDetails,
          name: BridegeXRouteNames.chatDetails,
          builder: (context, state) => const ChatDetailsScreen(),
        ),
      ],
    ),
  ],
);
