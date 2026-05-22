import 'package:bridge_x/feature/dashboard/data/models/project_detail_model.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/dashboard_entity.dart';

class DashboardResponseModel extends DashboardEntity {
  const DashboardResponseModel({
    required super.programmerId,
    required super.programmerName,
    required super.totalTasksAllProjects,
    required super.completedTasksAllProjects,
    required super.overallCompletionRate,
    required super.totalProjectsParticipated,
    required super.projectsDetails,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    final projectsList = data['projects_details'] as List? ?? [];
    final projects = projectsList
        .map((e) => ProjectDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return DashboardResponseModel(
      programmerId: data['programmer_id'] as int? ?? 0,
      programmerName: data['programmer_name'] as String? ?? '',
      totalTasksAllProjects: data['total_tasks_all_projects'] as int? ?? 0,
      completedTasksAllProjects: data['completed_tasks_all_projects'] as int? ?? 0,
      overallCompletionRate: (data['overall_completion_rate'] as num?)?.toDouble() ?? 0.0,
      totalProjectsParticipated: data['total_projects_participated'] as int? ?? 0,
      projectsDetails: projects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'programmer_id': programmerId,
      'programmer_name': programmerName,
      'total_tasks_all_projects': totalTasksAllProjects,
      'completed_tasks_all_projects': completedTasksAllProjects,
      'overall_completion_rate': overallCompletionRate,
      'total_projects_participated': totalProjectsParticipated,
      'projects_details': projectsDetails.map((e) => (e as ProjectDetailModel).toJson()).toList(),
    };
  }
}
