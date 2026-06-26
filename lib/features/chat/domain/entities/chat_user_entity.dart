import 'package:equatable/equatable.dart';

class ChatUserEntity extends Equatable {
  final int userId;
  final String username;
  final String? email;
  final String? avatarUrl;

  const ChatUserEntity({
    required this.userId,
    required this.username,
    this.email,
    this.avatarUrl,
  });

  ChatUserEntity copyWith({
    int? userId,
    String? username,
    String? email,
    String? avatarUrl,
  }) {
    return ChatUserEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [userId, username, email, avatarUrl];
}
