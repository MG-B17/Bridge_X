import 'package:equatable/equatable.dart';

class SkillsExperienceEntity extends Equatable {
  final String experienceLevel;
  final List<String> skills;
  final String? experience;

  const SkillsExperienceEntity({
    required this.experienceLevel,
    required this.skills,
    this.experience,
  });

  @override
  List<Object?> get props => [experienceLevel, skills, experience];
}
