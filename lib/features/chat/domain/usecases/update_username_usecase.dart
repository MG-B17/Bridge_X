import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateUsername implements UseCase<void, UpdateUsernameParams> {
  final ChatRepository repository;

  UpdateUsername(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUsernameParams params) async {
    return await repository.updateUsername(params.userId, params.newUsername);
  }
}

class UpdateUsernameParams extends Equatable {
  final int userId;
  final String newUsername;

  const UpdateUsernameParams({required this.userId, required this.newUsername});

  @override
  List<Object?> get props => [userId, newUsername];
}
