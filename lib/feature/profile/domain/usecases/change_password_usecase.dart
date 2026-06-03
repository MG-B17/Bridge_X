import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/profile/data/models/change_password_request.dart';
import 'package:bridge_x/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<Either<Failure, String>> call(ChangePasswordRequestModel request) {
    return repository.changePassword(request);
  }
}
