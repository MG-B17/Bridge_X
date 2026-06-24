import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String deadline;
  final String priority;
  final String status;
  final double daysRemaining;
  final bool isOverdue;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.deadline,
    required this.priority,
    required this.status,
    this.daysRemaining = 0,
    this.isOverdue = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        deadline,
        priority,
        status,
        daysRemaining,
        isOverdue,
      ];
}
