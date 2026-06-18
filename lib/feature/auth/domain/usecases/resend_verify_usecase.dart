import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ResendVerifyUseCase {
  final AuthRepo authRepo;

  ResendVerifyUseCase({required this.authRepo});

  Future<Either<Failure, String>> call({required String email}) {
    return authRepo.resendVerify(email: email);
  }
}
