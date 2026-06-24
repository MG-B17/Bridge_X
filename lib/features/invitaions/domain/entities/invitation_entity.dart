import 'package:bridge_x/features/invitaions/domain/entities/invited_by_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/team_entity.dart';
import 'package:equatable/equatable.dart';

class InvitationEntity extends Equatable {
  final int invitationId;
  final String status;
  final String sentAt;
  final String expiresAt;
  final InvitedByEntity invitedBy;
  final TeamEntity team;

  const InvitationEntity({
    required this.invitationId,
    required this.status,
    required this.sentAt,
    required this.expiresAt,
    required this.invitedBy,
    required this.team,
  });

  @override
  List<Object?> get props => [
        invitationId,
        status,
        sentAt,
        expiresAt,
        invitedBy,
        team,
      ];
}
