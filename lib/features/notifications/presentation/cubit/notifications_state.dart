import 'package:bridge_x/features/notifications/domain/entities/notification_entity.dart';
import 'package:equatable/equatable.dart';

sealed class NotificationsState extends Equatable {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final String? errorMessage;
  final bool isActionLoading;

  const NotificationsState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
    this.isActionLoading = false,
  });

  @override
  List<Object?> get props => [
    notifications,
    unreadCount,
    errorMessage,
    isActionLoading,
  ];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading({super.notifications, super.unreadCount});
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({
    required super.notifications,
    required super.unreadCount,
    super.isActionLoading,
  });
}

class NotificationsError extends NotificationsState {
  const NotificationsError({
    required String message,
    super.notifications,
    super.unreadCount,
  }) : super(errorMessage: message);
}
