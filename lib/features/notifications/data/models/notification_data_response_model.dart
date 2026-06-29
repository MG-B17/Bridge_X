import 'package:bridge_x/features/notifications/domain/entities/notification_data_entity.dart';

class NotificationDataResponseModel {
  final String? teamId;
  final String? teamName;
  final String? actionUrl;
  final String? dataSubType;
  final String? taskId;
  final String? taskTitle;

  const NotificationDataResponseModel({
    this.teamId,
    this.teamName,
    this.actionUrl,
    this.dataSubType,
    this.taskId,
    this.taskTitle,
  });

  factory NotificationDataResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NotificationDataResponseModel();

    return NotificationDataResponseModel(
      teamId: _optionalString(json['team_id'] ?? json['teamId']),
      teamName: _optionalString(json['team_name'] ?? json['teamName']),
      actionUrl: _optionalString(json['action_url'] ?? json['actionUrl']),
      dataSubType: _optionalString(json['type']),
      taskId: _optionalString(json['task_id'] ?? json['taskId']),
      taskTitle: _optionalString(json['task_title'] ?? json['taskTitle']),
    );
  }

  static String? _optionalString(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  NotificationDataEntity toEntity() => NotificationDataEntity(
    teamId: teamId,
    teamName: teamName,
    actionUrl: actionUrl,
    dataSubType: dataSubType,
    taskId: taskId,
    taskTitle: taskTitle,
  );
}
