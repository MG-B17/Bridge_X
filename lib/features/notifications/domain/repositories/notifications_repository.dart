import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/notifications/domain/entities/notification_entity.dart';
import 'package:bridge_x/features/notifications/domain/entities/unread_count_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  Future<Either<Failure, void>> markNotificationAsRead({
    required String notificationId,
  });

  Future<Either<Failure, void>> markAllNotificationsAsRead();

  Future<Either<Failure, UnreadCountEntity>> getUnreadCount();
}
