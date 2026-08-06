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
    final user = json['user'] as Map<String, dynamic>?;
    return TaskUserResponseModel(
      id: _readInt(json['id'] ?? json['programmer_id']),
      name: _readString(
        json['name'] ??
            json['full_name'] ??
            user?['name'] ??
            user?['full_name'] ??
            user?['username'],
      ),
      avatarUrl: _readNullableString(
        json['avatar_url'] ?? user?['avatar_url'] ?? user?['avatar'],
      ),
    );
  }

  TaskUserEntity toEntity() => TaskUserEntity(
        id: id,
        name: name,
        avatarUrl: avatarUrl,
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
