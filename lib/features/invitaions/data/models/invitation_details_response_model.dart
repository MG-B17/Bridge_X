import 'package:bridge_x/features/invitaions/data/models/invited_by_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/team_details_response_model.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_details_entity.dart';

class InvitationDetailsResponseModel {
  final int invitationId;
  final String status;
  final InvitedByResponseModel invitedBy;
  final TeamDetailsResponseModel team;
  final String expiresAt;
  final String createdAt;

  const InvitationDetailsResponseModel({
    required this.invitationId,
    required this.status,
    required this.invitedBy,
    required this.team,
    required this.expiresAt,
    required this.createdAt,
  });

  factory InvitationDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return InvitationDetailsResponseModel(
      invitationId: data['invitation_id'] as int? ??
          int.tryParse(data['invitation_id']?.toString() ?? '') ??
          0,
      status: data['status'] as String? ?? '',
      invitedBy: InvitedByResponseModel.fromJson(
        data['invited_by'] as Map<String, dynamic>?,
      ),
      team: TeamDetailsResponseModel.fromJson(
        data['team'] as Map<String, dynamic>?,
      ),
      expiresAt: data['expires_at'] as String? ?? '',
      createdAt: data['created_at'] as String? ?? '',
    );
  }

  InvitationDetailsEntity toEntity() => InvitationDetailsEntity(
        invitationId: invitationId,
        status: status,
        invitedBy: invitedBy.toEntity(),
        team: team.toEntity(),
        expiresAt: expiresAt,
        createdAt: createdAt,
      );
}
