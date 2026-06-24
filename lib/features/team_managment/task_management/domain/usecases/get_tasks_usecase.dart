import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTasksParams extends Equatable {
  final int projectId;

  const GetTasksParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class GetTasksUseCase implements UseCase<ViewTaskEntity, GetTasksParams> {
  final TaskRepository repository;

  GetTasksUseCase({required this.repository});

  @override
  Future<Either<Failure, ViewTaskEntity>> call(GetTasksParams params) {
    return repository.getTasks(projectId: params.projectId);
  }
}
