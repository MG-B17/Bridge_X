import 'team_recommendation_response_model.dart';
import '../../domain/entities/ai_match_entity.dart';

class AiMatchResponseModel {
  final int userId;
  final List<int> teamIds;
  final List<TeamRecommendationResponseModel> recommendations;

  const AiMatchResponseModel({
    required this.userId,
    required this.teamIds,
    required this.recommendations,
  });

  factory AiMatchResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final recommendationsList = (data['recommendations'] as List? ?? [])
        .map((e) => TeamRecommendationResponseModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return AiMatchResponseModel(
      userId: data['user_id'] as int? ?? 0,
      teamIds: (data['team_ids'] as List? ?? [])
          .map((e) => e as int)
          .toList(),
      recommendations: recommendationsList,
    );
  }

  AiMatchEntity toEntity() => AiMatchEntity(
        userId: userId,
        teamIds: teamIds,
        recommendations: recommendations
            .map((r) => r.toEntity())
            .toList(),
      );
}
