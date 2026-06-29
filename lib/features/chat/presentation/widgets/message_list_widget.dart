import 'package:flutter/material.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/presentation/widgets/message_bubble_widget.dart';

class MessageListWidget extends StatelessWidget {
  final List<MessageEntity> messages;
  final bool hasMore;
  final bool loadingMore;
  final int currentUserId;
  final VoidCallback onLoadMore;

  const MessageListWidget({
    super.key,
    required this.messages,
    required this.hasMore,
    required this.loadingMore,
    required this.currentUserId,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(
        child: Text('No messages yet. Start the conversation!'),
      );
    }

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.symmetric(vertical: AppSpacing.height8),
      itemCount: messages.length + (loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (loadingMore && index == 0) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final messageIndex = loadingMore ? index - 1 : index;
        final message = messages[messageIndex];
        final isCurrentUser = message.senderId == currentUserId;

        return MessageBubbleWidget(
          key: ValueKey(message.messageId.isNotEmpty ? message.messageId : message.localId),
          message: message,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }
}
