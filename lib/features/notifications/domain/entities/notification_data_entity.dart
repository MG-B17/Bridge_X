import 'package:equatable/equatable.dart';

class NotificationDataEntity extends Equatable {
  final String? teamId;
  final String? teamName;
  final String? actionUrl;
  final String? dataSubType;
  final String? taskId;
  final String? taskTitle;

  const NotificationDataEntity({
    this.teamId,
    this.teamName,
    this.actionUrl,
    this.dataSubType,
    this.taskId,
    this.taskTitle,
  });

  @override
  List<Object?> get props => [teamId, teamName, actionUrl, dataSubType, taskId, taskTitle];
}
