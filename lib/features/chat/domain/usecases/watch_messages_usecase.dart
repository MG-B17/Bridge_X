import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class WatchMessages implements StreamUseCase<MessageEntity, WatchMessagesParams> {
  final ChatRepository repository;

  WatchMessages(this.repository);

  @override
  Stream<MessageEntity> call(WatchMessagesParams params) {
    return repository.watchMessages(params.teamId);
  }
}

class WatchMessagesParams extends Equatable {
  final String teamId;

  const WatchMessagesParams({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}
