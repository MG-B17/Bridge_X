import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_entity.dart';

class ActiveTaskEntity extends TaskEntity {
  final String projectName;
  final double percentageTimePassed;

  const ActiveTaskEntity({
    required super.id,
    required super.title,
    required this.projectName,
    required super.deadline,
    required super.priority,
    required super.status,
    required super.daysRemaining,
    required super.isOverdue,
    required this.percentageTimePassed,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        projectName,
        percentageTimePassed,
      ];
}
