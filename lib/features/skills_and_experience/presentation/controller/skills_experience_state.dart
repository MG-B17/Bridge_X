import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SkillsExperienceState extends Equatable {
  const SkillsExperienceState();

  @override
  List<Object?> get props => [];
}

class SkillsExperienceInitial extends SkillsExperienceState {}

class SkillsExperienceLoading extends SkillsExperienceState {}

class SkillsExperienceLoaded extends SkillsExperienceState {
  final SkillsExperienceEntity skillsExperience;

  const SkillsExperienceLoaded({required this.skillsExperience});

  @override
  List<Object?> get props => [skillsExperience];
}

class SkillsExperienceUpdating extends SkillsExperienceState {
  final SkillsExperienceEntity skillsExperience;

  const SkillsExperienceUpdating({required this.skillsExperience});

  @override
  List<Object?> get props => [skillsExperience];
}

class SkillsExperienceUpdated extends SkillsExperienceState {
  final SkillsExperienceEntity skillsExperience;

  const SkillsExperienceUpdated({required this.skillsExperience});

  @override
  List<Object?> get props => [skillsExperience];
}

class SkillsExperienceError extends SkillsExperienceState {
  final String message;

  const SkillsExperienceError({required this.message});

  @override
  List<Object?> get props => [message];
}
