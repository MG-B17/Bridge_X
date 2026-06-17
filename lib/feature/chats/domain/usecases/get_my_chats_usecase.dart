import 'package:dartz/dartz.dart';
import 'package:bridge_x/core/error/failure.dart';
import '../entities/chat_room_entity.dart';
import '../repositories/chats_repository.dart';

class GetMyChatsUseCase {
  final ChatsRepository repository;

  GetMyChatsUseCase({required this.repository});

  Future<Either<Failure, List<ChatRoomEntity>>> call() async {
    return await repository.getMyChats();
  }
}
