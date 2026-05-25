import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/create_task/data/models/create_task_request_model.dart';
import 'package:bridge_x/feature/create_task/data/models/create_task_response_model.dart';
import 'package:bridge_x/feature/projects_management/data/models/dashboard/team_settings_model.dart';
import 'package:dio/dio.dart';

abstract class CreateTaskRemoteDataSource {
  Future<CreateTaskResponseModel> createTask({
    required int projectId,
    required CreateTaskRequestModel request,
  });

  Future<TeamSettingsModel> getTeamMembers(int projectId);
}

class CreateTaskRemoteDataSourceImpl implements CreateTaskRemoteDataSource {
  final ApiClient apiClient;

  CreateTaskRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CreateTaskResponseModel> createTask({
    required int projectId,
    required CreateTaskRequestModel request,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.createTask(projectId: projectId),
        data: request.toJson(),
      );
      if (response.data != null) {
        return CreateTaskResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<TeamSettingsModel> getTeamMembers(int projectId) async {
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
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }
}
