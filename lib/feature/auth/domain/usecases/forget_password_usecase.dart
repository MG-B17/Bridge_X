import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUsecase {
  final AuthRepo authRepo;

  ForgetPasswordUsecase({required this.authRepo});

  Future<Either<Failure,String>> call({required ForgetPasswordEntity forgetPasswordEntity}) {
    return authRepo.forgetPassword(forgetPasswordEntity: forgetPasswordEntity);
  }
}