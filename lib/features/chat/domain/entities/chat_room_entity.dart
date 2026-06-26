import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  final String roomId;
  final int teamId;
  final String teamName;
  final String? lastMessage;
  final String? lastMessageSenderName;
  final int? lastMessageSenderId;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final int? leaderId;
  final String? role;

  const ChatRoomEntity({
    required this.roomId,
    required this.teamId,
    required this.teamName,
    this.lastMessage,
    this.lastMessageSenderName,
    this.lastMessageSenderId,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.leaderId,
    this.role,
  });

  ChatRoomEntity copyWith({
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
    return ChatRoomEntity(
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

  @override
  List<Object?> get props => [
    roomId,
    teamId,
    teamName,
    lastMessage,
    lastMessageSenderName,
    lastMessageSenderId,
    lastMessageAt,
    unreadCount,
    leaderId,
    role,
  ];
}
