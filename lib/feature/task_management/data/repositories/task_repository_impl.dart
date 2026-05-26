import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/task_management/data/datasources/task_remote_data_source.dart';
import 'package:bridge_x/feature/task_management/data/models/create_task_request_model.dart';
import 'package:bridge_x/feature/task_management/domain/entities/create_task_entity.dart';
import 'package:bridge_x/feature/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/feature/task_management/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  Future<Either<Failure, T>> _safeCall<T>(Future<T> Function() call) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
    try {
      return Right(await call());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateTaskEntity>> createTask({
    required int projectId,
    required String title,
    required String description,
    required int programmerId,
    required String deadline,
    required int priority,
    String? gitLink,
    required List<String> tags,
  }) async {
    return _safeCall(() async {
      final response = await remoteDataSource.createTask(
        projectId: projectId,
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
    required String tasksView,
  }) async {
    return _safeCall(() async {
      final response = await remoteDataSource.getTasks(projectId: projectId, tasksView: tasksView);
      return response.toEntity();
    });
  }
}
