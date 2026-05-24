import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/projects/data/models/all_projects_response_model.dart';
import 'package:dio/dio.dart';

abstract class AllProjectsRemoteData {
  Future<AllProjectsResponseModel> getAllProjects({int page = 1});
}

class AllProjectsRemoteDataImpl implements AllProjectsRemoteData {
  final ApiClient apiClient;

  AllProjectsRemoteDataImpl({required this.apiClient});

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
}
