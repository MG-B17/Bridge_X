import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class SoftDeleteProfileUseCase {
  final ProfileRepository repository;

  SoftDeleteProfileUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return repository.softDeleteProfile();
  }
}
