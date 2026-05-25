import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetProjectDetailsParams extends Equatable {
  final int projectId;
  final String status;

  const GetProjectDetailsParams({
    required this.projectId,
    required this.status,
  });

  @override
  List<Object?> get props => [projectId, status];
}

class GetProjectDetailsUseCase
    implements UseCase<ProjectDetailsEntity, GetProjectDetailsParams> {
  final ProjectsManagementRepository repository;

  GetProjectDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectDetailsEntity>> call(
    GetProjectDetailsParams params,
  ) {
    return repository.getProjectDetails(
      projectId: params.projectId,
      status: params.status,
    );
  }
}
