import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing10),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: AppSpacing.spacing20, bottom: AppSpacing.spacing16),
                  itemCount: chatMessages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const DayIndicator(day: AppStrings.today),
                          VerticalSpacing(AppSpacing.spacing24),
                        ],
                      );
                    }

                    final message = chatMessages[index - 1];

                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.height12),
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
