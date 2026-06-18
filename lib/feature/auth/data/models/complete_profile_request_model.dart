class CompleteProfileRequestModel {
  final String track;
  final String experienceLevel;

  const CompleteProfileRequestModel({
    required this.track,
    required this.experienceLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'track': track,
      'experience_level': experienceLevel,
    };
  }
}
