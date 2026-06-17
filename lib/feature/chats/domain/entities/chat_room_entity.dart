import 'latest_message_entity.dart';

class ChatRoomEntity {
  final int chatRoomId;
  final int teamId;
  final String teamName;
  final String? avatarUrl;
  final LatestMessageEntity? latestMessage;
  final int unreadCount;

  ChatRoomEntity({
    required this.chatRoomId,
    required this.teamId,
    required this.teamName,
    this.avatarUrl,
    this.latestMessage,
    required this.unreadCount,
  });
}
