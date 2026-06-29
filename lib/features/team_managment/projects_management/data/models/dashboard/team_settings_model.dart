import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/team_member_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_settings_entity.dart';

class TeamSettingsModel {
  final int? projectId;
  final String? projectName;
  final int? teamId;
  final String teamName;
  final String githubLink;
  final String projectDescription;
  final List<TeamMemberModel> members;

  const TeamSettingsModel({
    this.projectId,
    this.projectName,
    this.teamId,
    required this.teamName,
    required this.githubLink,
    required this.projectDescription,
    required this.members,
  });

  factory TeamSettingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    final membersList = data['members'] as List? ?? [];
    final members = membersList
        .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return TeamSettingsModel(
      projectId: data['project_id'] as int?,
      projectName: data['project_name'] as String?,
      teamId: data['team_id'] as int?,
      teamName: data['team_name'] as String? ?? '',
      githubLink: data['github_link'] as String? ?? '',
      projectDescription: data['project_description'] as String? ?? '',
      members: members,
    );
  }

  TeamSettingsEntity toEntity() => TeamSettingsEntity(
    projectId: projectId,
    projectName: projectName,
    teamId: teamId,
    teamName: teamName,
    githubLink: githubLink,
    projectDescription: projectDescription,
    members: members.map((m) => m.toEntity()).toList(),
  );
}
