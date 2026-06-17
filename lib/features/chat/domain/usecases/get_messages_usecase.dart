import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetMessages implements UseCase<List<MessageEntity>, GetMessagesParams> {
  final ChatRepository repository;

  GetMessages(this.repository);

  @override
  Future<Either<Failure, List<MessageEntity>>> call(GetMessagesParams params) async {
    return await repository.getMessages(
      params.teamId,
      lastCreatedAt: params.lastCreatedAt,
      limit: params.limit,
    );
  }
}

class GetMessagesParams extends Equatable {
  final String teamId;
  final String? lastCreatedAt;
  final int limit;

  const GetMessagesParams({
    required this.teamId,
    this.lastCreatedAt,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [teamId, lastCreatedAt, limit];
}
