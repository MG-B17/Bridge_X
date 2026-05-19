import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase {
  final AuthRepo authRepo;

  RegisterUsecase({required this.authRepo});

  Future<Either<Failure,String>> call({required RegisterEntity registerEntity}) async {
    return await authRepo.register(registerEntity: registerEntity);
  }
}
