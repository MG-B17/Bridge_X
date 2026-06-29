import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_user_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms(int userId) async {
    try {
      final rooms = await remoteDataSource.getChatRooms(userId);
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to load chat rooms'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> searchChatRooms(int userId, String query) async {
    try {
      final rooms = await remoteDataSource.searchChatRooms(userId, query);
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Search failed'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatRoomEntity>>> subscribeToChatRooms(int userId) {
    return remoteDataSource.subscribeToChatRooms(userId).map(
      (rooms) => Right<Failure, List<ChatRoomEntity>>(rooms),
    ).handleError((error) {
      LoggerService.error('subscribeToChatRooms error', exception: error, tag: 'ChatRepository');
      return Left<Failure, List<ChatRoomEntity>>(ServerFailure(message: error.toString()));
    });
  }

  @override
  Future<Either<Failure, void>> createChatRoom(int teamId, String teamName, int creatorId, List<int> memberIds) async {
    try {
      await remoteDataSource.createChatRoom(teamId, teamName, creatorId, memberIds);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create chat room'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeChatRoomLeader(String roomId, int newLeaderId, int oldLeaderId) async {
    try {
      await remoteDataSource.changeChatRoomLeader(roomId, newLeaderId, oldLeaderId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to change leader'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatRoom(String roomId) async {
    try {
      await remoteDataSource.deleteChatRoom(roomId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete chat room'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages(String roomId, int userId, {String? cursor, int limit = 20}) async {
    try {
      final messages = await remoteDataSource.getMessages(roomId, userId, cursor: cursor, limit: limit);
      return Right(messages);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to load messages'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(String roomId, int senderId, String content) async {
    try {
      final message = await remoteDataSource.sendMessage(roomId, senderId, content);
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to send message'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editMessage(String messageId, String newContent) async {
    try {
      await remoteDataSource.editMessage(messageId, newContent);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to edit message'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      await remoteDataSource.deleteMessage(messageId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete message'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, MessageEntity>> watchMessages(String roomId, int userId) {
    return remoteDataSource.watchMessages(roomId, userId).map(
      (message) => Right<Failure, MessageEntity>(message),
    ).handleError((error) {
      LoggerService.error('watchMessages error', exception: error, tag: 'ChatRepository');
      return Left<Failure, MessageEntity>(ServerFailure(message: error.toString()));
    });
  }

  @override
  Future<Either<Failure, void>> markMessagesDelivered(String roomId, int userId) async {
    try {
      await remoteDataSource.markMessagesDelivered(roomId, userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to mark delivered'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageRead(String messageId, int userId) async {
    try {
      await remoteDataSource.markMessageRead(messageId, userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to mark read'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetUnreadCount(String roomId, int userId) async {
    try {
      await remoteDataSource.resetUnreadCount(roomId, userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to reset unread count'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendJoinRequest(String roomId, int userId) async {
    try {
      await remoteDataSource.sendJoinRequest(roomId, userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to send join request'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JoinRequestEntity>>> getJoinRequests(String roomId) async {
    try {
      final requests = await remoteDataSource.getJoinRequests(roomId);
      return Right(requests);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get join requests'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptJoinRequest(String requestId) async {
    try {
      await remoteDataSource.acceptJoinRequest(requestId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to accept request'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectJoinRequest(String requestId) async {
    try {
      await remoteDataSource.rejectJoinRequest(requestId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to reject request'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendInvitation(String roomId, int inviterId, int inviteeId) async {
    try {
      await remoteDataSource.sendInvitation(roomId, inviterId, inviteeId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to send invitation'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvitationEntity>>> getInvitations(int userId) async {
    try {
      final invitations = await remoteDataSource.getInvitations(userId);
      return Right(invitations);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get invitations'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptInvitation(String invitationId) async {
    try {
      await remoteDataSource.acceptInvitation(invitationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to accept invitation'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectInvitation(String invitationId) async {
    try {
      await remoteDataSource.rejectInvitation(invitationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to reject invitation'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserChatData(int userId, String username, String? email) async {
    try {
      await remoteDataSource.saveUserChatData(userId, username, email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to save user data'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatUserEntity?>> getUserChatData(int userId) async {
    try {
      final user = await remoteDataSource.getUserChatData(userId);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get user data'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserChatData(int userId) async {
    try {
      await remoteDataSource.deleteUserChatData(userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete user data'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUsername(int userId, String newUsername) async {
    try {
      await remoteDataSource.updateUsername(userId, newUsername);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update username'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatUserEntity>>> getRoomMembers(String roomId) async {
    try {
      final members = await remoteDataSource.getRoomMembers(roomId);
      return Right(members);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get room members'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getRoomIdByTeamId(int teamId) async {
    try {
      final roomId = await remoteDataSource.getRoomIdByTeamId(teamId);
      return Right(roomId);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get room ID'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addMemberToChatRoom(String roomId, int userId, {String role = 'member', String? username}) async {
    try {
      await remoteDataSource.addMemberToChatRoom(roomId, userId, role: role, username: username);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to add member'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<bool> get connectionStatus => remoteDataSource.connectionStatus;

  @override
  Stream<Either<Failure, bool>> watchRoomMembership(String roomId, int userId) {
    return remoteDataSource.watchRoomMembership(roomId, userId).map(
      (removed) => Right<Failure, bool>(removed),
    ).handleError((error) {
      LoggerService.error('watchRoomMembership error', exception: error, tag: 'ChatRepository');
      return Left<Failure, bool>(ServerFailure(message: error.toString()));
    });
  }
}
