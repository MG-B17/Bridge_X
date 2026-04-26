import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/chat_room_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_area.dart';
import '../widgets/chat_code_block.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: const ChatRoomHeader(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(context.spacing.xl),
              children: [
                _buildDateDivider(context, AppStrings.today),
                VSpace(context.spacing.xl),
                const ChatBubble(
                  senderName: 'Alex Rivers',
                  avatarUrl: 'https://i.pravatar.cc/150?u=alex',
                  message: 'Hey team! I\'ve updated the API documentation for the new authentication flow. Take a look when you can.',
                  time: '10:42 AM',
                ),
                const ChatBubble(
                  isMe: true,
                  message: 'Awesome, thanks Alex. Just finished the front-end validation logic for that part.',
                  time: '10:45 AM',
                ),
                ChatBubble(
                  senderName: 'Sarah Chen',
                  avatarUrl: 'https://i.pravatar.cc/150?u=sarah',
                  content: const ChatCodeBlock(
                    fileName: 'auth.ts',
                    language: 'Typescript',
                    code: 'export const validateSession = (token: string) => {\n  if (!token) return false;\n  const decoded = jwt.verify(token, SECRET);\n  return decoded.exp > Date.now() / 1000;\n};',
                  ),
                  message: 'I used this helper to keep the logic clean. Let me know if we need extra checks.',
                  time: '10:52 AM',
                ),
                const ChatBubble(
                  isMe: true,
                  message: 'Looks solid. 🚀',
                  time: '10:55 AM',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.spacing.md),
            child: const ChatInputArea(),
          ),
          VSpace(context.spacing.sm),
        ],
      ),
    );
  }

  Widget _buildDateDivider(BuildContext context, String date) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: context.colors.textHint.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          date.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
