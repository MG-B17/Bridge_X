import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/data/models/rest_password_reponse_model.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class VerifyPasswordUsecase {
  final AuthRepo authRepo;

  VerifyPasswordUsecase({required this.authRepo});

  Future<Either<Failure,RestPasswordReponseModel>> call({required VerifyCodeEntity verifyPasswordEntity})async{
    return await authRepo.verifyPassword(verifyPasswordEntity: verifyPasswordEntity);
  }
}