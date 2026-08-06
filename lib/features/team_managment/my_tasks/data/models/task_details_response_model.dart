import 'package:bridge_x/features/team_managment/my_tasks/data/models/attachment_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/task_user_response_model.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_details_entity.dart';

class TaskDetailsResponseModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String deadline;
  final String projectName;
  final String? gitLink;
  final List<String> tags;
  final TaskUserResponseModel createdBy;
  final TaskUserResponseModel assignedTo;
  final List<AttachmentResponseModel> attachments;

  const TaskDetailsResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.deadline,
    required this.projectName,
    this.gitLink,
    required this.tags,
    required this.createdBy,
    required this.assignedTo,
    required this.attachments,
  });

  factory TaskDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final attachmentsList = (data['attachments'] as List? ?? [])
        .map((e) =>
            AttachmentResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final programmer = data['programmer'] as Map<String, dynamic>? ?? {};
    final team = data['team'] as Map<String, dynamic>? ?? {};
    final tagsList = (data['tags'] as List? ?? [])
        .map((e) => e.toString())
        .where((e) => e.isNotEmpty)
        .toList();
    final createdByJson =
        data['created_by'] as Map<String, dynamic>? ?? programmer;
    final assignedToJson =
        data['assigned_to'] as Map<String, dynamic>? ?? programmer;

    return TaskDetailsResponseModel(
      id: _readInt(data['id']),
      title: _readString(data['title']),
      description: _readString(data['description']),
      status: _readString(data['status']),
      priority: _readString(data['priority']),
      deadline: _readString(data['deadline']),
      projectName: _readString(
        data['project_name'] ?? team['name'] ?? team['team_name'],
      ),
      gitLink: _readNullableString(data['git_link']),
      tags: tagsList,
      createdBy: TaskUserResponseModel.fromJson(createdByJson),
      assignedTo: TaskUserResponseModel.fromJson(assignedToJson),
      attachments: attachmentsList,
    );
  }

  TaskDetailsEntity toEntity() => TaskDetailsEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        priority: priority,
        deadline: deadline,
        projectName: projectName,
        gitLink: gitLink,
        tags: tags,
        createdBy: createdBy.toEntity(),
        assignedTo: assignedTo.toEntity(),
        attachments: attachments.map((m) => m.toEntity()).toList(),
      );

  static int _readInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _readString(dynamic value) => value?.toString() ?? '';

  static String? _readNullableString(dynamic value) {
    final text = value?.toString();
    return text == null || text.isEmpty ? null : text;
  }
}
