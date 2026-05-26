import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/profile/data/models/profile_dashboard_response_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDashboardResponseModel> getProfileDashboard();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ProfileDashboardResponseModel> getProfileDashboard() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.profileData);
      if (response.data != null) {
        return ProfileDashboardResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
