import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:bridge_x/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:bridge_x/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:bridge_x/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/get_unread_count_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/mark_all_notifications_as_read_usecase.dart';
import 'package:bridge_x/features/notifications/domain/usecases/mark_notification_as_read_usecase.dart';
import 'package:bridge_x/features/notifications/presentation/cubit/notifications_cubit.dart';

void initNotifications() {
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<NotificationsRepository>(
    () =>
        NotificationsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<MarkNotificationAsReadUseCase>(
    () => MarkNotificationAsReadUseCase(repository: sl()),
  );
  sl.registerLazySingleton<MarkAllNotificationsAsReadUseCase>(
    () => MarkAllNotificationsAsReadUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetUnreadCountUseCase>(
    () => GetUnreadCountUseCase(repository: sl()),
  );

  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(
      getNotificationsUseCase: sl(),
      markNotificationAsReadUseCase: sl(),
      markAllNotificationsAsReadUseCase: sl(),
      getUnreadCountUseCase: sl(),
    ),
  );
}
