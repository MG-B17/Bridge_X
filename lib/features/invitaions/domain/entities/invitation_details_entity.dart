import 'package:bridge_x/features/invitaions/domain/entities/invited_by_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/team_details_entity.dart';
import 'package:equatable/equatable.dart';

class InvitationDetailsEntity extends Equatable {
  final int invitationId;
  final String status;
  final InvitedByEntity invitedBy;
  final TeamDetailsEntity team;
  final String expiresAt;
  final String createdAt;

  const InvitationDetailsEntity({
    required this.invitationId,
    required this.status,
    required this.invitedBy,
    required this.team,
    required this.expiresAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        invitationId,
        status,
        invitedBy,
        team,
        expiresAt,
        createdAt,
      ];
}
