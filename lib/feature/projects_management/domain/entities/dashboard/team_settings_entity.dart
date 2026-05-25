import 'package:equatable/equatable.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';

class TeamSettingsEntity extends Equatable {
  final String teamName;
  final String githubLink;
  final String projectDescription;
  final List<TeamMemberEntity> members;

  const TeamSettingsEntity({
    required this.teamName,
    required this.githubLink,
    required this.projectDescription,
    required this.members,
  });

  @override
  List<Object?> get props => [teamName, githubLink, projectDescription, members];
}
