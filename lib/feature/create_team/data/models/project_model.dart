import 'dart:convert';

import 'package:bridge_x/feature/create_team/domain/entity/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.categoryName,
    required super.categories,
    required super.requiredTracks,
    required super.githubUrl,
    required super.status,
    required super.estimatedDurationDays,
    required super.userId,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      categories: _parseStringList(json['categories']),
      requiredTracks: _parseStringList(json['required_tracks']),
      githubUrl: json['github_url'] as String? ?? '',
      status: json['status'] as String? ?? '',
      estimatedDurationDays: json['estimated_duration_days'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      createdBy: json['created_by']?.toString(),
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {
        return [value];
      }
    }
    return [];
  }
}
