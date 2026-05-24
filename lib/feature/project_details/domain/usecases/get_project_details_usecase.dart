import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:bridge_x/feature/project_details/domain/repositories/project_details_repository.dart';
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

class GetProjectDetailsUseCase implements UseCase<ProjectDetailsEntity, GetProjectDetailsParams> {
  final ProjectDetailsRepository repository;

  GetProjectDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectDetailsEntity>> call(GetProjectDetailsParams params) {
    return repository.getProjectDetails(
      projectId: params.projectId,
      status: params.status,
    );
  }
}
