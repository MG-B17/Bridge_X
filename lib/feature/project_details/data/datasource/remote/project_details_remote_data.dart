import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/project_details/data/models/project_details_response_model.dart';
import 'package:dio/dio.dart';

abstract class ProjectDetailsRemoteData {
  Future<ProjectDetailsResponseModel> getProjectDetails({
    required int projectId,
    required String status,
  });
}

class ProjectDetailsRemoteDataImpl implements ProjectDetailsRemoteData {
  final ApiClient apiClient;

  ProjectDetailsRemoteDataImpl({required this.apiClient});

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
}
