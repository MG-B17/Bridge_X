class CreateTaskRequestModel {
  final String title;
  final String description;
  final int programmerId;
  final String deadline;
  final int priority;
  final String? gitLink;
  final List<String> tags;

  const CreateTaskRequestModel({
    required this.title,
    required this.description,
    required this.programmerId,
    required this.deadline,
    required this.priority,
    this.gitLink,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'programmer_id': programmerId,
      'deadline': deadline,
      'priority': priority,
      'tags': tags,
    };
    if (gitLink != null && gitLink!.isNotEmpty) {
      map['git_link'] = gitLink;
    }
    return map;
  }
}
