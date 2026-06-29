import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/notifications/domain/entities/notification_entity.dart';
import 'package:bridge_x/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUseCase
    implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationsRepository repository;

  GetNotificationsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) {
    return repository.getNotifications();
  }
}
