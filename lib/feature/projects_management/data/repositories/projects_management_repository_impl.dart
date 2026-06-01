import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/projects_management/data/datasources/local/projects_management_local_data.dart';
import 'package:bridge_x/feature/projects_management/data/datasources/remote/projects_management_remote_data_source.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/paginated_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProjectsManagementRepositoryImpl implements ProjectsManagementRepository {
  final ProjectsManagementRemoteDataSource remoteDataSource;
  final ProjectsManagementLocalData localDataSource;
  final NetworkInfo networkInfo;

  ProjectsManagementRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _safeRemoteCall<T>(
    Future<T> Function() call, {
    Future<Either<Failure, T>> Function()? onOffline,
  }) async {
    if (!await networkInfo.isConnected) {
      return onOffline?.call() ??
          Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
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
  Future<Either<Failure, AllProjectsEntity>> getAllProjects({int page = 1}) async {
    return _safeRemoteCall(
      () async {
        final response = await remoteDataSource.getAllProjects(page: page);
        if (page == 1) await localDataSource.cacheProjects(response);
        return response.toEntity();
      },
      onOffline: _getCachedProjects,
    );
  }

  @override
  Future<Either<Failure, AllProjectsEntity>> getCachedProjects() => _getCachedProjects();

  Future<Either<Failure, AllProjectsEntity>> _getCachedProjects() async {
    try {
      final cached = await localDataSource.getCachedProjects();
      return Right(cached.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? ErrorStrings.checkYouInternetConnection));
    } catch (e) {
      return Left(CacheFailure(message: ErrorStrings.checkYouInternetConnection));
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
}
