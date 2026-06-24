import 'package:equatable/equatable.dart';
import 'completed_task_entity.dart';

class CompletedTasksEntity extends Equatable {
  final int numOfTasksDone;
  final int numOfTasksDoneThisWeek;
  final List<CompletedTaskEntity> completedTasks;
  final int currentPage;
  final int lastPage;

  const CompletedTasksEntity({
    required this.numOfTasksDone,
    required this.numOfTasksDoneThisWeek,
    required this.completedTasks,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [
        numOfTasksDone,
        numOfTasksDoneThisWeek,
        completedTasks,
        currentPage,
        lastPage,
      ];
}
