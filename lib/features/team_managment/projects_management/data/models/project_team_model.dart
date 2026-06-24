import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/team_member_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/project_team_entity.dart';

class ProjectTeamModel {
  final int teamId;
  final String teamName;
  final int teamSize;
  final List<TeamMemberModel> members;
  final String? githubUrl;
  final int tasksCount;
  final int completedTasksCount;

  const ProjectTeamModel({
    required this.teamId,
    required this.teamName,
    required this.teamSize,
    required this.members,
    this.githubUrl,
    this.tasksCount = 0,
    this.completedTasksCount = 0,
  });

  factory ProjectTeamModel.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List? ?? [];
    final members = membersList
        .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProjectTeamModel(
      teamId: json['team_id'] as int? ?? 0,
      teamName: json['team_name'] as String? ?? '',
      teamSize: json['team_size'] as int? ?? 0,
      members: members,
      githubUrl: json['github_url'] as String?,
      tasksCount: json['tasks_count'] as int? ?? 0,
      completedTasksCount: json['completed_tasks_count'] as int? ?? 0,
    );
  }

  ProjectTeamEntity toEntity() => ProjectTeamEntity(
        teamId: teamId,
        teamName: teamName,
        teamSize: teamSize,
        members: members.map((m) => m.toEntity()).toList(),
        githubUrl: githubUrl,
        tasksCount: tasksCount,
        completedTasksCount: completedTasksCount,
      );
}
