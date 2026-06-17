import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import '../datasource/chats_remote_data_source.dart';
import '../models/chat_room_response_model.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../../domain/entities/chat_user_entity.dart';
import '../../domain/entities/latest_message_entity.dart';
import '../../domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> getMyChats() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChats = await remoteDataSource.getMyChats();
        final entities = remoteChats.map((model) => _mapModelToEntity(model)).toList();
        return Right(entities);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error));
      } catch (e) {
        return Left(ServerFailure(message: ErrorStrings.serverError));
      }
    } else {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  ChatRoomEntity _mapModelToEntity(ChatRoomResponseModel model) {
    return ChatRoomEntity(
      chatRoomId: model.chatRoomId,
      teamId: model.teamId,
      teamName: model.teamName,
      avatarUrl: model.avatarUrl,
      unreadCount: model.unreadCount,
      latestMessage: model.latestMessage != null
          ? LatestMessageEntity(
              id: model.latestMessage!.id,
              body: model.latestMessage!.body,
              createdAt: model.latestMessage!.createdAt,
              user: ChatUserEntity(
                id: model.latestMessage!.user.id,
                fullName: model.latestMessage!.user.fullName,
              ),
            )
          : null,
    );
  }
}
