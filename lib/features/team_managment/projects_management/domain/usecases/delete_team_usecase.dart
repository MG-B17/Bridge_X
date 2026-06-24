import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/delete_team_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteTeamParams extends Equatable {
  final int projectId;

  const DeleteTeamParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class DeleteTeamUseCase
    implements UseCase<DeleteTeamEntity, DeleteTeamParams> {
  final ProjectsManagementRepository repository;

  DeleteTeamUseCase({required this.repository});

  @override
  Future<Either<Failure, DeleteTeamEntity>> call(
    DeleteTeamParams params,
  ) {
    return repository.deleteTeam(params.projectId);
  }
}
