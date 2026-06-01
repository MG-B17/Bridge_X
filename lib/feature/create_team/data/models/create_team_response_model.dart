import 'package:bridge_x/feature/create_team/data/models/project_model.dart';
import 'package:bridge_x/feature/create_team/data/models/team_model.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';

class CreateTeamResponseModel extends CreateTeamEntity {
  const CreateTeamResponseModel({
    required super.project,
    required super.team,
    required super.invitationsSent,
  });

  factory CreateTeamResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    final projectJson = data['project'] as Map<String, dynamic>? ?? {};
    final teamJson = data['team'] as Map<String, dynamic>? ?? {};
    final invitationsList = data['invitations_sent'] as List? ?? [];
    final invitations = invitationsList.map((e) => e.toString()).toList();

    return CreateTeamResponseModel(
      project: ProjectModel.fromJson(projectJson),
      team: TeamModel.fromJson(teamJson),
      invitationsSent: invitations,
    );
  }
}



