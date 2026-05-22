import 'package:bridge_x/feature/create_team/domain/entity/team_entity.dart';

class TeamModel extends TeamEntity {
  const TeamModel({
    required super.id,
    required super.name,
    required super.projectId,
    required super.isPublic,
    required super.status,
    required super.formationType,
    required super.joinCode,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      projectId: json['project_id'] as int? ?? 0,
      isPublic: json['is_public'] is bool
          ? json['is_public'] as bool
          : (json['is_public'] == 1 || json['is_public'] == 'true'),
      status: json['status'] as String? ?? '',
      formationType: json['formation_type'] as String? ?? '',
      joinCode: json['join_code']?.toString(),
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}
