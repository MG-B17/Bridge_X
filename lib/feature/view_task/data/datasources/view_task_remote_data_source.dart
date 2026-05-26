import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/view_task/data/models/view_task_response_model.dart';
import 'package:dio/dio.dart';

abstract class ViewTaskRemoteDataSource {
  Future<ViewTaskResponseModel> getTasks({required int projectId, required String tasksView});
}

class ViewTaskRemoteDataSourceImpl implements ViewTaskRemoteDataSource {
  final ApiClient apiClient;

  ViewTaskRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ViewTaskResponseModel> getTasks({required int projectId, required String tasksView}) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.viewTask(projectId: projectId),
        queryParameters: {'tasks_view': tasksView},
      );
      if (response.data != null) {
        return ViewTaskResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }
}
