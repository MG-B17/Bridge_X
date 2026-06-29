import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/active_tasks_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/completed_tasks_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/task_details_response_model.dart';
import 'package:dio/dio.dart';

abstract class MyTasksRemoteDataSource {
  Future<ActiveTasksResponseModel> getActiveTasks();

  Future<CompletedTasksResponseModel> getCompletedTasks();

  Future<TaskDetailsResponseModel> getTaskDetails({required int taskId});
}

class MyTasksRemoteDataSourceImpl implements MyTasksRemoteDataSource {
  final ApiClient apiClient;

  MyTasksRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ActiveTasksResponseModel> getActiveTasks() async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.tasksInProgress,
      );
      if (response.data != null) {
        return ActiveTasksResponseModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CompletedTasksResponseModel> getCompletedTasks() async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.tasksCompleted,
      );
      if (response.data != null) {
        return CompletedTasksResponseModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskDetailsResponseModel> getTaskDetails({
    required int taskId,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.taskDetails(taskId: taskId),
      );
      if (response.data != null) {
        return TaskDetailsResponseModel.fromJson(
            response.data as Map<String, dynamic>);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
