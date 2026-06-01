import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SubmitProjectAsCompleteParams extends Equatable {
  final int projectId;

  const SubmitProjectAsCompleteParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class SubmitProjectAsCompleteUseCase
    implements UseCase<SubmitProjectEntity, SubmitProjectAsCompleteParams> {
  final ProjectsManagementRepository repository;

  SubmitProjectAsCompleteUseCase({required this.repository});

  @override
  Future<Either<Failure, SubmitProjectEntity>> call(
    SubmitProjectAsCompleteParams params,
  ) {
    return repository.submitProjectAsComplete(params.projectId);
  }
}
