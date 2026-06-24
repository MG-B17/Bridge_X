import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/team_managment/create_team/data/remote_data/create_team_remote_data.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/programmer_search_entity.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/repo/create_team_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:bridge_x/features/team_managment/create_team/data/models/create_team_request_model.dart';
import '../../domain/entity/create_team_params.dart';

class CreateTeamRepoImplement implements CreateTeamRepo {
  final CreateTeamRemoteData remoteDataSource;
  final NetworkInfo networkInfo;

  CreateTeamRepoImplement({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _safeRemoteCall<T>(
    Future<T> Function() call,
  ) async {
    if (!await networkInfo.isConnected) {
      LoggerService.warning(
        'No internet connection during create team request',
        tag: 'CreateTeamRepo',
      );
      return Left(
        NetworkFailure(message: ErrorStrings.checkYouInternetConnection),
      );
    }

    try {
      return Right(await call());
    } on ServerException catch (e) {
      LoggerService.error(
        'Server exception during create team request',
        exception: e,
        tag: 'CreateTeamRepo',
      );
      return Left(
        ServerFailure(message: e.message ?? ErrorStrings.serverError),
      );
    } on DioException catch (error) {
      LoggerService.error(
        'DioException during create team request',
        exception: error,
        tag: 'CreateTeamRepo',
      );
      return Left(ErrorHandler.handle(error));
    } catch (e) {
      LoggerService.error(
        'Unexpected exception during create team request',
        exception: Exception(e.toString()),
        tag: 'CreateTeamRepo',
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateTeamEntity>> createTeam({
    required CreateTeamParams request,
  }) async {
    return _safeRemoteCall(() async {
      LoggerService.debug(
        'Attempting to create team: ${request.name}',
        tag: 'CreateTeamRepo',
      );
      final requestModel = CreateTeamRequestModel(
        name: request.name,
        description: request.description,
        isPublic: request.isPublic,
        githubUrl: request.githubUrl,
        categories: request.categories,
        requiredTracks: request.requiredTracks,
        invitations: request.invitations,
      );
      final response = await remoteDataSource.createTeam(request: requestModel);
      LoggerService.info(
        'Team created successfully: ${request.name}',
        tag: 'CreateTeamRepo',
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, List<ProgrammerSearchEntity>>> searchProgrammers(
    String query,
  ) {
    return _safeRemoteCall(() async {
      final response = await remoteDataSource.searchProgrammers(query);
      return response.map((programmer) => programmer.toEntity()).toList();
    });
  }
}
