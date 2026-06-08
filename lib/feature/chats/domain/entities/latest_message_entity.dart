import 'chat_user_entity.dart';

class LatestMessageEntity {
  final int id;
  final String body;
  final String createdAt;
  final ChatUserEntity user;

  LatestMessageEntity({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.user,
  });
}
