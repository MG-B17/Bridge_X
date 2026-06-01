import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/team_evaluation/data/models/evaluate_all_response_model.dart';
import 'package:bridge_x/feature/team_evaluation/data/models/team_basic_details_response_model.dart';
import 'package:dio/dio.dart';

abstract class TeamEvaluationRemoteDataSource {
  Future<TeamBasicDetailsResponseModel> getTeamBasicDetails(int teamId);
  Future<EvaluateAllResponseModel> submitEvaluations(
    int teamId,
    List<Map<String, dynamic>> evaluations,
  );
}

class TeamEvaluationRemoteDataSourceImpl
    implements TeamEvaluationRemoteDataSource {
  final ApiClient apiClient;

  TeamEvaluationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TeamBasicDetailsResponseModel> getTeamBasicDetails(int teamId) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.teamBasicDetails(teamId: teamId),
      );
      if (response.data != null) {
        return TeamBasicDetailsResponseModel.fromJson(response.data);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<EvaluateAllResponseModel> submitEvaluations(
    int teamId,
    List<Map<String, dynamic>> evaluations,
  ) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.evaluateAll(teamId: teamId),
        data: {'evaluations': evaluations},
      );
      if (response.data != null) {
        return EvaluateAllResponseModel.fromJson(response.data);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }
}
