import 'package:bridge_x/feature/task_management/domain/entities/create_task_entity.dart';

class CreateTaskResponseModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final int programmerId;
  final String programmerName;
  final String deadline;
  final int priority;
  final String? gitLink;
  final List<String> tags;
  final int teamId;

  const CreateTaskResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.programmerId,
    required this.programmerName,
    required this.deadline,
    required this.priority,
    this.gitLink,
    required this.tags,
    required this.teamId,
  });

  factory CreateTaskResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final programmer = data['programmer'] as Map<String, dynamic>?;
    final user = programmer?['user'] as Map<String, dynamic>?;

    return CreateTaskResponseModel(
      id: data['id'] as int? ?? 0,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      status: data['status'] as String? ?? '',
      programmerId: data['programmer_id'] as int? ?? 0,
      programmerName: user?['full_name'] as String? ?? '',
      deadline: data['deadline'] as String? ?? '',
      priority: data['priority'] as int? ?? 1,
      gitLink: data['git_link'] as String?,
      tags: (data['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      teamId: data['team_id'] as int? ?? 0,
    );
  }

  CreateTaskEntity toEntity() => CreateTaskEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        programmerId: programmerId,
        programmerName: programmerName,
        deadline: deadline,
        priority: priority,
        gitLink: gitLink,
        tags: tags,
        teamId: teamId,
      );
}
