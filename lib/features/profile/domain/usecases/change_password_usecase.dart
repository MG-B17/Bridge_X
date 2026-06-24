import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/profile/data/models/change_password_request.dart';
import 'package:bridge_x/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) {
    return repository.changePassword(
      ChangePasswordRequestModel(
        currentPassword: currentPassword,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
  }
}
