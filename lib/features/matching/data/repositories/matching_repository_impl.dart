import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/features/matching/data/datasources/matching_remote_data_source.dart';
import 'package:bridge_x/features/matching/domain/entities/ai_match_entity.dart';
import 'package:bridge_x/features/matching/domain/repositories/matching_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MatchingRepositoryImpl implements MatchingRepository {
  final MatchingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MatchingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AiMatchEntity>> getAiMatches() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
    try {
      final response = await remoteDataSource.getAiMatches();
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
