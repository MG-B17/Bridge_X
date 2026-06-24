import 'package:bridge_x/features/team_managment/my_tasks/data/models/models/task_item.dart';
import 'package:equatable/equatable.dart';

sealed class MyTasksState extends Equatable {
  const MyTasksState();

  @override
  List<Object?> get props => [];
}

// --- Initial ---
class MyTasksInitial extends MyTasksState {
  const MyTasksInitial();
}

// --- Combined Loading / Loaded / Failure ---
class MyTasksLoading extends MyTasksState {
  const MyTasksLoading();
}

class MyTasksLoaded extends MyTasksState {
  final List<TaskItem> activeTasks;
  final List<TaskItem> completedTasks;
  final int numOfTasksDone;
  final int numOfTasksDoneThisWeek;
  final String? partialFailureMessage;

  const MyTasksLoaded({
    required this.activeTasks,
    required this.completedTasks,
    required this.numOfTasksDone,
    required this.numOfTasksDoneThisWeek,
    this.partialFailureMessage,
  });

  @override
  List<Object?> get props => [
        activeTasks,
        completedTasks,
        numOfTasksDone,
        numOfTasksDoneThisWeek,
        partialFailureMessage,
      ];
}

class MyTasksFailure extends MyTasksState {
  final String message;

  const MyTasksFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// --- Task Details ---
class TaskDetailsLoading extends MyTasksState {
  const TaskDetailsLoading();
}

class TaskDetailsLoaded extends MyTasksState {
  final TaskItem task;

  const TaskDetailsLoaded(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDetailsFailure extends MyTasksState {
  final String message;

  const TaskDetailsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
