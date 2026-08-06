import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/profile/domain/repositories/profile_repository.dart';
import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';
import 'package:dartz/dartz.dart';

class GetSkillsExperienceUseCase {
  final ProfileRepository repository;

  GetSkillsExperienceUseCase({required this.repository});

  Future<Either<Failure, SkillsExperienceEntity>> call() {
    return repository.getSkillsExperience();
  }
}
