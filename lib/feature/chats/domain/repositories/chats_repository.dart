import 'package:dartz/dartz.dart';
import 'package:bridge_x/core/error/failure.dart';
import '../entities/chat_room_entity.dart';

abstract class ChatsRepository {
  Future<Either<Failure, List<ChatRoomEntity>>> getMyChats();
}
