import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class WatchMessages implements StreamUseCase<Either<Failure, MessageEntity>, WatchMessagesParams> {
  final ChatRepository repository;

  WatchMessages(this.repository);

  @override
  Stream<Either<Failure, MessageEntity>> call(WatchMessagesParams params) {
    return repository.watchMessages(params.roomId, params.userId);
  }
}

class WatchMessagesParams extends Equatable {
  final String roomId;
  final int userId;

  const WatchMessagesParams({required this.roomId, required this.userId});

  @override
  List<Object?> get props => [roomId, userId];
}
