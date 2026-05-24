import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/projects/data/data_source/local/all_projects_local_data.dart';
import 'package:bridge_x/feature/projects/data/data_source/remote/all_projects_remote_data.dart';
import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects/domain/repo/all_projects_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AllProjectsRepoImplement implements AllProjectsRepo {
  final AllProjectsRemoteData remoteDataSource;
  final AllProjectsLocalData localDataSource;
  final NetworkInfo networkInfo;

  AllProjectsRepoImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AllProjectsEntity>> getAllProjects({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Attempting to fetch all projects', tag: 'AllProjectsRepo');
        final response = await remoteDataSource.getAllProjects(page: page);
        final entity = response.toEntity();

        if (page == 1) {
          await localDataSource.cacheProjects(response);
        }

        LoggerService.info('All projects fetched successfully', tag: 'AllProjectsRepo');
        return Right(entity);
      } on ServerException catch (e) {
        LoggerService.error(
          'Server exception during fetching projects',
          exception: e,
          tag: 'AllProjectsRepo',
        );
        return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
      } on DioException catch (error) {
        LoggerService.error(
          'DioException during fetching projects',
          exception: error,
          tag: 'AllProjectsRepo',
        );
        return Left(ErrorHandler.handle(error));
      } catch (e) {
        LoggerService.error(
          'Unexpected exception during fetching projects',
          exception: Exception(e.toString()),
          tag: 'AllProjectsRepo',
        );
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      LoggerService.warning('No internet connection during fetching projects', tag: 'AllProjectsRepo');
      return _getCachedProjects();
    }
  }

  @override
  Future<Either<Failure, AllProjectsEntity>> getCachedProjects() async {
    return _getCachedProjects();
  }

  Future<Either<Failure, AllProjectsEntity>> _getCachedProjects() async {
    try {
      final cached = await localDataSource.getCachedProjects();
      LoggerService.info('Cached projects loaded successfully', tag: 'AllProjectsRepo');
      return Right(cached.toEntity());
    } on CacheException catch (e) {
      LoggerService.error(
        'Cache exception during loading cached projects',
        exception: e,
        tag: 'AllProjectsRepo',
      );
      return Left(CacheFailure(message: e.message ?? ErrorStrings.checkYouInternetConnection));
    } catch (e) {
      LoggerService.error(
        'Unexpected exception during loading cached projects',
        exception: Exception(e.toString()),
        tag: 'AllProjectsRepo',
      );
      return Left(CacheFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }
}
