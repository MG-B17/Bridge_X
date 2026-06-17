import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatRooms implements UseCase<List<ChatRoomEntity>, NoParams> {
  final ChatRepository repository;

  GetChatRooms(this.repository);

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> call(NoParams params) async {
    return await repository.getChatRooms();
  }
}