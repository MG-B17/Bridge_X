import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateTeamChatRoom implements UseCase<void, CreateTeamChatRoomParams> {
  final ChatRepository repository;

  CreateTeamChatRoom(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateTeamChatRoomParams params) async {
    return await repository.createChatRoom(
      params.teamId,
      params.teamName,
      params.creatorId,
      params.memberIds,
    );
  }
}

class CreateTeamChatRoomParams extends Equatable {
  final int teamId;
  final String teamName;
  final int creatorId;
  final List<int> memberIds;

  const CreateTeamChatRoomParams({
    required this.teamId,
    required this.teamName,
    required this.creatorId,
    this.memberIds = const [],
  });

  @override
  List<Object?> get props => [teamId, teamName, creatorId, memberIds];
}
