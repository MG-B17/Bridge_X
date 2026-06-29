import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:equatable/equatable.dart';

class ProjectTeamEntity extends Equatable {
  final int teamId;
  final String teamName;
  final int teamSize;
  final List<TeamMemberEntity> members;
  final String? githubUrl;
  final int tasksCount;
  final int completedTasksCount;

  const ProjectTeamEntity({
    required this.teamId,
    required this.teamName,
    required this.teamSize,
    required this.members,
    this.githubUrl,
    this.tasksCount = 0,
    this.completedTasksCount = 0,
  });

  @override
  List<Object?> get props => [
        teamId,
        teamName,
        teamSize,
        members,
        githubUrl,
        tasksCount,
        completedTasksCount,
      ];
}
