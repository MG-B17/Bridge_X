import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/entities/team_basic_details_entity.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/repositories/team_evaluation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTeamMembersUseCase
    implements UseCase<TeamBasicDetailsEntity, GetTeamMembersParams> {
  final TeamEvaluationRepository repository;

  GetTeamMembersUseCase({required this.repository});

  @override
  Future<Either<Failure, TeamBasicDetailsEntity>> call(
    GetTeamMembersParams params,
  ) async {
    return await repository.getTeamBasicDetails(params.projectId);
  }
}

class GetTeamMembersParams extends Equatable {
  final int projectId;

  const GetTeamMembersParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}
