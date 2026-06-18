import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase({required this.authRepo});

  Future<Either<Failure, LoginResultEntity>> call({
    required LoginEntity loginEntity,
  }) async {
    return await authRepo.login(loginEntity: loginEntity);
  }
}
