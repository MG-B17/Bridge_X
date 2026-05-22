import 'package:bridge_x/feature/dashboard/data/models/dashboard_response_model.dart';

class DashboardLocalModel extends DashboardResponseModel {
  final DateTime cachedAt;

  const DashboardLocalModel({
    required super.programmerId,
    required super.programmerName,
    required super.totalTasksAllProjects,
    required super.completedTasksAllProjects,
    required super.overallCompletionRate,
    required super.totalProjectsParticipated,
    required super.projectsDetails,
    required this.cachedAt,
  });

  factory DashboardLocalModel.fromResponseModel(DashboardResponseModel model, DateTime cachedAt) {
    return DashboardLocalModel(
      programmerId: model.programmerId,
      programmerName: model.programmerName,
      totalTasksAllProjects: model.totalTasksAllProjects,
      completedTasksAllProjects: model.completedTasksAllProjects,
      overallCompletionRate: model.overallCompletionRate,
      totalProjectsParticipated: model.totalProjectsParticipated,
      projectsDetails: model.projectsDetails,
      cachedAt: cachedAt,
    );
  }

  factory DashboardLocalModel.fromJson(Map<String, dynamic> json) {
    final responseModel = DashboardResponseModel.fromJson(json);
    return DashboardLocalModel(
      programmerId: responseModel.programmerId,
      programmerName: responseModel.programmerName,
      totalTasksAllProjects: responseModel.totalTasksAllProjects,
      completedTasksAllProjects: responseModel.completedTasksAllProjects,
      overallCompletionRate: responseModel.overallCompletionRate,
      totalProjectsParticipated: responseModel.totalProjectsParticipated,
      projectsDetails: responseModel.projectsDetails,
      cachedAt: DateTime.parse(json['cached_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['cached_at'] = cachedAt.toIso8601String();
    return map;
  }
}
