import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCompletedProjectDetailsParams extends Equatable {
  final int projectId;

  const GetCompletedProjectDetailsParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class GetCompletedProjectDetailsUseCase
    implements UseCase<CompletedProjectDetailsEntity, GetCompletedProjectDetailsParams> {
  final ProjectsManagementRepository repository;

  GetCompletedProjectDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, CompletedProjectDetailsEntity>> call(
    GetCompletedProjectDetailsParams params,
  ) {
    return repository.getCompletedProjectDetails(projectId: params.projectId);
  }
}
