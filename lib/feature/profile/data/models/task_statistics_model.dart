import 'package:bridge_x/feature/profile/domain/entities/task_statistics_entity.dart';

class TaskStatisticsModel extends TaskStatisticsEntity {
  const TaskStatisticsModel({
    required super.completedTasks,
    required super.inProgressTasks,
  });

  factory TaskStatisticsModel.fromJson(Map<String, dynamic> json) {
    return TaskStatisticsModel(
      completedTasks: json['completed_tasks'] as int? ?? 0,
      inProgressTasks: json['in_progress_tasks'] as int? ?? 0,
    );
  }
}
