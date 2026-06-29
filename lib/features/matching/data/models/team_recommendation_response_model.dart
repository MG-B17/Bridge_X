import '../../domain/entities/team_recommendation_entity.dart';

class TeamRecommendationResponseModel {
  final int teamId;
  final String teamName;
  final List<String> matchedSkills;
  final int matchedSkillsCount;
  final num skillCoverage;
  final int missingSkillsCount;
  final String teamVibe;
  final num chemistryScore;
  final num experienceFitScore;
  final num totalMatchScore;

  const TeamRecommendationResponseModel({
    required this.teamId,
    required this.teamName,
    required this.matchedSkills,
    required this.matchedSkillsCount,
    required this.skillCoverage,
    required this.missingSkillsCount,
    required this.teamVibe,
    required this.chemistryScore,
    required this.experienceFitScore,
    required this.totalMatchScore,
  });

  factory TeamRecommendationResponseModel.fromJson(Map<String, dynamic> json) {
    return TeamRecommendationResponseModel(
      teamId: json['team_id'] as int? ?? 0,
      teamName: json['team_name'] as String? ?? '',
      matchedSkills: (json['matched_skills'] as List? ?? [])
          .map((e) => e as String)
          .toList(),
      matchedSkillsCount: json['matched_skills_count'] as int? ?? 0,
      skillCoverage: (json['skill_coverage'] as num? ?? 0).toDouble(),
      missingSkillsCount: json['missing_skills_count'] as int? ?? 0,
      teamVibe: json['team_vibe'] as String? ?? '',
      chemistryScore: (json['chemistry_score'] as num? ?? 0).toDouble(),
      experienceFitScore: (json['experience_fit_score'] as num? ?? 0).toDouble(),
      totalMatchScore: (json['total_match_score'] as num? ?? 0).toDouble(),
    );
  }

  TeamRecommendationEntity toEntity() => TeamRecommendationEntity(
        teamId: teamId,
        teamName: teamName,
        matchedSkills: matchedSkills,
        matchedSkillsCount: matchedSkillsCount,
        skillCoverage: skillCoverage,
        missingSkillsCount: missingSkillsCount,
        teamVibe: teamVibe,
        chemistryScore: chemistryScore,
        experienceFitScore: experienceFitScore,
        totalMatchScore: totalMatchScore,
      );
}
