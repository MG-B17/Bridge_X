import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteMessage implements UseCase<void, DeleteMessageParams> {
  final ChatRepository repository;

  DeleteMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteMessageParams params) async {
    return await repository.deleteMessage(params.messageId);
  }
}

class DeleteMessageParams extends Equatable {
  final String messageId;

  const DeleteMessageParams({required this.messageId});

  @override
  List<Object?> get props => [messageId];
}
