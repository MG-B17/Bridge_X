// import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
// import 'package:bridge_x/core/di/di.dart';
// import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
// import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
// import 'package:bridge_x/features/chat/presentation/pages/chat_list_page.dart';
// import 'package:bridge_x/features/chat/presentation/pages/chat_room_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

// final chatRoute = StatefulShellBranch(
//   routes: [
//     GoRoute(
//       path: BridgeXRoutePaths.chat,
//       name: BridgeXRouteNames.chat,
//       builder: (context, state) => BlocProvider<ChatListCubit>(
//         create: (_) => sl<ChatListCubit>(),
//         child: const ChatListPage(),
//       ),
//       routes: [
//         GoRoute(
//           path: '${BridgeXRoutePaths.chatDetails}/:teamId',
//           name: BridgeXRouteNames.chatDetails,
//           builder: (context, state) {
//             final teamId = state.pathParameters['teamId'] ?? '';
//             final teamName = state.extra as String? ?? '';
//             return BlocProvider<ChatRoomCubit>(
//               create: (_) => sl<ChatRoomCubit>(param1: teamId),
//               child: ChatRoomPage(
//                 teamId: teamId,
//                 teamName: teamName,
//               ),
//             );
//           },
//         ),
//       ],
//     ),
//   ],
// );
