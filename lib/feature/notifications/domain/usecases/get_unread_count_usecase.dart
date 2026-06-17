import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/notifications/domain/entities/unread_count_entity.dart';
import 'package:bridge_x/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:dartz/dartz.dart';

class GetUnreadCountUseCase implements UseCase<UnreadCountEntity, NoParams> {
  final NotificationsRepository repository;

  GetUnreadCountUseCase({required this.repository});

  @override
  Future<Either<Failure, UnreadCountEntity>> call(NoParams params) {
    return repository.getUnreadCount();
  }
}
