import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class WatchRoomMembership implements StreamUseCase<Either<Failure, bool>, WatchRoomMembershipParams> {
  final ChatRepository repository;

  WatchRoomMembership(this.repository);

  @override
  Stream<Either<Failure, bool>> call(WatchRoomMembershipParams params) {
    return repository.watchRoomMembership(params.roomId, params.userId);
  }
}

class WatchRoomMembershipParams extends Equatable {
  final String roomId;
  final int userId;

  const WatchRoomMembershipParams({required this.roomId, required this.userId});

  @override
  List<Object?> get props => [roomId, userId];
}
