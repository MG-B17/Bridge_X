import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/profile/data/models/change_password_request.dart';
import 'package:bridge_x/features/profile/data/models/update_profile_request_model.dart';
import 'package:bridge_x/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/features/profile/domain/entities/profile_dashboard_entity.dart';
import 'package:bridge_x/features/skills_and_experience/data/model/update_skills_experience_request_model.dart';
import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDashboardEntity>> getProfileDashboard();
  Future<Either<Failure, EditProfileEntity>> getProfile();
  Future<Either<Failure, EditProfileEntity>> updateProfile(
    UpdateProfileRequestModel request,
  );
  Future<Either<Failure, SkillsExperienceEntity>> getSkillsExperience();
  Future<Either<Failure, Unit>> updateSkillsExperience(
    UpdateSkillsExperienceRequestModel request,
  );
  Future<Either<Failure, Unit>> changePassword(ChangePasswordRequestModel request);
  Future<Either<Failure, Unit>> softDeleteProfile();
}
