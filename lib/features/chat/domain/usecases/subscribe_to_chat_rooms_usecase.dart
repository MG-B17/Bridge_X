import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SubscribeToChatRooms implements StreamUseCase<Either<Failure, List<ChatRoomEntity>>, SubscribeToChatRoomsParams> {
  final ChatRepository repository;

  SubscribeToChatRooms(this.repository);

  @override
  Stream<Either<Failure, List<ChatRoomEntity>>> call(SubscribeToChatRoomsParams params) {
    return repository.subscribeToChatRooms(params.userId);
  }
}

class SubscribeToChatRoomsParams extends Equatable {
  final int userId;

  const SubscribeToChatRoomsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
