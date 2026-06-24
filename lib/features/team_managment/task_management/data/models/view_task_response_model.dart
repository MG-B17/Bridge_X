import 'package:bridge_x/features/team_managment/task_management/domain/entities/task_entity.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/view_task_entity.dart';

class ViewTaskResponseModel {
  final List<TaskEntity> allTasks;

  const ViewTaskResponseModel({required this.allTasks});

  factory ViewTaskResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    TaskEntity parseTask(Map<String, dynamic> t) => TaskEntity(
          id: t['id'] as int? ?? 0,
          title: t['title'] as String? ?? '',
          deadline: t['deadline'] as String? ?? '',
          createdAt: t['created_at'] as String? ?? '',
          priority: t['priority'] as String? ?? 'medium',
          status: t['status'] as String? ?? 'todo',
          daysRemaining: (t['days_remaining'] as num?)?.toDouble() ?? 0,
          isOverdue: t['is_overdue'] as bool? ?? false,
        );

    final tasks = (data['tasks'] as List?)
            ?.map((e) => parseTask(e as Map<String, dynamic>))
            .toList() ??
        [];

    return ViewTaskResponseModel(allTasks: tasks);
  }

  ViewTaskEntity toEntity() => ViewTaskEntity.fromTasks(allTasks);
}
