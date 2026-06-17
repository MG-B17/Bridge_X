import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  final String teamId;
  final String teamName;
  final String? lastMessage;
  final String? lastMessageSenderName;
  final DateTime? lastMessageAt;
  final int unreadCount;

  const ChatRoomEntity({
    required this.teamId,
    required this.teamName,
    this.lastMessage,
    this.lastMessageSenderName,
    this.lastMessageAt,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
    teamId,
    teamName,
    lastMessage,
    lastMessageSenderName,
    lastMessageAt,
    unreadCount,
  ];
}
