import 'package:bridge_x/features/team_managment/task_management/domain/entities/task_entity.dart';
import 'package:equatable/equatable.dart';

class ViewTaskEntity extends Equatable {
  final List<TaskEntity> activeTasks;
  final List<TaskEntity> completedTasks;
  final List<TaskEntity> inProgressTasks;
  final List<TaskEntity> todoTasks;

  const ViewTaskEntity({
    required this.activeTasks,
    required this.completedTasks,
    required this.inProgressTasks,
    required this.todoTasks,
  });

  factory ViewTaskEntity.fromTasks(List<TaskEntity> allTasks) {
    final completed = allTasks.where((t) => t.status == 'completed').toList();
    final active = allTasks.where((t) => t.status != 'completed').toList();
    return ViewTaskEntity(
      activeTasks: active,
      completedTasks: completed,
      inProgressTasks: active.where((t) => t.status == 'in_progress').toList(),
      todoTasks: active.where((t) => t.status == 'todo').toList(),
    );
  }

  @override
  List<Object?> get props => [activeTasks, completedTasks];
}
