import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  const ChatRoomModel({
    required super.teamId,
    required super.teamName,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageAt,
    required super.unreadCount,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    final chatRoom = json['chat_rooms'] as Map<String, dynamic>;
    return ChatRoomModel(
      teamId: chatRoom['team_id'] as String,
      teamName: chatRoom['team_name'] as String,
      lastMessage: chatRoom['last_message'] as String?,
      lastMessageSenderName: chatRoom['last_message_sender_name'] as String?,
      lastMessageAt: chatRoom['last_message_at'] != null
          ? DateTime.parse(chatRoom['last_message_at'] as String)
          : null,
      unreadCount: json['unread_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'team_name': teamName,
      'last_message': lastMessage,
      'last_message_sender_name': lastMessageSenderName,
      'last_message_at': lastMessageAt?.toIso8601String(),
      'unread_count': unreadCount,
    };
  }

}