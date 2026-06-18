import 'package:bridge_x/feature/invitaions/domain/entities/leader_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/project_info_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/team_member_entity.dart';
import 'package:equatable/equatable.dart';

class TeamDetailsEntity extends Equatable {
  final String name;
  final int membersCount;
  final ProjectInfoEntity project;
  final LeaderEntity leader;
  final List<TeamMemberEntity> members;

  const TeamDetailsEntity({
    required this.name,
    required this.membersCount,
    required this.project,
    required this.leader,
    this.members = const [],
  });

  @override
  List<Object?> get props => [name, membersCount, project, leader, members];
}
