import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EditMessage implements UseCase<void, EditMessageParams> {
  final ChatRepository repository;

  EditMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(EditMessageParams params) async {
    return await repository.editMessage(params.messageId, params.newContent);
  }
}

class EditMessageParams extends Equatable {
  final String messageId;
  final String newContent;

  const EditMessageParams({required this.messageId, required this.newContent});

  @override
  List<Object?> get props => [messageId, newContent];
}
