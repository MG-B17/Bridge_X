import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/view_task/data/datasources/view_task_remote_data_source.dart';
import 'package:bridge_x/feature/view_task/domain/entities/view_task_entity.dart';
import 'package:bridge_x/feature/view_task/domain/repositories/view_task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ViewTaskRepositoryImpl implements ViewTaskRepository {
  final ViewTaskRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ViewTaskRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ViewTaskEntity>> getTasks({required int projectId, required String tasksView}) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
    try {
      final response = await remoteDataSource.getTasks(projectId: projectId, tasksView: tasksView);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
