import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_state.dart';
import 'package:bridge_x/features/chat/presentation/widgets/message_input_widget.dart';
import 'package:bridge_x/features/chat/presentation/widgets/message_list_widget.dart';

class ChatRoomPage extends StatelessWidget {
  final String roomId;

  const ChatRoomPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatRoomCubit>();
    cubit.init();

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocSelector<ChatRoomCubit, ChatRoomState, ChatRoomState>(
              selector: (state) => state,
              builder: (context, state) {
                return _buildBody(state, cubit, context);
              },
            ),
          ),
          BlocSelector<ChatRoomCubit, ChatRoomState, bool>(
            selector: (state) => state is ChatRoomLoaded && state.sendingMessage,
            builder: (context, isSending) {
              return isSending
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    )
                  : const SizedBox.shrink();
            },
          ),
          MessageInputWidget(onSend: (content) => cubit.sendMessage(content)),
        ],
      ),
    );
  }

  Widget _buildBody(ChatRoomState state, ChatRoomCubit cubit, BuildContext context) {
    switch (state) {
      case ChatRoomInitial():
        return const SizedBox.shrink();
      case ChatRoomLoading():
        return const Center(child: CircularProgressIndicator());
      case ChatRoomLoaded(:final messages, :final hasMore, :final loadingMore):
        return MessageListWidget(
          messages: messages,
          hasMore: hasMore,
          loadingMore: loadingMore,
          currentUserId: cubit.userId,
          onLoadMore: () => cubit.loadMoreMessages(),
        );
      case ChatRoomError(:final message):
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: context.colors.error),
              SizedBox(height: AppSpacing.height16),
              Text(message, style: TextStyle(color: context.colors.error)),
              SizedBox(height: AppSpacing.height16),
              ElevatedButton(
                onPressed: () => cubit.init(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
