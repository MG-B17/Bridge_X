import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_entity.dart';
import 'attachment_entity.dart';
import 'task_user_entity.dart';

class TaskDetailsEntity extends TaskEntity {
  final String description;
  final String projectName;
  final String? gitLink;
  final List<String> tags;
  final TaskUserEntity createdBy;
  final TaskUserEntity assignedTo;
  final List<AttachmentEntity> attachments;

  const TaskDetailsEntity({
    required super.id,
    required super.title,
    required this.description,
    required super.status,
    required super.priority,
    required super.deadline,
    required this.projectName,
    this.gitLink,
    this.tags = const [],
    required this.createdBy,
    required this.assignedTo,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        description,
        projectName,
        gitLink,
        tags,
        createdBy,
        assignedTo,
        attachments,
      ];
}
