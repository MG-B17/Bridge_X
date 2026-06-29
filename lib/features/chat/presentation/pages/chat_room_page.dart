import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
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

    return BlocListener<ChatRoomCubit, ChatRoomState>(
      listenWhen: (previous, current) => current is ChatRoomRemoved,
      listener: (context, state) {
        if (state is ChatRoomRemoved) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
                buildWhen: (previous, current) => current.runtimeType != previous.runtimeType,
                builder: (context, state) {
                  switch (state) {
                    case ChatRoomInitial():
                      return const SizedBox.shrink();
                    case ChatRoomLoading():
                      return const Center(child: CircularProgressIndicator());
                    case ChatRoomLoaded():
                      return _MessageListView(cubit: cubit);
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
            BlocSelector<ChatRoomCubit, ChatRoomState, bool>(
              selector: (state) => state is ChatRoomRemoved,
              builder: (context, isRemoved) {
                return isRemoved
                    ? const SizedBox.shrink()
                    : MessageInputWidget(onSend: (content) => cubit.sendMessage(content));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageListView extends StatelessWidget {
  final ChatRoomCubit cubit;

  const _MessageListView({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatRoomCubit, ChatRoomState, _MessageListProps>(
      selector: (state) {
        if (state is ChatRoomLoaded) {
          return _MessageListProps(
            messages: state.messages,
            hasMore: state.hasMore,
            loadingMore: state.loadingMore,
          );
        }
        return const _MessageListProps();
      },
      builder: (context, props) {
        return MessageListWidget(
          messages: props.messages,
          hasMore: props.hasMore,
          loadingMore: props.loadingMore,
          currentUserId: cubit.userId,
          onLoadMore: () => cubit.loadMoreMessages(),
        );
      },
    );
  }
}

class _MessageListProps {
  final List<MessageEntity> messages;
  final bool hasMore;
  final bool loadingMore;

  const _MessageListProps({
    this.messages = const [],
    this.hasMore = false,
    this.loadingMore = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _MessageListProps &&
          hasMore == other.hasMore &&
          loadingMore == other.loadingMore &&
          _listEquals(messages, other.messages);

  @override
  int get hashCode => Object.hash(messages.length, hasMore, loadingMore);

  static bool _listEquals(List<MessageEntity> a, List<MessageEntity> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
