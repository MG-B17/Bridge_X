import 'package:equatable/equatable.dart';

import 'profile_entity.dart';
import 'task_statistics_entity.dart';

class ProfileDashboardEntity extends Equatable {
  final ProfileEntity profile;
  final TaskStatisticsEntity tasksStatistics;
  final int teamsCount;

  const ProfileDashboardEntity({
    required this.profile,
    required this.tasksStatistics,
    required this.teamsCount,
  });

  @override
  List<Object?> get props => [profile, tasksStatistics, teamsCount];
}
