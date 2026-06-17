import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';

class SubscribeToChatRooms implements StreamUseCase<List<ChatRoomEntity>, NoParams> {
  final ChatRepository repository;

  SubscribeToChatRooms(this.repository);

  @override
  Stream<List<ChatRoomEntity>> call(NoParams params) {
    return repository.subscribeToChatRooms();
  }
}