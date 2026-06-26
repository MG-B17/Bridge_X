import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_user_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:bridge_x/core/error/failure.dart';

abstract class ChatRepository {
  // Chat Rooms
  Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms(int userId);
  Future<Either<Failure, List<ChatRoomEntity>>> searchChatRooms(int userId, String query);
  Stream<Either<Failure, List<ChatRoomEntity>>> subscribeToChatRooms(int userId);
  Future<Either<Failure, void>> createChatRoom(int teamId, String teamName, int creatorId, List<int> memberIds);
  Future<Either<Failure, void>> changeChatRoomLeader(String roomId, int newLeaderId, int oldLeaderId);
  Future<Either<Failure, void>> deleteChatRoom(String roomId);

  // Messages
  Future<Either<Failure, List<MessageEntity>>> getMessages(String roomId, int userId, {String? cursor, int limit = 20});
  Future<Either<Failure, MessageEntity>> sendMessage(String roomId, int senderId, String content);
  Future<Either<Failure, void>> editMessage(String messageId, String newContent);
  Future<Either<Failure, void>> deleteMessage(String messageId);
  Stream<Either<Failure, MessageEntity>> watchMessages(String roomId, int userId);

  // Message Status
  Future<Either<Failure, void>> markMessagesDelivered(String roomId, int userId);
  Future<Either<Failure, void>> markMessageRead(String messageId, int userId);
  Future<Either<Failure, void>> resetUnreadCount(String roomId, int userId);

  // Join Requests
  Future<Either<Failure, void>> sendJoinRequest(String roomId, int userId);
  Future<Either<Failure, List<JoinRequestEntity>>> getJoinRequests(String roomId);
  Future<Either<Failure, void>> acceptJoinRequest(String requestId);
  Future<Either<Failure, void>> rejectJoinRequest(String requestId);

  // Invitations
  Future<Either<Failure, void>> sendInvitation(String roomId, int inviterId, int inviteeId);
  Future<Either<Failure, List<InvitationEntity>>> getInvitations(int userId);
  Future<Either<Failure, void>> acceptInvitation(String invitationId);
  Future<Either<Failure, void>> rejectInvitation(String invitationId);

  // Chat Users
  Future<Either<Failure, void>> saveUserChatData(int userId, String username, String? email);
  Future<Either<Failure, ChatUserEntity?>> getUserChatData(int userId);
  Future<Either<Failure, void>> deleteUserChatData(int userId);
  Future<Either<Failure, void>> updateUsername(int userId, String newUsername);

  // Members
  Future<Either<Failure, List<ChatUserEntity>>> getRoomMembers(String roomId);
}
