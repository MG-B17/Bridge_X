import 'package:bridge_x/feature/projects_management/domain/entities/details/team_member_entity.dart';
import 'package:equatable/equatable.dart';

class ProjectDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status;
  final String myTrack;
  final String? githubLink;
  final List<TeamMemberEntity> teamMembers;
  final int teamMembersCount;

  const ProjectDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.myTrack,
    this.githubLink,
    required this.teamMembers,
    required this.teamMembersCount,
  });

  bool get hasGithubLink => githubLink != null && githubLink!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        myTrack,
        githubLink,
        teamMembers,
        teamMembersCount,
      ];
}
