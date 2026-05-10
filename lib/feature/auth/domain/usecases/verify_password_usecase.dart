import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_password_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class VerifyPasswordUsecase {
  final AuthRepo authRepo;

  VerifyPasswordUsecase({required this.authRepo});

  Future<Either<Failure, VerifyPasswordResultEntity>> call({required VerifyCodeEntity verifyPasswordEntity}) =>
      authRepo.verifyPassword(verifyPasswordEntity: verifyPasswordEntity);
}