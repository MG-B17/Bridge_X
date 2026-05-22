import 'package:equatable/equatable.dart';

class ProjectDetailEntity extends Equatable {
  final int projectId;
  final String projectTitle;
  final double completionPercentage;

  const ProjectDetailEntity({
    required this.projectId,
    required this.projectTitle,
    required this.completionPercentage,
  });

  @override
  List<Object?> get props => [projectId, projectTitle, completionPercentage];
}
