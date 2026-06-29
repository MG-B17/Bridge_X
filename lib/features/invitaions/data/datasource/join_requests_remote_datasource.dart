import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/features/invitaions/data/models/accept_join_request_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/join_request_details_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/join_requests_response_model.dart';
import 'package:dio/dio.dart';

abstract class JoinRequestsRemoteDataSource {
  Future<JoinRequestsResponseModel> getMyJoinRequests();

  Future<JoinRequestDetailsResponseModel> getJoinRequestDetails({
    required int joinRequestId,
  });

  Future<AcceptJoinRequestResponseModel> acceptJoinRequest({
    required int joinRequestId,
  });

  Future<void> declineJoinRequest({required int joinRequestId});
}

class JoinRequestsRemoteDataSourceImpl implements JoinRequestsRemoteDataSource {
  final ApiClient apiClient;

  JoinRequestsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<JoinRequestsResponseModel> getMyJoinRequests() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.myJoinRequests);
      if (response.data == null) {
        throw ServerException(ErrorStrings.serverError);
      }
      return JoinRequestsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<JoinRequestDetailsResponseModel> getJoinRequestDetails({
    required int joinRequestId,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.joinRequestDetails(joinRequestId: joinRequestId),
      );
      if (response.data == null) {
        throw ServerException(ErrorStrings.serverError);
      }
      return JoinRequestDetailsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<AcceptJoinRequestResponseModel> acceptJoinRequest({
    required int joinRequestId,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.acceptJoinRequest(joinRequestId: joinRequestId),
        data: {},
      );
      if (response.data == null) {
        throw ServerException(ErrorStrings.serverError);
      }
      return AcceptJoinRequestResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<void> declineJoinRequest({required int joinRequestId}) async {
    try {
      await apiClient.post(
        path: ApiEndpoint.declineJoinRequest(joinRequestId: joinRequestId),
        data: {},
      );
    } on DioException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(ErrorStrings.serverError);
    }
  }
}
