import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/create_team/data/models/create_team_request_model.dart';
import 'package:bridge_x/feature/create_team/data/models/create_team_response_model.dart';
import 'package:dio/dio.dart';

abstract class CreateTeamRemoteData {
  Future<CreateTeamResponseModel> createTeam({required CreateTeamRequestModel request});
}

class CreateTeamRemoteDataImpl implements CreateTeamRemoteData {
  final ApiClient apiClient;

  CreateTeamRemoteDataImpl({required this.apiClient});

  @override
  Future<CreateTeamResponseModel> createTeam({required CreateTeamRequestModel request}) async {
    try {
      final response = await apiClient.post(path: ApiEndpoint.createTeam, data: request.toJson());
      if (response.data != null) {
        return CreateTeamResponseModel.fromJson(response.data);
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
