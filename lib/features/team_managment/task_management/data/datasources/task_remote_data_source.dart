import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/features/team_managment/task_management/data/models/create_task_request_model.dart';
import 'package:bridge_x/features/team_managment/task_management/data/models/create_task_response_model.dart';
import 'package:bridge_x/features/team_managment/task_management/data/models/view_task_response_model.dart';
import 'package:dio/dio.dart';

abstract class TaskRemoteDataSource {
  Future<CreateTaskResponseModel> createTask({
    required int teamId,
    required CreateTaskRequestModel request,
  });

  Future<ViewTaskResponseModel> getTasks({
    required int projectId,
  });
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final ApiClient apiClient;

  TaskRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CreateTaskResponseModel> createTask({
    required int teamId,
    required CreateTaskRequestModel request,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.createTask(teamId: teamId),
        data: request.toJson(),
      );
      if (response.data != null) {
        return CreateTaskResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ViewTaskResponseModel> getTasks({
    required int projectId,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.viewTask(projectId: projectId),
      );
      if (response.data != null) {
        return ViewTaskResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
