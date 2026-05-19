import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/widget/vertical_spacing.dart';
import '../../data/mocks/messege_list.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/day_indicator.dart';
import '../widgets/message_bubble.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();

  late List<MessageModel> chatMessages;

  @override
  void initState() {
    super.initState();
    chatMessages = List.from(messages);
  }

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      chatMessages.add(
        MessageModel(senderName: 'You', message: text, time: 'Now', avatar: '', isMe: true),
      );
    });

    messageController.clear();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 20.h, bottom: 16.h),
                  itemCount: chatMessages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const DayIndicator(day: AppStrings.today),
                          VerticalSpacing(AppSpacing.xl),
                        ],
                      );
                    }

                    final message = chatMessages[index - 1];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: MessageBubble(messageModel: message),
                    );
                  },
                ),
              ),
            ),

            SafeArea(
              top: false,
              child: ChatInputBar(controller: messageController, onSend: sendMessage),
            ),
          ],
        ),
      ),
    );
  }
}
