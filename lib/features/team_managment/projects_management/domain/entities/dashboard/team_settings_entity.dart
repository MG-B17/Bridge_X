import 'package:equatable/equatable.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_member_entity.dart';

class TeamSettingsEntity extends Equatable {
  final int? projectId;
  final String? projectName;
  final int? teamId;
  final String teamName;
  final String githubLink;
  final String projectDescription;
  final List<TeamMemberEntity> members;

  const TeamSettingsEntity({
    this.projectId,
    this.projectName,
    this.teamId,
    required this.teamName,
    required this.githubLink,
    required this.projectDescription,
    required this.members,
  });

  @override
  List<Object?> get props => [projectId, projectName, teamId, teamName, githubLink, projectDescription, members];
}
