import 'package:bridge_x/feature/invitaions/domain/entities/project_entity.dart';

class ProjectResponseModel {
  final String title;
  final String category;
  final String description;
  final String? githubUrl;

  const ProjectResponseModel({
    required this.title,
    required this.category,
    required this.description,
    this.githubUrl,
  });

  factory ProjectResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return ProjectResponseModel(
      title: data['title'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      githubUrl: data['github_url'] as String?,
    );
  }

  ProjectEntity toEntity() => ProjectEntity(
        title: title,
        category: category,
        description: description,
        githubUrl: githubUrl,
      );
}
