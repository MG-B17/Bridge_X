class UpdateSkillsExperienceRequestModel {
  final List<String> skills;
  final String experience;

  const UpdateSkillsExperienceRequestModel({
    required this.skills,
    required this.experience,
  });

  Map<String, dynamic> toJson() {
    return {
      'skills': skills,
      'experience': experience,
    };
  }
}
