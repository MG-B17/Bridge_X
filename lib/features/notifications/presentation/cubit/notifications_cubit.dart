import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/notifications/domain/entities/notification_entity.dart';
import 'package:bridge_x/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/get_unread_count_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/mark_all_notifications_as_read_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/mark_notification_as_read_usecase.dart';
import 'package:bridge_x/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllNotificationsAsReadUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markNotificationAsReadUseCase,
    required this.markAllNotificationsAsReadUseCase,
    required this.getUnreadCountUseCase,
  }) : super(const NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(
      NotificationsLoading(
        notifications: state.notifications,
        unreadCount: state.unreadCount,
      ),
    );

    final result = await getNotificationsUseCase(NoParams());
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: state.notifications,
          unreadCount: state.unreadCount,
        ),
      ),
      (notifications) => emit(
        NotificationsLoaded(
          notifications: notifications,
          unreadCount: state.unreadCount,
        ),
      ),
    );
  }

  Future<void> fetchUnreadCount() async {
    final result = await getUnreadCountUseCase(NoParams());
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        NotificationsError(
          message: failure.message,
          notifications: state.notifications,
          unreadCount: state.unreadCount,
        ),
      ),
      (unreadCount) => emit(
        NotificationsLoaded(
          notifications: state.notifications,
          unreadCount: unreadCount.unreadCount,
          isActionLoading: state.isActionLoading,
        ),
      ),
    );
  }

  Future<bool> markAsRead(String id) async {
    if (id.isEmpty) return true;

    final notification = _findNotification(id);
    if (notification == null || notification.isRead) return true;

    emit(
      NotificationsLoaded(
        notifications: state.notifications,
        unreadCount: state.unreadCount,
        isActionLoading: true,
      ),
    );

    final result = await markNotificationAsReadUseCase(
      MarkNotificationAsReadParams(notificationId: id),
    );
    if (isClosed) return false;

    final success = result.fold((failure) {
      emit(
        NotificationsError(
          message: failure.message,
          notifications: state.notifications,
          unreadCount: state.unreadCount,
        ),
      );
      return false;
    }, (_) => true);

    if (!success) return false;

    emit(
      NotificationsLoaded(
        notifications: _markNotificationReadLocally(id),
        unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
      ),
    );
    await fetchUnreadCount();
    return true;
  }

  Future<void> markAllAsRead() async {
    emit(
      NotificationsLoaded(
        notifications: state.notifications,
        unreadCount: state.unreadCount,
        isActionLoading: true,
      ),
    );

    final result = await markAllNotificationsAsReadUseCase(NoParams());
    if (isClosed) return;

    await result.fold(
      (failure) async {
        emit(
          NotificationsError(
            message: failure.message,
            notifications: state.notifications,
            unreadCount: state.unreadCount,
          ),
        );
      },
      (_) async {
        emit(
          NotificationsLoaded(
            notifications: state.notifications
                .map(
                  (notification) => notification.copyWith(
                    isRead: true,
                    readAt:
                        notification.readAt ??
                        DateTime.now().toUtc().toIso8601String(),
                  ),
                )
                .toList(),
            unreadCount: 0,
          ),
        );
        await fetchUnreadCount();
        await fetchNotifications();
      },
    );
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications();
    if (state is NotificationsError && state.notifications.isEmpty) return;
    await fetchUnreadCount();
  }

  NotificationEntity? _findNotification(String id) {
    for (final notification in state.notifications) {
      if (notification.id == id) return notification;
    }
    return null;
  }

  List<NotificationEntity> _markNotificationReadLocally(String id) {
    final now = DateTime.now().toUtc().toIso8601String();
    return state.notifications
        .map(
          (notification) => notification.id == id
              ? notification.copyWith(
                  isRead: true,
                  readAt: notification.readAt ?? now,
                )
              : notification,
        )
        .toList();
  }
}
