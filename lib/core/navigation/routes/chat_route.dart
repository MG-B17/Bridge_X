import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/navigation/navigator_keys.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
import 'package:bridge_x/features/chat/presentation/pages/chat_list_page.dart';
import 'package:bridge_x/features/chat/presentation/pages/chat_room_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

final chatRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.chat,
      name: BridgeXRouteNames.chat,
      pageBuilder: (context, state) => slideRightTransitionPage.build(
        state: state,
        child: BlocProvider<ChatListCubit>(
          create: (_) => sl<ChatListCubit>(),
          child: const ChatListPage(),
        ),
      ),
      routes: [
        GoRoute(
          path: '${BridgeXRoutePaths.chatDetails}/:roomId',
          name: BridgeXRouteNames.chatDetails,
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) {
            final roomId = state.pathParameters['roomId'] ?? '';
            final userId = state.extra as int? ?? 0;
            return slideRightTransitionPage.build(
              state: state,
              child: BlocProvider<ChatRoomCubit>(
                create: (_) => sl<ChatRoomCubit>(param1: roomId, param2: userId),
                child: ChatRoomPage(roomId: roomId),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
