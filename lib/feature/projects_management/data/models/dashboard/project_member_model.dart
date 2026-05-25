import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_member_entity.dart';

class ProjectMemberModel {
  final String name;
  final String? avatarUrl;
  final String track;
  final String tasksSummary;

  const ProjectMemberModel({
    required this.name,
    required this.avatarUrl,
    required this.track,
    required this.tasksSummary,
  });

  factory ProjectMemberModel.fromJson(Map<String, dynamic> json) {
    return ProjectMemberModel(
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      track: json['track'] as String? ?? '',
      tasksSummary: json['tasks_summary'] as String? ?? '',
    );
  }

  ProjectMemberEntity toEntity() => ProjectMemberEntity(
    name: name,
    avatarUrl: avatarUrl,
    track: track,
    tasksSummary: tasksSummary,
  );
}
