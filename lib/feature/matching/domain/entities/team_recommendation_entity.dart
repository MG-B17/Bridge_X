import 'package:equatable/equatable.dart';

class TeamRecommendationEntity extends Equatable {
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

  const TeamRecommendationEntity({
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

  @override
  List<Object?> get props => [
        teamId,
        teamName,
        matchedSkills,
        matchedSkillsCount,
        skillCoverage,
        missingSkillsCount,
        teamVibe,
        chemistryScore,
        experienceFitScore,
        totalMatchScore,
      ];
}
