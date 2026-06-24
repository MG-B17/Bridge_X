// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:bridge_x/core/extensions/context_extension.dart';
// import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
// import 'package:bridge_x/core/utils/app_spacing.dart';
// import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
// import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
// import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
// import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_list_state.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/chat_list_empty_state.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/chat_list_section_header.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/chat_room_list_tile.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/search_bar_widget.dart';

// class ChatListPage extends StatefulWidget {
//   const ChatListPage({super.key});

//   @override
//   State<ChatListPage> createState() => _ChatListPageState();
// }

// class _ChatListPageState extends State<ChatListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatListCubit>().init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colors.surface,
//       body: SafeArea(
//         child: BridgeXRefreshIndicator(
//           onRefresh: () async {
//             context.read<ChatListCubit>().loadChatRooms();
//           },
//           color: context.colors.primary,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: AppSpacing.spacing20, top: AppSpacing.height20, bottom: AppSpacing.height8),
//                 child: Text(
//                   'Chats',
//                   style: TextStyle(
//                     fontSize: AppSpacing.fontSize32,
//                     fontWeight: FontWeight.bold,
//                     color: context.colors.textPrimary,
//                   ),
//                 ),
//               ),
//               SearchBarWidget(onSearch: (query) {
//                 context.read<ChatListCubit>().searchChatRooms(query);
//               }),
//               Expanded(
//                 child: BlocBuilder<ChatListCubit, ChatListState>(
//                   builder: (context, state) {
//                     if (state is ChatListLoading) {
//                       return _buildLoadingSkeleton();
//                     }

//                     if (state is ChatListLoaded) {
//                       return _buildChatList(
//                         header: 'RECENT CONVERSATIONS',
//                         chatRooms: state.chatRooms,
//                       );
//                     }

//                     if (state is ChatListSearching) {
//                       return _buildChatList(
//                         header: 'SEARCH RESULTS',
//                         chatRooms: state.chatRooms,
//                       );
//                     }

//                     if (state is ChatListEmpty || state is ChatListSearchEmpty) {
//                       return const SingleChildScrollView(
//                         physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//                         child: SizedBox(
//                           height: 500,
//                           child: ChatListEmptyState(),
//                         ),
//                       );
//                     }

//                     if (state is ChatListError) {
//                       return SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//                         child: SizedBox(
//                           height: 500,
//                           child: BridgeXErrorWidget(
//                             errorMessage: state.message,
//                             errorTittle: 'Failed to Load Chats',
//                             refreshButtonTap: () => context.read<ChatListCubit>().loadChatRooms(),
//                           ),
//                         ),
//                       );
//                     }

//                     return const Center(child: Text('Welcome to your chats!'));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static const _mockChatRooms = [
//     ChatRoomEntity(teamId: '', teamName: 'Team Alpha', lastMessage: 'This is a long placeholder message that shimmers to show loading layout', lastMessageSenderName: 'Teammate', lastMessageAt: null, unreadCount: 0),
//     ChatRoomEntity(teamId: '', teamName: 'Backend Core Group', lastMessage: 'This is a long placeholder message that shimmers to show loading layout', lastMessageSenderName: 'Teammate', lastMessageAt: null, unreadCount: 0),
//     ChatRoomEntity(teamId: '', teamName: 'Team Alpha', lastMessage: 'This is a long placeholder message that shimmers to show loading layout', lastMessageSenderName: 'Teammate', lastMessageAt: null, unreadCount: 0),
//     ChatRoomEntity(teamId: '', teamName: 'Backend Core Group', lastMessage: 'This is a long placeholder message that shimmers to show loading layout', lastMessageSenderName: 'Teammate', lastMessageAt: null, unreadCount: 0),
//   ];

//   Widget _buildLoadingSkeleton() {
//     return BridgeXSkeletonizer(
//       enableloading: true,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const ChatListSectionHeader(title: 'RECENT CONVERSATIONS'),
//           Expanded(
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _mockChatRooms.length,
//               itemBuilder: (context, index) {
//                 return ChatRoomListTile(
//                   chatRoom: _mockChatRooms[index],
//                   onTapped: (_) {},
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatList({required String header, required List<ChatRoomEntity> chatRooms}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ChatListSectionHeader(title: header),
//         Expanded(
//           child: ListView.builder(
//             physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//             itemCount: chatRooms.length,
//             itemBuilder: (context, index) {
//               final chatRoom = chatRooms[index];
//               return ChatRoomListTile(
//                 chatRoom: chatRoom,
//                 onTapped: (teamId) async {
//                   await context.read<ChatListCubit>().onChatRoomOpened(teamId);
//                   if (!context.mounted) return;
//                   final path = '${BridgeXRoutePaths.chat}/${BridgeXRoutePaths.chatDetails}/$teamId';
//                   context.push(path, extra: chatRoom.teamName);
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
