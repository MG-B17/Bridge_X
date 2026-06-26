import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangeLeader implements UseCase<void, ChangeLeaderParams> {
  final ChatRepository repository;

  ChangeLeader(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangeLeaderParams params) async {
    return await repository.changeChatRoomLeader(params.roomId, params.newLeaderId, params.oldLeaderId);
  }
}

class ChangeLeaderParams extends Equatable {
  final String roomId;
  final int newLeaderId;
  final int oldLeaderId;

  const ChangeLeaderParams({
    required this.roomId,
    required this.newLeaderId,
    required this.oldLeaderId,
  });

  @override
  List<Object?> get props => [roomId, newLeaderId, oldLeaderId];
}
