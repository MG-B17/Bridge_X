import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MarkMessageRead implements UseCase<void, MarkMessageReadParams> {
  final ChatRepository repository;

  MarkMessageRead(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkMessageReadParams params) async {
    return await repository.markMessageRead(params.messageId, params.userId);
  }
}

class MarkMessageReadParams extends Equatable {
  final String messageId;
  final int userId;

  const MarkMessageReadParams({required this.messageId, required this.userId});

  @override
  List<Object?> get props => [messageId, userId];
}
