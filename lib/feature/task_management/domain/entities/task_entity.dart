import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status;
  final String dueDate;
  final int priority;
  final String createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.priority,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, status, dueDate, priority, createdAt];
}
