import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/dashboard/data/datasource/local/dashboard_local_data_source.dart';
import 'package:bridge_x/feature/dashboard/data/datasource/remote/dashboard_remote_data_source.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/dashboard_entity.dart';
import 'package:bridge_x/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardEntity>> getRemoteDashboard({bool isRefresh = false}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Fetching remote dashboard data...', tag: 'DashboardRepo');
        final remoteData = await remoteDataSource.getDashboard();

        if (!isRefresh) {
          LoggerService.debug('Caching dashboard data locally...', tag: 'DashboardRepo');
          await localDataSource.cacheDashboard(remoteData);
        } else {
          LoggerService.debug('Skipping local cache update for refresh', tag: 'DashboardRepo');
        }

        return Right(remoteData);
      } on ServerException catch (e) {
        LoggerService.error(
          'Remote fetch failed, trying local cache',
          exception: e,
          tag: 'DashboardRepo',
        );
        return _getLocalFallback(ServerFailure(message: e.message ?? 'Server error'));
      } on DioException catch (e) {
        LoggerService.error(
          'Dio error in remote fetch, trying local cache',
          exception: e,
          tag: 'DashboardRepo',
        );
        return _getLocalFallback(ErrorHandler.handle(e));
      } catch (e) {
        LoggerService.error(
          'Unexpected error, trying local cache',
          exception: e,
          tag: 'DashboardRepo',
        );
        return _getLocalFallback(ServerFailure(message: e.toString()));
      }
    } else {
      LoggerService.warning(
        'No internet connection, falling back to local cache',
        tag: 'DashboardRepo',
      );
      final localResult = await getLocalDashboard();
      return localResult.fold(
        (_) => const Left(NetworkFailure(message: 'No internet connection')),
        (cachedData) => Right(cachedData),
      );
    }
  }

  @override
  Future<Either<Failure, DashboardEntity>> getLocalDashboard() async {
    try {
      LoggerService.debug('Retrieving cached dashboard data...', tag: 'DashboardRepo');
      final localData = await localDataSource.getDashboard();
      return Right(localData);
    } on CacheException catch (e) {
      LoggerService.info('No local cache found: ${e.message}', tag: 'DashboardRepo');
      return Left(CacheFailure(message: e.message ?? 'No cached data found'));
    }
  }

  Future<Either<Failure, DashboardEntity>> _getLocalFallback(Failure originalFailure) async {
    try {
      final localData = await localDataSource.getDashboard();
      LoggerService.info('Successfully fell back to cached dashboard data', tag: 'DashboardRepo');
      return Right(localData);
    } catch (_) {
      return Left(originalFailure);
    }
  }
}
