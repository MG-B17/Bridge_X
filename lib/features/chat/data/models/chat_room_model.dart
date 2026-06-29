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
    final chatRoom = json['chat_rooms'] as Map<String, dynamic>? ?? {};
    return ChatRoomModel(
      roomId: json['room_id'] as String,
      teamId: chatRoom['team_id'] as int? ?? json['team_id'] as int? ?? 0,
      teamName: chatRoom['team_name'] as String? ?? json['team_name'] as String? ?? '',
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

  @override
  ChatRoomModel copyWith({
    String? roomId,
    int? teamId,
    String? teamName,
    String? lastMessage,
    String? lastMessageSenderName,
    int? lastMessageSenderId,
    DateTime? lastMessageAt,
    int? unreadCount,
    int? leaderId,
    String? role,
  }) {
    return ChatRoomModel(
      roomId: roomId ?? this.roomId,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderName: lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      leaderId: leaderId ?? this.leaderId,
      role: role ?? this.role,
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
