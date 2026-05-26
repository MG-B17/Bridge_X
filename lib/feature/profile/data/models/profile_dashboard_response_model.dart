import 'package:bridge_x/feature/profile/domain/entities/profile_dashboard_entity.dart';

import 'profile_model.dart';
import 'task_statistics_model.dart';

class ProfileDashboardResponseModel extends ProfileDashboardEntity {
  const ProfileDashboardResponseModel({
    required super.profile,
    required super.tasksStatistics,
    required super.teamsCount,
  });

  factory ProfileDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return ProfileDashboardResponseModel(
      profile: ProfileModel.fromJson(data['profile'] as Map<String, dynamic>? ?? {}),
      tasksStatistics: TaskStatisticsModel.fromJson(data['tasks_statistics'] as Map<String, dynamic>? ?? {}),
      teamsCount: data['teams_count'] as int? ?? 0,
    );
  }
}
