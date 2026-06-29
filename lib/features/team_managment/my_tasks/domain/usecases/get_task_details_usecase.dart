import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_details_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/repositories/my_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTaskDetailsUseCase
    implements UseCase<TaskDetailsEntity, GetTaskDetailsParams> {
  final MyTasksRepository repository;

  GetTaskDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, TaskDetailsEntity>> call(
      GetTaskDetailsParams params) async {
    return await repository.getTaskDetails(taskId: params.taskId);
  }
}

class GetTaskDetailsParams extends Equatable {
  final int taskId;

  const GetTaskDetailsParams({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
