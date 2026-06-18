import 'package:equatable/equatable.dart';

class ProjectItemEntity extends Equatable {
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
  final String? imageUrl;

  const ProjectItemEntity({
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
    this.imageUrl,
  });

  bool get isCompleted => completionDate != null;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        estimatedDurationDays,
        expectedEndDate,
        projectCompletionPercentage,
        myCompletionPercentage,
        mySpecialization,
        completionDate,
        imageUrl,
      ];
}
