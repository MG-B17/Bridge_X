import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTeamSettingsParams extends Equatable {
  final int projectId;

  const GetTeamSettingsParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class GetTeamSettingsUseCase
    implements UseCase<TeamSettingsEntity, GetTeamSettingsParams> {
  final ProjectsManagementRepository repository;

  GetTeamSettingsUseCase({required this.repository});

  @override
  Future<Either<Failure, TeamSettingsEntity>> call(
    GetTeamSettingsParams params,
  ) {
    return repository.getTeamSettings(params.projectId);
  }
}
