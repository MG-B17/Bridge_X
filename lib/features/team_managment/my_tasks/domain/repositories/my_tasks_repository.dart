import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MyTasksRepository {
  Future<Either<Failure, ActiveTasksEntity>> getActiveTasks();

  Future<Either<Failure, CompletedTasksEntity>> getCompletedTasks();

  Future<Either<Failure, TaskDetailsEntity>> getTaskDetails({
    required int taskId,
  });
}
