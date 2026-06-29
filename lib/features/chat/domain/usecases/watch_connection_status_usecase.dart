import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';

class WatchConnectionStatus {
  final ChatRepository repository;

  WatchConnectionStatus(this.repository);

  Stream<bool> call() {
    return repository.connectionStatus;
  }
}
