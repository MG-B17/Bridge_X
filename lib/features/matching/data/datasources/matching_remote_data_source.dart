import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:dio/dio.dart';
import '../models/ai_match_response_model.dart';

abstract class MatchingRemoteDataSource {
  Future<AiMatchResponseModel> getAiMatches();
}

class MatchingRemoteDataSourceImpl implements MatchingRemoteDataSource {
  final ApiClient apiClient;

  MatchingRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AiMatchResponseModel> getAiMatches() async {
    try {
      final response = await apiClient.post(
        data:{},
        path: ApiEndpoint.aiMatchTeams,
      );
      if (response.data != null) {
        return AiMatchResponseModel.fromJson(response.data);
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }
}
