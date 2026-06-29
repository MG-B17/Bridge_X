import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/repository/repository_mixin.dart';
import 'package:bridge_x/features/team_managment/task_management/data/datasources/task_remote_data_source.dart';
import 'package:bridge_x/features/team_managment/task_management/data/models/create_task_request_model.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/create_task_entity.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class TaskRepositoryImpl with RepositoryMixin implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  @override
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CreateTaskEntity>> createTask({
    required int teamId,
    required String title,
    required String description,
    required int programmerId,
    required String deadline,
    required String priority,
    String? gitLink,
    required List<String> tags,
  }) async {
    return safeCall(() async {
      final response = await remoteDataSource.createTask(
        teamId: teamId,
        request: CreateTaskRequestModel(
          title: title,
          description: description,
          programmerId: programmerId,
          deadline: deadline,
          priority: priority,
          gitLink: gitLink,
          tags: tags,
        ),
      );
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, ViewTaskEntity>> getTasks({
    required int projectId,
  }) async {
    return safeCall(() async {
      final response = await remoteDataSource.getTasks(projectId: projectId);
      return response.toEntity();
    });
  }
}
