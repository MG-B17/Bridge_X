import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:bridge_x/core/error/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms();
  Future<Either<Failure, List<ChatRoomEntity>>> searchChatRooms(String query);
  Stream<List<ChatRoomEntity>> subscribeToChatRooms();
  Future<Either<Failure, void>> resetUnreadCount(String teamId);
  Future<Either<Failure, void>> reconcileMembership();
  Future<Either<Failure, void>> createChatRoom({
    required String teamId,
    required String teamName,
    required String creatorId,
    required List<String> memberIds,
  });

  Future<Either<Failure, List<MessageEntity>>> getMessages(String teamId, {String? lastCreatedAt, int limit = 20});
  Future<Either<Failure, MessageEntity>> sendMessage(String teamId, String content, String senderName);
  Stream<MessageEntity> watchMessages(String teamId);
}