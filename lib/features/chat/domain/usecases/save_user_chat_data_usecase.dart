import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveUserChatData implements UseCase<void, SaveUserChatDataParams> {
  final ChatRepository repository;

  SaveUserChatData(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveUserChatDataParams params) async {
    return await repository.saveUserChatData(params.userId, params.username, params.email);
  }
}

class SaveUserChatDataParams extends Equatable {
  final int userId;
  final String username;
  final String? email;

  const SaveUserChatDataParams({
    required this.userId,
    required this.username,
    this.email,
  });

  @override
  List<Object?> get props => [userId, username, email];
}
