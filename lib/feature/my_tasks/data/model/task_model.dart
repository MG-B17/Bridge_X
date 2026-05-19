enum TaskStatus {
  inProgress,
  pending,
  nearCompletion,
  completed,
}

class TaskItem {
  final String id;
  final String project;
  final String title;
  final double progress;
  final String dueDate;
  final TaskStatus status;
  final String description;
  final String createdBy;
  final String creatorAvatar;
  final List<TaskAttachment> attachments;

  TaskItem({
    required this.id,
    required this.project,
    required this.title,
    required this.progress,
    required this.dueDate,
    required this.status,
    required this.description,
    required this.createdBy,
    required this.creatorAvatar,
    required this.attachments,
  });
}

class TaskAttachment {
  final String name;
  final String size;
  final String dateAdded;
  final bool isPdf;

  TaskAttachment({
    required this.name,
    required this.size,
    required this.dateAdded,
    required this.isPdf,
  });
}
