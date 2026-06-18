import 'package:bridge_x/feature/invitaions/data/models/invited_by_response_model.dart';
import 'package:bridge_x/feature/invitaions/data/models/team_response_model.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/invitation_entity.dart';

class InvitationResponseModel {
  final int invitationId;
  final String status;
  final String sentAt;
  final String expiresAt;
  final InvitedByResponseModel invitedBy;
  final TeamResponseModel team;

  const InvitationResponseModel({
    required this.invitationId,
    required this.status,
    required this.sentAt,
    required this.expiresAt,
    required this.invitedBy,
    required this.team,
  });

  factory InvitationResponseModel.fromJson(Map<String, dynamic> json) {
    return InvitationResponseModel(
      invitationId: json['invitation_id'] as int? ??
          int.tryParse(json['invitation_id']?.toString() ?? '') ??
          0,
      status: json['status'] as String? ?? '',
      sentAt: json['sent_at'] as String? ?? '',
      expiresAt: json['expires_at'] as String? ?? '',
      invitedBy: InvitedByResponseModel.fromJson(
        json['invited_by'] as Map<String, dynamic>?,
      ),
      team: TeamResponseModel.fromJson(
        json['team'] as Map<String, dynamic>?,
      ),
    );
  }

  InvitationEntity toEntity() => InvitationEntity(
        invitationId: invitationId,
        status: status,
        sentAt: sentAt,
        expiresAt: expiresAt,
        invitedBy: invitedBy.toEntity(),
        team: team.toEntity(),
      );
}
