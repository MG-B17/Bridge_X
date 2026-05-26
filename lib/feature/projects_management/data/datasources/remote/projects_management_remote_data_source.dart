import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/projects_management/data/models/all_projects_response_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/dashboard/project_dashboard_response_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/dashboard/submit_project_response_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/dashboard/team_settings_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/details/completed_project_details_response_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/details/project_details_response_model.dart';
import 'package:dio/dio.dart';

abstract class ProjectsManagementRemoteDataSource {
  Future<AllProjectsResponseModel> getAllProjects({int page = 1});

  Future<ProjectDashboardResponseModel> getProjectDashboard(int projectId);

  Future<TeamSettingsModel> getTeamSettings(int projectId);

  Future<SubmitProjectResponseModel> submitProjectAsComplete(int projectId);

  Future<ProjectDetailsResponseModel> getProjectDetails({
    required int projectId,
    required String status,
  });

  Future<CompletedProjectDetailsResponseModel> getCompletedProjectDetails({
    required int projectId,
  });
}

class ProjectsManagementRemoteDataSourceImpl
    implements ProjectsManagementRemoteDataSource {
  final ApiClient apiClient;

  ProjectsManagementRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AllProjectsResponseModel> getAllProjects({int page = 1}) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.allProject,
        queryParameters: page > 1 ? {'page': page} : null,
      );
      if (response.data != null) {
        return AllProjectsResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else if (e is ServerException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<ProjectDashboardResponseModel> getProjectDashboard(
    int projectId,
  ) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.projectDashboard(projectId: projectId),
      );
      if (response.data != null) {
        return ProjectDashboardResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TeamSettingsModel> getTeamSettings(int projectId) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.teamSettings(projectId: projectId),
      );
      if (response.data != null) {
        return TeamSettingsModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubmitProjectResponseModel> submitProjectAsComplete(
    int projectId,
  ) async {
    try {
      final response = await apiClient.patch(
        path: ApiEndpoint.submitprojectAsComplete(projectId: projectId),
      );
      if (response.data != null) {
        return SubmitProjectResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProjectDetailsResponseModel> getProjectDetails({
    required int projectId,
    required String status,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.projectDetails(projectId: projectId),
        queryParameters: {'status': status},
      );
      if (response.data != null) {
        return ProjectDetailsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else if (e is ServerException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<CompletedProjectDetailsResponseModel> getCompletedProjectDetails({
    required int projectId,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.projectDetails(projectId: projectId),
        queryParameters: {'status': 'completed'},
      );
      if (response.data != null) {
        return CompletedProjectDetailsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else if (e is ServerException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }
}
