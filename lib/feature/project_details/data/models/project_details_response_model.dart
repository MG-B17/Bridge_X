import 'package:bridge_x/feature/project_details/data/models/team_member_model.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';

class ProjectDetailsResponseModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String myTrack;
  final String? githubLink;
  final List<TeamMemberModel> teamMembers;
  final int teamMembersCount;

  const ProjectDetailsResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.myTrack,
    this.githubLink,
    required this.teamMembers,
    required this.teamMembersCount,
  });

  factory ProjectDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final project = data['project'] as Map<String, dynamic>? ?? data;

    final membersList = project['team_members'] as List? ?? [];
    final teamMembers = membersList
        .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProjectDetailsResponseModel(
      id: project['id'] as int? ?? 0,
      title: project['title'] as String? ?? '',
      description: project['description'] as String? ?? '',
      status: project['status'] as String? ?? '',
      myTrack: project['my_track'] as String? ?? '',
      githubLink: project['github_link'] as String?,
      teamMembers: teamMembers,
      teamMembersCount: project['team_members_count'] as int? ?? teamMembers.length,
    );
  }

  ProjectDetailsEntity toEntity() => ProjectDetailsEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        myTrack: myTrack,
        githubLink: githubLink,
        teamMembers: teamMembers.map((m) => m.toEntity()).toList(),
        teamMembersCount: teamMembersCount,
      );
}
