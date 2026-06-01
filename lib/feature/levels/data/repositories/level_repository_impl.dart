import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/levels/data/datasource/level_remote_data_source.dart';
import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';
import 'package:bridge_x/feature/levels/domain/repositories/level_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LevelRepositoryImpl implements LevelRepository {
  final LevelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LevelRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, LevelEntity>> getLevel() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getLevel();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server error'));
      } on DioException catch (e) {
        return Left(ErrorHandler.handle(e));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
