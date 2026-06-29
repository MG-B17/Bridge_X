import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/task_user_entity.dart';

class TaskUserResponseModel {
  final int id;
  final String name;
  final String? avatarUrl;

  const TaskUserResponseModel({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  factory TaskUserResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskUserResponseModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  TaskUserEntity toEntity() => TaskUserEntity(
        id: id,
        name: name,
        avatarUrl: avatarUrl,
      );
}
