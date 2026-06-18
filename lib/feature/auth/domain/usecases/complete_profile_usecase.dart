import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class CompleteProfileUseCase {
  final AuthRepo authRepo;

  CompleteProfileUseCase({required this.authRepo});

  Future<Either<Failure, Unit>> call({
    required String track,
    required String experienceLevel,
  }) async {
    return await authRepo.completeProfile(
      track: track,
      experienceLevel: experienceLevel,
    );
  }
}
