import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/task_management/domain/entities/create_task_entity.dart';
import 'package:bridge_x/feature/task_management/domain/entities/view_task_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TaskRepository {
  Future<Either<Failure, CreateTaskEntity>> createTask({
    required int projectId,
    required String title,
    required String description,
    required int programmerId,
    required String deadline,
    required int priority,
    String? gitLink,
    required List<String> tags,
  });

  Future<Either<Failure, ViewTaskEntity>> getTasks({
    required int projectId,
    required String tasksView,
  });
}
