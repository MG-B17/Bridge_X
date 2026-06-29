import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteChatRoom implements UseCase<void, DeleteChatRoomParams> {
  final ChatRepository repository;

  DeleteChatRoom(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteChatRoomParams params) async {
    return await repository.deleteChatRoom(params.roomId);
  }
}

class DeleteChatRoomParams extends Equatable {
  final String roomId;

  const DeleteChatRoomParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
