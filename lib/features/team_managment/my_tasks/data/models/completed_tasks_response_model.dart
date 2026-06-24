import 'package:bridge_x/features/team_managment/my_tasks/data/models/completed_task_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_tasks_entity.dart';

class CompletedTasksResponseModel {
  final int numOfTasksDone;
  final int numOfTasksDoneThisWeek;
  final List<CompletedTaskResponseModel> completedTasks;
  final int currentPage;
  final int lastPage;

  const CompletedTasksResponseModel({
    required this.numOfTasksDone,
    required this.numOfTasksDoneThisWeek,
    required this.completedTasks,
    required this.currentPage,
    required this.lastPage,
  });

  factory CompletedTasksResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final tasksList = (data['completed_tasks'] as List? ?? [])
        .map((e) =>
            CompletedTaskResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return CompletedTasksResponseModel(
      numOfTasksDone: data['num_of_tasks_done'] as int? ?? 0,
      numOfTasksDoneThisWeek:
          data['num_of_tasks_done_this_week'] as int? ?? 0,
      completedTasks: tasksList,
      currentPage: data['current_page'] as int? ?? 1,
      lastPage: data['last_page'] as int? ?? 1,
    );
  }

  CompletedTasksEntity toEntity() => CompletedTasksEntity(
        numOfTasksDone: numOfTasksDone,
        numOfTasksDoneThisWeek: numOfTasksDoneThisWeek,
        completedTasks: completedTasks.map((m) => m.toEntity()).toList(),
        currentPage: currentPage,
        lastPage: lastPage,
      );
}
