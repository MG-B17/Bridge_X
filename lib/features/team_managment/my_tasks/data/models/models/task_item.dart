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
  final String priority;
  final String description;
  final String createdBy;
  final String creatorAvatar;
  final String assignedTo;
  final String assignedAvatar;
  final String? gitLink;
  final List<String> tags;
  final List<TaskAttachment> attachments;

  TaskItem({
    required this.id,
    required this.project,
    required this.title,
    required this.progress,
    required this.dueDate,
    required this.status,
    this.priority = '',
    required this.description,
    required this.createdBy,
    required this.creatorAvatar,
    this.assignedTo = '',
    this.assignedAvatar = '',
    this.gitLink,
    this.tags = const [],
    required this.attachments,
  });
}

class TaskAttachment {
  final String name;
  final String size;
  final String dateAdded;
  final bool isPdf;
  final String url;

  TaskAttachment({
    required this.name,
    required this.size,
    required this.dateAdded,
    required this.isPdf,
    this.url = '',
  });
}
