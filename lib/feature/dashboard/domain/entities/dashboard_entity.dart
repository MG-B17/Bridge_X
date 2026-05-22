import 'package:bridge_x/feature/dashboard/domain/entities/project_detail_entity.dart';
import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final int programmerId;
  final String programmerName;
  final int totalTasksAllProjects;
  final int completedTasksAllProjects;
  final double overallCompletionRate;
  final int totalProjectsParticipated;
  final List<ProjectDetailEntity> projectsDetails;

  const DashboardEntity({
    required this.programmerId,
    required this.programmerName,
    required this.totalTasksAllProjects,
    required this.completedTasksAllProjects,
    required this.overallCompletionRate,
    required this.totalProjectsParticipated,
    required this.projectsDetails,
  });

  @override
  List<Object?> get props => [
    programmerId,
    programmerName,
    totalTasksAllProjects,
    completedTasksAllProjects,
    overallCompletionRate,
    totalProjectsParticipated,
    projectsDetails,
  ];
}
