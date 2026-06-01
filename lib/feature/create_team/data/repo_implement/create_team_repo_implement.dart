import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/create_team/data/remote_data/create_team_remote_data.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/feature/create_team/domain/repo/create_team_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:bridge_x/feature/create_team/data/models/create_team_request_model.dart';
import '../../domain/entity/create_team_params.dart';

class CreateTeamRepoImplement implements CreateTeamRepo {
  final CreateTeamRemoteData remoteDataSource;
  final NetworkInfo networkInfo;

  CreateTeamRepoImplement({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CreateTeamEntity>> createTeam({
    required CreateTeamParams request,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Attempting to create team: ${request.name}', tag: 'CreateTeamRepo');
        final requestModel = CreateTeamRequestModel(
          name: request.name,
          description: request.description,
          isPublic: request.isPublic,
          githubUrl: request.githubUrl,
          categories: request.categories,
          requiredTracks: request.requiredTracks,
        );
        final response = await remoteDataSource.createTeam(request: requestModel);
        LoggerService.info('Team created successfully: ${request.name}', tag: 'CreateTeamRepo');
        return Right(response);
      } on ServerException catch (e) {
        LoggerService.error(
          'Server exception during team creation',
          exception: e,
          tag: 'CreateTeamRepo',
        );
        return Left(ServerFailure(message: e.message ?? ErrorStrings.serverError));
      } on DioException catch (error) {
        LoggerService.error(
          'DioException during team creation',
          exception: error,
          tag: 'CreateTeamRepo',
        );
        return Left(ErrorHandler.handle(error));
      } catch (e) {
        LoggerService.error(
          'Unexpected exception during team creation',
          exception: Exception(e.toString()),
          tag: 'CreateTeamRepo',
        );
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      LoggerService.warning('No internet connection during team creation', tag: 'CreateTeamRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }
}
