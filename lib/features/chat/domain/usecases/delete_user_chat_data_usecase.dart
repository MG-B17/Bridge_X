import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteUserChatData implements UseCase<void, DeleteUserChatDataParams> {
  final ChatRepository repository;

  DeleteUserChatData(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteUserChatDataParams params) async {
    return await repository.deleteUserChatData(params.userId);
  }
}

class DeleteUserChatDataParams extends Equatable {
  final int userId;

  const DeleteUserChatDataParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
