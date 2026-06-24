import 'package:equatable/equatable.dart';
import 'active_task_entity.dart';

class ActiveTasksEntity extends Equatable {
  final List<ActiveTaskEntity> activeTasks;
  final int total;
  final int currentPage;
  final int lastPage;

  const ActiveTasksEntity({
    required this.activeTasks,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [activeTasks, total, currentPage, lastPage];
}
