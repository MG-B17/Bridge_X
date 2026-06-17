import 'package:equatable/equatable.dart';
import 'team_recommendation_entity.dart';

class AiMatchEntity extends Equatable {
  final int userId;
  final List<int> teamIds;
  final List<TeamRecommendationEntity> recommendations;

  const AiMatchEntity({
    required this.userId,
    required this.teamIds,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [userId, teamIds, recommendations];
}
