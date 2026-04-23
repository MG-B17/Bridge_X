import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bubble_content.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final String? senderName;
  final String time;
  final bool isMe;
  final Widget? content;

  const ChatBubble({
    super.key,
    this.message,
    this.senderName,
    required this.time,
    this.isMe = false,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.lg),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe && senderName != null) _buildSenderName(context),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) _buildAvatar(context),
              if (!isMe) HSpace(context.spacing.sm),
              BubbleContent(message: message, isMe: isMe, content: content),
            ],
          ),
          _BubbleFooter(isMe: isMe, time: time),
        ],
      ),
    );
  }

  Widget _buildSenderName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.xs, left: context.spacing.md),
      child: Text(
        senderName!,
        style: context.labelSmall.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.blue.shade100,
      backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=alex'),
    );
  }
}

class _BubbleFooter extends StatelessWidget {
  final bool isMe;
  final String time;
  const _BubbleFooter({required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.spacing.xs,
        left: isMe ? 0 : 48.w,
        right: isMe ? context.spacing.sm : 0,
      ),
      child: Text(
        isMe ? 'You · $time' : time,
        style: context.labelSmall.copyWith(
          color: context.colors.textHint,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
