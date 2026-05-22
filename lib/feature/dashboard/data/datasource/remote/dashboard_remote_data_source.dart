import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/dashboard/data/models/dashboard_response_model.dart';
import 'package:dio/dio.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardResponseModel> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<DashboardResponseModel> getDashboard() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.dashboard);
      if (response.data != null) {
        return DashboardResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }
}
