import 'package:equatable/equatable.dart';

class CompletedTaskEntity extends Equatable {
  final int taskId;
  final String taskTitle;
  final String completionDate;
  final String projectName;
  final int estimatedHours;
  final int? actualHours;

  const CompletedTaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.completionDate,
    required this.projectName,
    required this.estimatedHours,
    this.actualHours,
  });

  @override
  List<Object?> get props => [
        taskId,
        taskTitle,
        completionDate,
        projectName,
        estimatedHours,
        actualHours,
      ];
}
