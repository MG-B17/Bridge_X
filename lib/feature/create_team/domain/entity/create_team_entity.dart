import 'package:bridge_x/feature/create_team/domain/entity/project_entity.dart';
import 'package:bridge_x/feature/create_team/domain/entity/team_entity.dart';
import 'package:equatable/equatable.dart';

class CreateTeamEntity extends Equatable {
  final ProjectEntity project;
  final TeamEntity team;
  final List<String> invitationsSent;

  const CreateTeamEntity({
    required this.project,
    required this.team,
    required this.invitationsSent,
  });

  @override
  List<Object?> get props => [project, team, invitationsSent];
}
