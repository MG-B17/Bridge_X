import 'package:bridge_x/features/chat/domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  const ChatUserModel({
    required super.userId,
    required super.username,
    super.email,
    super.avatarUrl,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      userId: json['user_id'] as int,
      username: json['username'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }
}
