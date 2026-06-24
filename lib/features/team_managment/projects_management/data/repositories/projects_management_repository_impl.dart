import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/datasources/remote/project_managment_base_class.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/change_leader_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/delete_team_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/send_join_request_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/paginated_projects_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProjectsManagementRepositoryImpl implements ProjectsManagementRepository {
  final ProjectsManagementRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProjectsManagementRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _safeRemoteCall<T>(
    Future<T> Function() call,
  ) async {
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
  Future<Either<Failure, PaginatedProjectsEntity>> getProjects({
    int page = 1,
    String? status,
  }) async {
    return _safeRemoteCall(
      () async {
        final response = await remoteDataSource.getProjects(
          page: page,
          status: status,
        );
        return response.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ProjectDashboardEntity>> getProjectDashboard(int projectId) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.getProjectDashboard(projectId)).toEntity(),
    );
  }

  @override
  Future<Either<Failure, TeamSettingsEntity>> getTeamSettings(int projectId) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.getTeamSettings(projectId)).toEntity(),
    );
  }

  @override
  Future<Either<Failure, SubmitProjectEntity>> submitProjectAsComplete(int projectId) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.submitProjectAsComplete(projectId)).toEntity(),
    );
  }

  @override
  Future<Either<Failure, ProjectDetailsEntity>> getProjectDetails({
    required int projectId,
    required String status,
  }) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.getProjectDetails(
        projectId: projectId,
        status: status,
      )).toEntity(),
    );
  }

  @override
  Future<Either<Failure, CompletedProjectDetailsEntity>> getCompletedProjectDetails({
    required int projectId,
  }) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.getCompletedProjectDetails(
        projectId: projectId,
      )).toEntity(),
    );
  }

  @override
  Future<Either<Failure, ChangeLeaderEntity>> changeLeader({
    required int projectId,
    required int userId,
  }) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.changeLeader(
        projectId: projectId,
        userId: userId,
      )).toEntity(),
    );
  }

  @override
  Future<Either<Failure, DeleteTeamEntity>> deleteTeam(int projectId) async {
    return _safeRemoteCall(
      () async => (await remoteDataSource.deleteTeam(projectId)).toEntity(),
    );
  }

  @override
  Future<Either<Failure, SendJoinRequestEntity>> sendJoinRequest({
    required int teamId,
  }) async {
    return _safeRemoteCall(
      () async =>
          (await remoteDataSource.sendJoinRequest(teamId: teamId))
              .toEntity(),
    );
  }
}
