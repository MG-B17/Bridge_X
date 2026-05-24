import 'package:bridge_x/feature/projects/domain/entities/ongoing_project_entity.dart';

class OngoingProjectModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final int estimatedDurationDays;
  final String expectedEndDate;
  final double projectCompletionPercentage;
  final double myCompletionPercentage;
  final String mySpecialization;

  const OngoingProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.estimatedDurationDays,
    required this.expectedEndDate,
    required this.projectCompletionPercentage,
    required this.myCompletionPercentage,
    required this.mySpecialization,
  });

  factory OngoingProjectModel.fromJson(Map<String, dynamic> json) {
    return OngoingProjectModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      estimatedDurationDays: json['estimated_duration_days'] as int? ?? 0,
      expectedEndDate: json['expected_end_date'] as String? ?? '',
      projectCompletionPercentage: (json['project_completion_percentage'] as num?)?.toDouble() ?? 0.0,
      myCompletionPercentage: (json['my_completion_percentage'] as num?)?.toDouble() ?? 0.0,
      mySpecialization: json['my_specialization'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'estimated_duration_days': estimatedDurationDays,
      'expected_end_date': expectedEndDate,
      'project_completion_percentage': projectCompletionPercentage,
      'my_completion_percentage': myCompletionPercentage,
      'my_specialization': mySpecialization,
    };
  }

  OngoingProjectEntity toEntity() => OngoingProjectEntity(
        id: id,
        title: title,
        description: description,
        category: category,
        estimatedDurationDays: estimatedDurationDays,
        expectedEndDate: expectedEndDate,
        projectCompletionPercentage: projectCompletionPercentage,
        myCompletionPercentage: myCompletionPercentage,
        mySpecialization: mySpecialization,
      );
}

