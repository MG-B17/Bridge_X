// import 'package:bridge_x/core/error/exception.dart';
// import 'package:bridge_x/core/error/failure.dart';
// import 'package:bridge_x/core/services/logger_service.dart';
// import 'package:bridge_x/features/chat/data/datasources/chat_remote_datasource.dart';
// import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
// import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
// import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
// import 'package:dartz/dartz.dart';

// class ChatRepositoryImpl implements ChatRepository {
//   final ChatRemoteDataSource remoteDataSource;

//   ChatRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<ChatRoomEntity>>> getChatRooms() async {
//     try {
//       final chatRoomModels = await remoteDataSource.getChatRooms();
//       return Right(chatRoomModels);
//     } on ServerException catch (e) {
//       LoggerService.error('getChatRooms: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('getChatRooms: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<ChatRoomEntity>>> searchChatRooms(String query) async {
//     try {
//       final chatRoomModels = await remoteDataSource.searchChatRooms(query);
//       return Right(chatRoomModels);
//     } on ServerException catch (e) {
//       LoggerService.error('searchChatRooms: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('searchChatRooms: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Stream<List<ChatRoomEntity>> subscribeToChatRooms() {
//     return remoteDataSource.subscribeToChatRooms();
//   }

//   @override
//   Future<Either<Failure, void>> resetUnreadCount(String teamId) async {
//     try {
//       await remoteDataSource.resetUnreadCount(teamId);
//       return const Right(null);
//     } on ServerException catch (e) {
//       LoggerService.error('resetUnreadCount: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('resetUnreadCount: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> reconcileMembership() async {
//     try {
//       await remoteDataSource.reconcileMembership();
//       return const Right(null);
//     } on ServerException catch (e) {
//       LoggerService.error('reconcileMembership: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('reconcileMembership: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> createChatRoom({
//     required String teamId,
//     required String teamName,
//     required String creatorId,
//     required List<String> memberIds,
//   }) async {
//     try {
//       await remoteDataSource.createChatRoom(
//         teamId: teamId,
//         teamName: teamName,
//         creatorId: creatorId,
//         memberIds: memberIds,
//       );
//       return const Right(null);
//     } on ServerException catch (e) {
//       LoggerService.error('createChatRoom: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('createChatRoom: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<MessageEntity>>> getMessages(String teamId, {String? lastCreatedAt, int limit = 20}) async {
//     try {
//       final messageModels = await remoteDataSource.getMessages(
//         teamId,
//         lastCreatedAt: lastCreatedAt,
//         limit: limit,
//       );
//       return Right(messageModels);
//     } on ServerException catch (e) {
//       LoggerService.error('getMessages: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('getMessages: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, MessageEntity>> sendMessage(String teamId, String content, String senderName) async {
//     try {
//       final messageModel = await remoteDataSource.sendMessage(teamId, content, senderName);
//       return Right(messageModel);
//     } on ServerException catch (e) {
//       LoggerService.error('sendMessage: ServerException', exception: e.message, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.message ?? 'Server error'));
//     } catch (e) {
//       LoggerService.error('sendMessage: unexpected error', exception: e, tag: 'ChatRepository');
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }

//   @override
//   Stream<MessageEntity> watchMessages(String teamId) {
//     return remoteDataSource.watchMessages(teamId);
//   }
// }
