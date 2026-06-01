import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';

class LevelResponseModel extends LevelEntity {
  const LevelResponseModel({
    required super.currentLevelFull,
    required super.baseLevel,
    required super.subLevel,
    required super.progressPercentage,
    required super.nextLevelFull,
    required super.totalTasks,
    required super.averageRating,
  });

  factory LevelResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return LevelResponseModel(
      currentLevelFull: data['current_level_full'] as String? ?? '',
      baseLevel: data['base_level'] as String? ?? '',
      subLevel: data['sub_level'] as String? ?? '',
      progressPercentage: data['progress_percentage'] as int? ?? 0,
      nextLevelFull: data['next_level_full'] as String? ?? '',
      totalTasks: data['total_tasks'] as int? ?? 0,
      averageRating: data['average_rating'] as num? ?? 0,
    );
  }
}
