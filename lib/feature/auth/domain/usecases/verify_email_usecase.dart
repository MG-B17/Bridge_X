import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class VerifyEmailUsecase {
  final AuthRepo authRepo;

  VerifyEmailUsecase({required this.authRepo});

  Future<Either<Failure,String>> call({required VerifyCodeEntity verifyCodeEntity}) async {
    return await authRepo.verifyEmail(verifyCodeEntity: verifyCodeEntity);
  }
}