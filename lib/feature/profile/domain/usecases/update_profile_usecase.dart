import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/profile/data/models/update_profile_request_model.dart';
import 'package:bridge_x/feature/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failure, EditProfileEntity>> call(UpdateProfileRequestModel request) {
    return repository.updateProfile(request);
  }
}
