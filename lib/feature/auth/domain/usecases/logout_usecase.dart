import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final AuthRepo authRepo;

  LogoutUseCase({required this.authRepo});

  Future<Either<Failure, void>> call() async {
    return await authRepo.logout();
  }
}
