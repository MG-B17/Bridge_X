import 'package:bridge_x/features/invitaions/domain/entities/join_request_programmer_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_project_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_team_entity.dart';
import 'package:equatable/equatable.dart';

class JoinRequestDetailsEntity extends Equatable {
  final int joinRequestId;
  final String status;
  final String createdAt;
  final String? respondedAt;
  final JoinRequestProgrammerEntity programmer;
  final JoinRequestProjectEntity project;
  final JoinRequestTeamEntity team;

  const JoinRequestDetailsEntity({
    required this.joinRequestId,
    required this.status,
    required this.createdAt,
    this.respondedAt,
    required this.programmer,
    required this.project,
    required this.team,
  });

  @override
  List<Object?> get props => [
        joinRequestId,
        status,
        createdAt,
        respondedAt,
        programmer,
        project,
        team,
      ];
}
