import 'latest_message_response_model.dart';

class ChatRoomResponseModel {
  final int chatRoomId;
  final int teamId;
  final String teamName;
  final String? avatarUrl;
  final LatestMessageResponseModel? latestMessage;
  final int unreadCount;

  ChatRoomResponseModel({
    required this.chatRoomId,
    required this.teamId,
    required this.teamName,
    this.avatarUrl,
    this.latestMessage,
    this.unreadCount = 0,
  });

  factory ChatRoomResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomResponseModel(
      chatRoomId: json['chat_room_id'] as int,
      teamId: json['team_id'] as int,
      teamName: json['team_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      latestMessage: json['latest_message'] != null
          ? LatestMessageResponseModel.fromJson(json['latest_message'] as Map<String, dynamic>)
          : null,
      unreadCount: json['unread_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': chatRoomId,
      'team_id': teamId,
      'team_name': teamName,
      'avatar_url': avatarUrl,
      'latest_message': latestMessage?.toJson(),
      'unread_count': unreadCount,
    };
  }
}
