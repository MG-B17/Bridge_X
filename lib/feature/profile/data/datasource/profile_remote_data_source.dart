import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/profile/data/models/edit_profile_response_model.dart';
import 'package:bridge_x/feature/profile/data/models/profile_dashboard_response_model.dart';
import 'package:bridge_x/feature/profile/data/models/update_profile_request_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDashboardResponseModel> getProfileDashboard();
  Future<DisplayProfileResponseModel> displayProfile();
  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel request);
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

  @override
  Future<DisplayProfileResponseModel> displayProfile() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.displayProfile);
      if (response.data != null) {
        return DisplayProfileResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel request) async {
    try {
      final formData = await request.toFormData();
      final response = await apiClient.post(path: ApiEndpoint.updateProfile, data: formData);
      if (response.data != null) {
        return UpdateProfileResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
