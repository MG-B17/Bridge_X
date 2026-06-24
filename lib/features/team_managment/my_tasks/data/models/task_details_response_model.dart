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

    return TaskDetailsResponseModel(
      id: data['id'] as int? ?? 0,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      status: data['status'] as String? ?? '',
      priority: data['priority'] as String? ?? '',
      deadline: data['deadline'] as String? ?? '',
      projectName: data['project_name'] as String? ?? '',
      createdBy: TaskUserResponseModel.fromJson(
          data['created_by'] as Map<String, dynamic>? ?? {}),
      assignedTo: TaskUserResponseModel.fromJson(
          data['assigned_to'] as Map<String, dynamic>? ?? {}),
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
        createdBy: createdBy.toEntity(),
        assignedTo: assignedTo.toEntity(),
        attachments: attachments.map((m) => m.toEntity()).toList(),
      );
}
