// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:bridge_x/core/extensions/context_extension.dart';
// import 'package:bridge_x/core/theme/bridge_x_colors.dart';
// import 'package:bridge_x/core/utils/app_spacing.dart';
// import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
// import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
// import 'package:bridge_x/features/chat/presentation/bloc/chat_room_state.dart';
// import 'package:bridge_x/features/chat/presentation/widgets/message_bubble_widget.dart';

// class MessageListWidget extends StatefulWidget {
//   final bool hasMore;
//   final bool loadingMore;

//   const MessageListWidget({
//     super.key,
//     required this.hasMore,
//     required this.loadingMore,
//   });

//   @override
//   State<MessageListWidget> createState() => _MessageListWidgetState();
// }

// class _MessageListWidgetState extends State<MessageListWidget> {
//   final _scrollController = ScrollController();
//   /// Whether auto-scroll to bottom is enabled (within 150px of bottom).
//   bool _autoScroll = true;
//   StreamSubscription? _cubitSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _cubitSubscription = context.read<ChatRoomCubit>().stream.listen((state) {
//       if (state is ChatRoomLoaded && !_scrollController.hasClients) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_scrollController.hasClients && _autoScroll) {
//             _scrollController.animateTo(
//               0,
//               duration: const Duration(milliseconds: 200),
//               curve: Curves.easeOut,
//             );
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _cubitSubscription?.cancel();
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     _autoScroll = (maxScroll - currentScroll) < 150;

//     if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent + 50) {
//       context.read<ChatRoomCubit>().loadMoreMessages();
//     }
//   }

//   Widget _buildDateSeparator(DateTime date) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final msgDate = DateTime(date.year, date.month, date.day);
    
//     String text = '';
//     if (msgDate == today) {
//       text = 'TODAY';
//     } else if (msgDate == yesterday) {
//       text = 'YESTERDAY';
//     } else {
//       text = DateFormat('MMMM dd, yyyy').format(date).toUpperCase();
//     }

//     return Center(
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: AppSpacing.height16),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//         decoration: BoxDecoration(
//           color: AppColors.today,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: AppColors.indigo,
//             fontWeight: FontWeight.bold,
//             fontSize: AppSpacing.fontSize11,
//             letterSpacing: 1.0,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentUserId = context.read<ChatRoomCubit>().currentUserId;

//     return BlocBuilder<ChatRoomCubit, ChatRoomState>(
//       builder: (context, state) {
//         if (state is ChatRoomError) {
//           return SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//             child: SizedBox(
//               height: 500,
//               child: BridgeXErrorWidget(
//                 errorMessage: state.message,
//                 errorTittle: 'Failed to Load Messages',
//                 refreshButtonTap: () => context.read<ChatRoomCubit>().loadMessages(),
//               ),
//             ),
//           );
//         }

//         if (state is ChatRoomInitial || state is ChatRoomLoading) {
//           final mockMessages = List.generate(
//             6,
//             (index) => MessageEntity(
//               messageId: '',
//               teamId: '',
//               senderId: index % 2 == 0 ? currentUserId : 'other',
//               senderName: index % 2 == 0 ? 'You' : 'Teammate Name',
//               content: index % 2 == 0
//                   ? 'Short message placeholder'
//                   : 'A much longer message placeholder content that takes up multiple lines to simulate real chat conversations.',
//               localId: '',
//               createdAt: DateTime.now(),
//             ),
//           );
//           return ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             reverse: true,
//             padding: EdgeInsets.only(top: AppSpacing.height12, bottom: AppSpacing.height8),
//             itemCount: mockMessages.length,
//             itemBuilder: (context, index) {
//               final message = mockMessages[index];
//               return MessageBubbleWidget(
//                 message: message,
//                 isCurrentUser: message.senderId == currentUserId,
//               );
//             },
//           );
//         }

//         if (state is ChatRoomLoaded) {
//           final messages = state.messages;

//           if (messages.isEmpty) {
//             return Center(
//               child: Text(
//                 'No messages yet. Say hello!',
//                 style: TextStyle(color: context.colors.textSecondary),
//               ),
//             );
//           }

//           return ListView.builder(
//             controller: _scrollController,
//             reverse: true,
//             padding: EdgeInsets.only(top: AppSpacing.height12, bottom: AppSpacing.height8),
//             itemCount: messages.length + (widget.loadingMore ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (widget.loadingMore && index == messages.length) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: AppSpacing.height16),
//                   child: Center(child: SizedBox(width: AppSpacing.spacing24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
//                 );
//               }
//               final message = messages[index];
              
//               bool showDateSeparator = false;
//               if (message.createdAt != null) {
//                 if (index == messages.length - 1) {
//                   showDateSeparator = true;
//                 } else {
//                   final nextMessage = messages[index + 1];
//                   if (nextMessage.createdAt != null) {
//                     final date1 = DateTime(message.createdAt!.year, message.createdAt!.month, message.createdAt!.day);
//                     final date2 = DateTime(nextMessage.createdAt!.year, nextMessage.createdAt!.month, nextMessage.createdAt!.day);
//                     if (date1 != date2) {
//                       showDateSeparator = true;
//                     }
//                   }
//                 }
//               }

//               final bubble = MessageBubbleWidget(
//                 message: message,
//                 isCurrentUser: message.senderId == currentUserId,
//               );

//               if (showDateSeparator && message.createdAt != null) {
//                 return Column(
//                   children: [
//                     _buildDateSeparator(message.createdAt!),
//                     bubble,
//                   ],
//                 );
//               }

//               return bubble;
//             },
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
