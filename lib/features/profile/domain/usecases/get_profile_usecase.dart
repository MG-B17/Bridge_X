import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, EditProfileEntity>> call() {
    return repository.getProfile();
  }
}
