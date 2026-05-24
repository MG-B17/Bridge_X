import 'package:equatable/equatable.dart';

class CompletedProjectEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final int estimatedDurationDays;
  final String expectedEndDate;
  final double projectCompletionPercentage;
  final double myCompletionPercentage;
  final String mySpecialization;

  const CompletedProjectEntity({
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
  ];
}
