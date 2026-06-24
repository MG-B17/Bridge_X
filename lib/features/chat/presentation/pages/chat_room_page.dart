// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
// import 'package:bridge_x/core/extensions/context_extension.dart';
// import 'package:bridge_x/core/utils/app_spacing.dart';
// import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_room_state.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/message_input_widget.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/message_list_widget.dart';
// import 'package:go_router/go_router.dart';

// class ChatRoomPage extends StatefulWidget {
//   final String teamId;
//   final String teamName;

//   const ChatRoomPage({
//     super.key,
//     required this.teamId,
//     required this.teamName,
//   });

//   @override
//   State<ChatRoomPage> createState() => _ChatRoomPageState();
// }

// class _ChatRoomPageState extends State<ChatRoomPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ScrollCubit>().hide();
//     context.read<ChatRoomCubit>().init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colors.surface,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: context.colors.primaryLight,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.colors.textPrimary, size: AppSpacing.fontSize20),
//           onPressed: () {
//             context.pop();
//             context.read<ScrollCubit>().show();
//           },
//         ),
//         title: Text(
//           widget.teamName,
//           style: TextStyle(
//             color: context.colors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: AppSpacing.fontSize18,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info_outline_rounded, color: context.colors.textPrimary, size: AppSpacing.fontSize24),
//             onPressed: () {},
//           ),
//           SizedBox(width: AppSpacing.spacing8),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
//               builder: (context, state) {
//                 final isLoading = state is ChatRoomInitial || state is ChatRoomLoading;
//                 final hasMore = state is ChatRoomLoaded ? state.hasMore : true;
//                 final loadingMore = state is ChatRoomLoaded ? state.loadingMore : false;
//                 return BridgeXSkeletonizer(
//                   enableloading: isLoading,
//                   child: MessageListWidget(
//                     hasMore: hasMore,
//                     loadingMore: loadingMore,
//                   ),
//                 );
//               },
//               buildWhen: (previous, current) =>
//                   current is ChatRoomInitial ||
//                   current is ChatRoomLoading ||
//                   current is ChatRoomLoaded ||
//                   current is ChatRoomError,
//             ),
//           ),
//           BlocSelector<ChatRoomCubit, ChatRoomState, bool>(
//             selector: (state) => state is ChatRoomLoaded && state.sending,
//             builder: (context, sending) {
//               return MessageInputWidget(
//                 onSend: (content) {
//                   context.read<ChatRoomCubit>().sendMessage(content);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
