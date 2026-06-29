import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_entity.dart' as base;

class TaskEntity extends base.TaskEntity {
  final String createdAt;

  const TaskEntity({
    required super.id,
    required super.title,
    required super.deadline,
    required this.createdAt,
    required super.priority,
    required super.status,
    super.daysRemaining,
    super.isOverdue,
  });

  double get percentageTimePassed {
    if (status == 'completed') return 100;
    if (createdAt.isEmpty || deadline.isEmpty) return 0;
    final created = DateTime.tryParse(createdAt);
    final due = DateTime.tryParse(deadline);
    if (created == null || due == null) return 0;
    final total = due.difference(created).inDays;
    if (total <= 0) return isOverdue ? 100 : 50;
    final remaining = daysRemaining.clamp(0, total.toDouble());
    return ((total - remaining) / total * 100).clamp(0, 100);
  }

  @override
  List<Object?> get props => [
        ...super.props,
        createdAt,
      ];
}
