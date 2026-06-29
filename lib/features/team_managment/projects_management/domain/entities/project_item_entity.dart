import 'package:bridge_x/features/team_managment/projects_management/domain/entities/project_team_entity.dart';
import 'package:equatable/equatable.dart';

class ProjectItemEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final String status;
  final int estimatedDurationDays;
  final String expectedEndDate;
  final double projectCompletionPercentage;
  final double myCompletionPercentage;
  final String mySpecialization;
  final String? completionDate;
  final String? imageUrl;
  final bool isLeader;
  final ProjectTeamEntity? yourTeam;

  const ProjectItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.estimatedDurationDays,
    required this.expectedEndDate,
    required this.projectCompletionPercentage,
    required this.myCompletionPercentage,
    required this.mySpecialization,
    this.completionDate,
    this.imageUrl,
    this.isLeader = false,
    this.yourTeam,
  });

  bool get isCompleted => completionDate != null;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        status,
        estimatedDurationDays,
        expectedEndDate,
        projectCompletionPercentage,
        myCompletionPercentage,
        mySpecialization,
        completionDate,
        imageUrl,
        isLeader,
        yourTeam,
      ];
}
