import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_user_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserChatData implements UseCase<ChatUserEntity?, GetUserChatDataParams> {
  final ChatRepository repository;

  GetUserChatData(this.repository);

  @override
  Future<Either<Failure, ChatUserEntity?>> call(GetUserChatDataParams params) async {
    return await repository.getUserChatData(params.userId);
  }
}

class GetUserChatDataParams extends Equatable {
  final int userId;

  const GetUserChatDataParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
