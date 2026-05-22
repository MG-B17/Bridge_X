import 'package:bridge_x/feature/dashboard/domain/entities/project_detail_entity.dart';

class ProjectDetailModel extends ProjectDetailEntity {
  const ProjectDetailModel({
    required super.projectId,
    required super.projectTitle,
    required super.completionPercentage,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      projectId: json['project_id'] as int? ?? 0,
      projectTitle: json['project_title'] as String? ?? '',
      completionPercentage: (json['completion_percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'project_title': projectTitle,
      'completion_percentage': completionPercentage,
    };
  }
}
