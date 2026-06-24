import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/features/invitaions/data/models/accept_invitation_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/invitation_details_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/invitation_response_model.dart';
import 'package:dio/dio.dart';

abstract class InvitaionsRemoteDataSource {
  Future<List<InvitationResponseModel>> getInvitations();

  Future<InvitationDetailsResponseModel> getInvitationDetails({
    required int invitationId,
  });

  Future<AcceptInvitationResponseModel> acceptInvitation({
    required int invitationId,
  });

  Future<void> declineInvitation({required int invitationId});
}

class InvitaionsRemoteDataSourceImpl implements InvitaionsRemoteDataSource {
  final ApiClient apiClient;

  InvitaionsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<InvitationResponseModel>> getInvitations() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.invitations);
      if (response.data == null) {
        throw ServerException('Empty response data received');
      }

      final invitations = _extractInvitations(response.data);
      return invitations
          .whereType<Map>()
          .map(
            (invitation) => InvitationResponseModel.fromJson(
              Map<String, dynamic>.from(invitation),
            ),
          )
          .toList();
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<InvitationDetailsResponseModel> getInvitationDetails({
    required int invitationId,
  }) async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.invitationDetails(invitationId: invitationId),
      );
      if (response.data == null) {
        throw ServerException('Empty response data received');
      }

      return InvitationDetailsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<AcceptInvitationResponseModel> acceptInvitation({
    required int invitationId,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.acceptTeamInvitation(invitationId: invitationId),
        data: {},
      );
      if (response.data == null) {
        throw ServerException('Empty response data received');
      }

      return AcceptInvitationResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<void> declineInvitation({required int invitationId}) async {
    try {
      await apiClient.post(
        path: ApiEndpoint.declineTeamInvitation(invitationId: invitationId),
        data: {},
      );
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  List<dynamic> _extractInvitations(dynamic responseData) {
    if (responseData is List) return responseData;
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is List) return data;
      final invitations = responseData['invitations'];
      if (invitations is List) return invitations;
    }
    return const [];
  }
}
