import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/profile/domain/repositories/profile_repository.dart';
import 'package:bridge_x/features/skills_and_experience/data/model/update_skills_experience_request_model.dart';
import 'package:dartz/dartz.dart';

class UpdateSkillsExperienceUseCase {
  final ProfileRepository repository;

  UpdateSkillsExperienceUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(UpdateSkillsExperienceRequestModel request) {
    return repository.updateSkillsExperience(request);
  }
}
