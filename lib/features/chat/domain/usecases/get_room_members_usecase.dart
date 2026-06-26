import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_user_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRoomMembers implements UseCase<List<ChatUserEntity>, GetRoomMembersParams> {
  final ChatRepository repository;

  GetRoomMembers(this.repository);

  @override
  Future<Either<Failure, List<ChatUserEntity>>> call(GetRoomMembersParams params) async {
    return await repository.getRoomMembers(params.roomId);
  }
}

class GetRoomMembersParams extends Equatable {
  final String roomId;

  const GetRoomMembersParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
