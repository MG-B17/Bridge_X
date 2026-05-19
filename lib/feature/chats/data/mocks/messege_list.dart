import 'package:bridge_x/core/constant/bridge_x_strings.dart';

import '../models/message_model.dart';

final List<MessageModel> messages = [
  MessageModel(
    senderName: 'Alex Rivers',
    message: AppStrings.msgBackendComplete,
    time: '10:42 AM',
    avatar: 'https://randomuser.me/api/portraits/women/28.jpg',
    isMe: false,
  ),
  MessageModel(
    senderName: 'Alex Rivers',
    message: AppStrings.msgUiReply,
    time: '10:45 AM',
    avatar: 'https://randomuser.me/api/portraits/women/28.jpg',
    isMe: true,
  ),
  MessageModel(
    senderName: 'Sarah Chen',
    message: AppStrings.msgAuthTest,
    time: '10:52 AM',
    avatar: 'https://randomuser.me/api/portraits/women/28.jpg',
    isMe: false,
  ),
];
