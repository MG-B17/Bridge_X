import 'package:equatable/equatable.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_member_entity.dart';

class ProjectDashboardEntity extends Equatable {
  final int projectId;
  final String projectTitle;
  final String description;
  final int totalMembers;
  final int pendingTasks;
  final List<ProjectMemberEntity> members;
  final bool isUserMentor;
  final String projectStatus;

  const ProjectDashboardEntity({
    required this.projectId,
    required this.projectTitle,
    required this.description,
    required this.totalMembers,
    required this.pendingTasks,
    required this.members,
    this.isUserMentor = false,
    this.projectStatus = 'Ongoing',
  });

  @override
  List<Object?> get props => [
    projectId,
    projectTitle,
    description,
    totalMembers,
    pendingTasks,
    members,
    isUserMentor,
    projectStatus,
  ];
}
