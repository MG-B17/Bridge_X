import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_task_entity.dart';

class CompletedTaskResponseModel {
  final int taskId;
  final String taskTitle;
  final String completionDate;
  final String projectName;
  final int estimatedHours;
  final int? actualHours;

  const CompletedTaskResponseModel({
    required this.taskId,
    required this.taskTitle,
    required this.completionDate,
    required this.projectName,
    required this.estimatedHours,
    this.actualHours,
  });

  factory CompletedTaskResponseModel.fromJson(Map<String, dynamic> json) {
    return CompletedTaskResponseModel(
      taskId: json['task_id'] as int? ?? 0,
      taskTitle: json['task_title'] as String? ?? '',
      completionDate: json['completion_date'] as String? ?? '',
      projectName: json['project_name'] as String? ?? '',
      estimatedHours: json['estimated_hours'] as int? ?? 0,
      actualHours: json['actual_hours'] as int?,
    );
  }

  CompletedTaskEntity toEntity() => CompletedTaskEntity(
        taskId: taskId,
        taskTitle: taskTitle,
        completionDate: completionDate,
        projectName: projectName,
        estimatedHours: estimatedHours,
        actualHours: actualHours,
      );
}
