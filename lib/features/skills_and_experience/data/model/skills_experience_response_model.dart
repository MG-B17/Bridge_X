import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';

class SkillsExperienceResponseModel extends SkillsExperienceEntity {
  const SkillsExperienceResponseModel({
    required super.experienceLevel,
    required super.skills,
    super.experience,
  });

  factory SkillsExperienceResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final skillsList = (data['skills'] as List<dynamic>?)
            ?.map((skill) => skill.toString())
            .toList() ??
        [];

    return SkillsExperienceResponseModel(
      experienceLevel: data['experience_level'] as String? ?? '',
      skills: skillsList,
      experience: data['experience'] as String?,
    );
  }
}
