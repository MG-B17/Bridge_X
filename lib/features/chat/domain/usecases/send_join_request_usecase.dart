import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendJoinRequest implements UseCase<void, SendJoinRequestParams> {
  final ChatRepository repository;

  SendJoinRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(SendJoinRequestParams params) async {
    return await repository.sendJoinRequest(params.roomId, params.userId);
  }
}

class SendJoinRequestParams extends Equatable {
  final String roomId;
  final int userId;

  const SendJoinRequestParams({required this.roomId, required this.userId});

  @override
  List<Object?> get props => [roomId, userId];
}
