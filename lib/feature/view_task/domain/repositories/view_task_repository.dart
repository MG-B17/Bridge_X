import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/view_task/domain/entities/view_task_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ViewTaskRepository {
  Future<Either<Failure, ViewTaskEntity>> getTasks({
    required int projectId,
    required String tasksView,
  });
}
