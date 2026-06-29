import 'package:bridge_x/features/team_managment/my_tasks/data/models/active_task_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_tasks_entity.dart';

class ActiveTasksResponseModel {
  final List<ActiveTaskResponseModel> activeTasks;
  final int total;
  final int currentPage;
  final int lastPage;

  const ActiveTasksResponseModel({
    required this.activeTasks,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory ActiveTasksResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final tasksList = (data['active_tasks'] as List? ?? [])
        .map((e) =>
            ActiveTaskResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ActiveTasksResponseModel(
      activeTasks: tasksList,
      total: data['total'] as int? ?? 0,
      currentPage: data['current_page'] as int? ?? 1,
      lastPage: data['last_page'] as int? ?? 1,
    );
  }

  ActiveTasksEntity toEntity() => ActiveTasksEntity(
        activeTasks: activeTasks.map((m) => m.toEntity()).toList(),
        total: total,
        currentPage: currentPage,
        lastPage: lastPage,
      );
}
