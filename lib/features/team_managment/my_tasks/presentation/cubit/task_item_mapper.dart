import 'package:bridge_x/features/team_managment/my_tasks/data/models/models/task_item.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_task_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_task_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_details_entity.dart';

class TaskItemMapper {
  static TaskItem fromActiveTask(ActiveTaskEntity task) {
    TaskStatus status;
    if (task.isOverdue) {
      status = TaskStatus.nearCompletion;
    } else {
      switch (task.status) {
        case 'active':
          status = TaskStatus.inProgress;
          break;
        default:
          status = TaskStatus.pending;
      }
    }

    final progress = (task.percentageTimePassed / 100).clamp(0.0, 1.0);

    return TaskItem(
      id: task.id.toString(),
      project: task.projectName,
      title: task.title,
      progress: progress,
      dueDate: task.deadline,
      status: status,
      priority: task.priority,
      description: '',
      createdBy: '',
      creatorAvatar: '',
      attachments: [],
    );
  }

  static TaskItem fromCompletedTask(CompletedTaskEntity task) {
    return TaskItem(
      id: task.taskId.toString(),
      project: task.projectName,
      title: task.taskTitle,
      progress: 1.0,
      dueDate: task.completionDate,
      status: TaskStatus.completed,
      priority: '',
      description: '',
      createdBy: '',
      creatorAvatar: '',
      attachments: [],
    );
  }

  static TaskItem fromTaskDetails(TaskDetailsEntity task) {
    TaskStatus status;
    switch (task.status) {
      case 'todo':
        status = TaskStatus.pending;
        break;
      case 'active':
      case 'in_progress':
        status = TaskStatus.inProgress;
        break;
      case 'completed':
        status = TaskStatus.completed;
        break;
      default:
        status = TaskStatus.pending;
    }

    double progress;
    switch (task.status) {
      case 'completed':
        progress = 1.0;
        break;
      case 'active':
      case 'in_progress':
        progress = 0.5;
        break;
      default:
        progress = 0.0;
    }

    final attachments = task.attachments
        .map(
          (a) => TaskAttachment(
            name: a.name,
            size: '',
            dateAdded: '',
            isPdf: (a.type?.toLowerCase().contains('pdf') ?? false) ||
                a.name.toLowerCase().endsWith('.pdf'),
            url: a.url ?? '',
          ),
        )
        .toList();

    return TaskItem(
      id: task.id.toString(),
      project: task.projectName,
      title: task.title,
      progress: progress,
      dueDate: task.deadline,
      status: status,
      priority: task.priority,
      description: task.description,
      createdBy: task.createdBy.name,
      creatorAvatar: task.createdBy.avatarUrl ?? '',
      assignedTo: task.assignedTo.name,
      assignedAvatar: task.assignedTo.avatarUrl ?? '',
      gitLink: task.gitLink,
      tags: task.tags,
      attachments: attachments,
    );
  }
}
