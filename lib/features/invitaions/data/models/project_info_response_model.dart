import 'package:bridge_x/features/invitaions/domain/entities/project_info_entity.dart';

class ProjectInfoResponseModel {
  final String title;
  final String category;
  final String description;

  const ProjectInfoResponseModel({
    required this.title,
    required this.category,
    required this.description,
  });

  factory ProjectInfoResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return ProjectInfoResponseModel(
      title: data['title'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
    );
  }

  ProjectInfoEntity toEntity() => ProjectInfoEntity(
        title: title,
        category: category,
        description: description,
      );
}
