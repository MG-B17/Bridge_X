import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final AuthRepo authRepo;

  ResetPasswordUsecase({required this.authRepo});

  Future<Either<Failure,String>> call({required ResetPasswordEntity resetPasswordEntity}) {
    return authRepo.resetPassword(resetPasswordEntity: resetPasswordEntity);
  }
}
