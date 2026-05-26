import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/levels/data/models/level_response_model.dart';
import 'package:dio/dio.dart';

abstract class LevelRemoteDataSource {
  Future<LevelResponseModel> getLevel();
}

class LevelRemoteDataSourceImpl implements LevelRemoteDataSource {
  final ApiClient apiClient;

  LevelRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<LevelResponseModel> getLevel() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.level);
      if (response.data != null) {
        return LevelResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
