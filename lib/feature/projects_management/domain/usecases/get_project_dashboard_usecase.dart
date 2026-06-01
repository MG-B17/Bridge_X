import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetProjectDashboardParams extends Equatable {
  final int projectId;

  const GetProjectDashboardParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class GetProjectDashboardUseCase
    implements UseCase<ProjectDashboardEntity, GetProjectDashboardParams> {
  final ProjectsManagementRepository repository;

  GetProjectDashboardUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectDashboardEntity>> call(
    GetProjectDashboardParams params,
  ) {
    return repository.getProjectDashboard(params.projectId);
  }
}
