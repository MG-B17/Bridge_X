import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/repository/repository_mixin.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/datasources/my_tasks_remote_data_source.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_details_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/repositories/my_tasks_repository.dart';
import 'package:dartz/dartz.dart';

class MyTasksRepositoryImpl with RepositoryMixin implements MyTasksRepository {
  final MyTasksRemoteDataSource remoteDataSource;

  @override
  final NetworkInfo networkInfo;

  MyTasksRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ActiveTasksEntity>> getActiveTasks() async {
    return safeCall(() async {
      final response = await remoteDataSource.getActiveTasks();
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, CompletedTasksEntity>> getCompletedTasks() async {
    return safeCall(() async {
      final response = await remoteDataSource.getCompletedTasks();
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, TaskDetailsEntity>> getTaskDetails({
    required int taskId,
  }) async {
    return safeCall(() async {
      final response = await remoteDataSource.getTaskDetails(taskId: taskId);
      return response.toEntity();
    });
  }
}
