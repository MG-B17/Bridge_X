import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/project_details/data/datasource/remote/project_details_remote_data.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:bridge_x/feature/project_details/domain/repositories/project_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProjectDetailsRepositoryImpl implements ProjectDetailsRepository {
  final ProjectDetailsRemoteData remoteDataSource;
  final NetworkInfo networkInfo;

  ProjectDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProjectDetailsEntity>> getProjectDetails({
    required int projectId,
    required String status,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug(
          'Fetching project details: $projectId status=$status',
          tag: 'ProjectDetailsRepo',
        );
        final response = await remoteDataSource.getProjectDetails(
          projectId: projectId,
          status: status,
        );
        LoggerService.info('Project details fetched successfully', tag: 'ProjectDetailsRepo');
        return Right(response.toEntity());
      } on ServerException catch (e) {
        LoggerService.error(
          'Server exception during project details fetch',
          exception: e,
          tag: 'ProjectDetailsRepo',
        );
        return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
      } on DioException catch (error) {
        LoggerService.error(
          'DioException during project details fetch',
          exception: error,
          tag: 'ProjectDetailsRepo',
        );
        return Left(ErrorHandler.handle(error));
      } catch (e) {
        LoggerService.error(
          'Unexpected exception during project details fetch',
          exception: Exception(e.toString()),
          tag: 'ProjectDetailsRepo',
        );
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      LoggerService.warning(
        'No internet connection during project details fetch',
        tag: 'ProjectDetailsRepo',
      );
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }
}
