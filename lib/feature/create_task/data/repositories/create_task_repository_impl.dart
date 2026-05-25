import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/create_task/data/datasources/create_task_remote_data_source.dart';
import 'package:bridge_x/feature/create_task/data/models/create_task_request_model.dart';
import 'package:bridge_x/feature/create_task/domain/entities/create_task_entity.dart';
import 'package:bridge_x/feature/create_task/domain/repositories/create_task_repository.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CreateTaskRepositoryImpl implements CreateTaskRepository {
  final CreateTaskRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CreateTaskRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

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
  Future<Either<Failure, List<TeamMemberEntity>>> getTeamMembers(int projectId) async {
    return _safeCall(() async {
      final response = await remoteDataSource.getTeamMembers(projectId);
      return response.members.map((m) => m.toEntity()).toList();
    });
  }
}
