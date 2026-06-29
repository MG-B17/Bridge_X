import 'package:equatable/equatable.dart';

class TaskStatisticsEntity extends Equatable {
  final int completedTasks;
  final int inProgressTasks;

  const TaskStatisticsEntity({
    required this.completedTasks,
    required this.inProgressTasks,
  });

  @override
  List<Object?> get props => [completedTasks, inProgressTasks];
}
