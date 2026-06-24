import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_task_entity.dart';

class ActiveTaskResponseModel {
  final int taskId;
  final String taskTitle;
  final String projectName;
  final String dueDate;
  final String priority;
  final String status;
  final double daysRemaining;
  final bool isOverdue;
  final double percentageTimePassed;

  const ActiveTaskResponseModel({
    required this.taskId,
    required this.taskTitle,
    required this.projectName,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.daysRemaining,
    required this.isOverdue,
    required this.percentageTimePassed,
  });

  factory ActiveTaskResponseModel.fromJson(Map<String, dynamic> json) {
    return ActiveTaskResponseModel(
      taskId: json['task_id'] as int? ?? 0,
      taskTitle: json['task_title'] as String? ?? '',
      projectName: json['project_name'] as String? ?? '',
      dueDate: json['due_date'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      status: json['status'] as String? ?? '',
      daysRemaining: (json['days_remaining'] as num?)?.toDouble() ?? 0.0,
      isOverdue: json['is_overdue'] as bool? ?? false,
      percentageTimePassed:
          (json['percentage_time_passed'] as num?)?.toDouble() ?? 0.0,
    );
  }

  ActiveTaskEntity toEntity() => ActiveTaskEntity(
        id: taskId,
        title: taskTitle,
        projectName: projectName,
        deadline: dueDate,
        priority: priority,
        status: status,
        daysRemaining: daysRemaining,
        isOverdue: isOverdue,
        percentageTimePassed: percentageTimePassed,
      );
}
