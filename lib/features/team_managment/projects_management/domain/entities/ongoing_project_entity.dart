import 'package:equatable/equatable.dart';

class OngoingProjectEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final int estimatedDurationDays;
  final String expectedEndDate;
  final double projectCompletionPercentage;
  final double myCompletionPercentage;
  final String mySpecialization;
  final int memberCount;
  final bool isLeader;

  const OngoingProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.estimatedDurationDays,
    required this.expectedEndDate,
    required this.projectCompletionPercentage,
    required this.myCompletionPercentage,
    required this.mySpecialization,
    this.memberCount = 0,
    this.isLeader = false,
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
    memberCount,
    isLeader,
  ];
}
