import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendMessage implements UseCase<MessageEntity, SendMessageParams> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, MessageEntity>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      params.teamId,
      params.content,
      params.senderName,
    );
  }
}

class SendMessageParams extends Equatable {
  final String teamId;
  final String content;
  final String senderName;

  const SendMessageParams({
    required this.teamId,
    required this.content,
    required this.senderName,
  });

  @override
  List<Object?> get props => [teamId, content, senderName];
}
