import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MarkMessagesDelivered implements UseCase<void, MarkMessagesDeliveredParams> {
  final ChatRepository repository;

  MarkMessagesDelivered(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkMessagesDeliveredParams params) async {
    return await repository.markMessagesDelivered(params.roomId, params.userId);
  }
}

class MarkMessagesDeliveredParams extends Equatable {
  final String roomId;
  final int userId;

  const MarkMessagesDeliveredParams({required this.roomId, required this.userId});

  @override
  List<Object?> get props => [roomId, userId];
}
