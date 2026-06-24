import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/datasources/remote/project_managment_base_class.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/project_dashboard_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/send_join_request_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/submit_project_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/change_leader_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/delete_team_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/team_settings_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/details/completed_project_details_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/details/project_details_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/paginated_projects_response_model.dart';
import 'package:dio/dio.dart';

class ProjectsManagementRemoteDataSourceImpl
    implements ProjectsManagementRemoteDataSource {
  final ApiClient apiClient;

  ProjectsManagementRemoteDataSourceImpl({required this.apiClient});

  Never _rethrowOrServerException(Object e) {
    if (e is DioException) throw e;
    throw ServerException(ErrorStrings.serverError);
  }

  @override
  Future<PaginatedProjectsResponseModel> getProjects({
    int page = 1,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page};
      if (status != null) queryParams['status'] = status;

      final response = await apiClient.get(
        path: ApiEndpoint.allProject,
        queryParameters: queryParams,
      );
      if (response.data != null) {
        return PaginatedProjectsResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
        _rethrowOrServerException(e);
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
      _rethrowOrServerException(e);
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
      _rethrowOrServerException(e);
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
      _rethrowOrServerException(e);
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
      _rethrowOrServerException(e);
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
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<ChangeLeaderResponseModel> changeLeader({
    required int projectId,
    required int userId,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.changeLeader(projectId: projectId, userId: userId),
        data: {},
      );
      if (response.data != null) {
        return ChangeLeaderResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<DeleteTeamResponseModel> deleteTeam(int projectId) async {
    try {
      final response = await apiClient.delete(
        path: ApiEndpoint.deleteTeam(projectId: projectId),
      );
      if (response.data != null) {
        return DeleteTeamResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<SendJoinRequestResponseModel> sendJoinRequest({
    required int teamId,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.sendJoinRequest(projectId: teamId),
        data: {},
      );
      if (response.data != null) {
        return SendJoinRequestResponseModel.fromJson(response.data);
      }
      throw ServerException(ErrorStrings.serverError);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }
}
