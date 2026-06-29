import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetChatRooms implements UseCase<List<ChatRoomEntity>, GetChatRoomsParams> {
  final ChatRepository repository;

  GetChatRooms(this.repository);

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> call(GetChatRoomsParams params) async {
    return await repository.getChatRooms(params.userId);
  }
}

class GetChatRoomsParams extends Equatable {
  final int userId;

  const GetChatRoomsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
