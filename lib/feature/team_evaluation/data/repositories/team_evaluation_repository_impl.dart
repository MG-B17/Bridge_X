import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/team_evaluation/data/datasources/team_evaluation_remote_data_source.dart';
import 'package:bridge_x/feature/team_evaluation/domain/entities/team_basic_details_entity.dart';
import 'package:bridge_x/feature/team_evaluation/domain/repositories/team_evaluation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TeamEvaluationRepositoryImpl implements TeamEvaluationRepository {
  final TeamEvaluationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TeamEvaluationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TeamBasicDetailsEntity>> getTeamBasicDetails(
    int teamId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
    try {
      final response = await remoteDataSource.getTeamBasicDetails(teamId);
      return Right(TeamBasicDetailsEntity(
        teamName: response.teamName,
        projectDescription: response.projectDescription,
        members: response.members.map((m) => m.toEntity()).toList(),
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> submitEvaluations(
    int teamId,
    List<Map<String, dynamic>> evaluations,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
    try {
      final response = await remoteDataSource.submitEvaluations(
        teamId,
        evaluations,
      );
      if (response.success) {
        return Right(response.message);
      }
      final errorMsg = response.errors.isNotEmpty
          ? response.errors.join(', ')
          : response.message;
      return Left(ServerFailure(message: errorMsg));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
