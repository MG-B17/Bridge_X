import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/project_member_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';

class ProjectDashboardResponseModel {
  final int projectId;
  final String projectTitle;
  final String description;
  final int totalMembers;
  final int pendingTasks;
  final List<ProjectMemberModel> members;
  final String projectStatus;

  const ProjectDashboardResponseModel({
    required this.projectId,
    required this.projectTitle,
    required this.description,
    required this.totalMembers,
    required this.pendingTasks,
    required this.members,
    this.projectStatus = '',
  });

  factory ProjectDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    final membersList = data['members'] as List? ?? [];
    final members = membersList
        .map((e) => ProjectMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProjectDashboardResponseModel(
      projectId: data['project_id'] as int? ?? 0,
      projectTitle: data['project_title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      totalMembers: data['total_members'] as int? ?? 0,
      pendingTasks: data['pending_tasks'] as int? ?? 0,
      members: members,
    );
  }

  ProjectDashboardEntity toEntity() => ProjectDashboardEntity(
    projectId: projectId,
    projectTitle: projectTitle,
    description: description,
    totalMembers: totalMembers,
    pendingTasks: pendingTasks,
    members: members.map((m) => m.toEntity()).toList(),
    projectStatus: projectStatus,
  );
}
