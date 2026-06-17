import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateTeamChatRoomUseCase
    implements UseCase<void, CreateTeamChatRoomParams> {
  final ChatRepository repository;

  CreateTeamChatRoomUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateTeamChatRoomParams params) async {
    return await repository.createChatRoom(
      teamId: params.teamId,
      teamName: params.teamName,
      creatorId: params.creatorId,
      memberIds: params.memberIds,
    );
  }
}

class CreateTeamChatRoomParams extends Equatable {
  final String teamId;
  final String teamName;
  final String creatorId;
  final List<String> memberIds;

  const CreateTeamChatRoomParams({
    required this.teamId,
    required this.teamName,
    required this.creatorId,
    this.memberIds = const [],
  });

  @override
  List<Object?> get props => [teamId, teamName, creatorId, memberIds];
}