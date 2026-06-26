import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
  const ChatRoomModel({
    required super.roomId,
    required super.teamId,
    required super.teamName,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageSenderId,
    super.lastMessageAt,
    required super.unreadCount,
    super.leaderId,
    super.role,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      roomId: json['room_id'] as String,
      teamId: json['team_id'] as int,
      teamName: json['team_name'] as String,
      lastMessage: json['last_message'] as String?,
      lastMessageSenderName: json['last_message_sender_name'] as String?,
      lastMessageSenderId: json['last_message_sender_id'] as int?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      unreadCount: json['unread_count'] as int? ?? 0,
      leaderId: json['leader_id'] as int?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'team_id': teamId,
      'team_name': teamName,
      'last_message': lastMessage,
      'last_message_sender_name': lastMessageSenderName,
      'last_message_sender_id': lastMessageSenderId,
      'last_message_at': lastMessageAt?.toIso8601String(),
      'unread_count': unreadCount,
      'leader_id': leaderId,
      'role': role,
    };
  }
}
