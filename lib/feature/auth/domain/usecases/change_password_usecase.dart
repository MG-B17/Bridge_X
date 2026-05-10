import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUsecase {
    final AuthRepo authRepo;
  
    ChangePasswordUsecase({required this.authRepo});
  
    Future<Either<Failure,String>> call({required ChangePasswordEntity changePasswordEntity}) async {
      return await authRepo.changePassword(changePasswordEntity: changePasswordEntity);
    }
}