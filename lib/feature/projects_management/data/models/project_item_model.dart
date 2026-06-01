import 'package:bridge_x/feature/projects_management/domain/entities/project_item_entity.dart';

class ProjectItemModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final int estimatedDurationDays;
  final String expectedEndDate;
  final double projectCompletionPercentage;
  final double myCompletionPercentage;
  final String mySpecialization;
  final String? completionDate;

  const ProjectItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.estimatedDurationDays,
    required this.expectedEndDate,
    required this.projectCompletionPercentage,
    required this.myCompletionPercentage,
    required this.mySpecialization,
    this.completionDate,
  });

  factory ProjectItemModel.fromJson(Map<String, dynamic> json) {
    return ProjectItemModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      estimatedDurationDays: json['estimated_duration_days'] as int? ?? 0,
      expectedEndDate: json['expected_end_date'] as String? ?? '',
      projectCompletionPercentage:
          (json['project_completion_percentage'] as num?)?.toDouble() ?? 0.0,
      myCompletionPercentage:
          (json['my_completion_percentage'] as num?)?.toDouble() ?? 0.0,
      mySpecialization: json['my_specialization'] as String? ?? '',
      completionDate: json['completion_date'] as String?,
    );
  }

  ProjectItemEntity toEntity() => ProjectItemEntity(
        id: id,
        title: title,
        description: description,
        category: category,
        estimatedDurationDays: estimatedDurationDays,
        expectedEndDate: expectedEndDate,
        projectCompletionPercentage: projectCompletionPercentage,
        myCompletionPercentage: myCompletionPercentage,
        mySpecialization: mySpecialization,
        completionDate: completionDate,
      );
}
