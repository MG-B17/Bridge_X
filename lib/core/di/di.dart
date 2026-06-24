import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/init/init_app.dart';
import 'package:bridge_x/features/settings/presentation/controller/notification_settings_cubit.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/dio_factory.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/services/app_lifecycle_service.dart';
import 'package:bridge_x/core/services/connectivity_service.dart';
import 'package:bridge_x/core/services/supabase_service.dart';
import 'package:bridge_x/core/services/notification_services/firebase_push_notification_service.dart';
import 'package:bridge_x/core/services/notification_services/flutter_local_notification_service.dart';
import 'package:bridge_x/core/theme/theme_controller.dart';
import 'package:bridge_x/features/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:bridge_x/features/auth/di/auth_injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:dio/dio.dart';
import 'package:bridge_x/core/network/interceptors/auth_interceptor.dart';
import 'package:bridge_x/core/network/interceptors/connectivity_interceptor.dart';
import 'package:bridge_x/core/network/interceptors/logging_interceptor.dart';
import 'package:bridge_x/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:bridge_x/core/network/interceptors/retry_interceptor.dart';
import 'package:bridge_x/features/dashboard/di/dashboard_injection.dart';
import 'package:bridge_x/features/team_managment/create_team/di/create_team_injection.dart';
import 'package:bridge_x/features/team_managment/projects_management/di/projects_management_injection.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/di/team_evaluation_injection.dart';
import 'package:bridge_x/features/team_managment/task_management/di/task_management_injection.dart';
import 'package:bridge_x/features/profile/di/profile_injection.dart';
import 'package:bridge_x/features/levels/di/levels_injection.dart';
import 'package:bridge_x/features/team_managment/report/di/report_injection.dart';
import 'package:bridge_x/features/matching/di/matching_injection.dart';
import 'package:bridge_x/features/notifications/di/notifications_injection.dart';
import 'package:bridge_x/features/invitaions/di/invitaions_injection.dart';
import 'package:bridge_x/features/team_managment/my_tasks/di/my_tasks_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // state management
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<OnboardingProvider>(() => OnboardingProvider(sl<SecureStorageService>(), sl()));
  sl.registerLazySingleton<ScrollCubit>(()=>ScrollCubit());

  //services
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl(sl()));
  sl.registerLazySingleton<AppLifecycleService>(() => AppLifecycleService());
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService(sl()));
  sl.registerLazySingleton<LocalNotificationService>(
    () => FlutterLocalNotificationService(),
  );
  sl.registerLazySingleton<PushNotificationService>(
    () => FirebasePushNotificationService(localNotificationService: sl()),
  );
  sl.registerLazySingleton<SupabaseService>(() => SupabaseService());
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(
      secureStorage: const FlutterSecureStorage(
        aOptions: AndroidOptions(resetOnError: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      ),
    ),
  );

  // network
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<DioFactory>(() => DioFactory());

  // Interceptors
  sl.registerLazySingleton<ConnectivityInterceptor>(
    () => ConnectivityInterceptor(internetConnection: sl()),
  );
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(secureStorageService: sl()),
  );
  sl.registerLazySingleton<LoggingInterceptor>(
    () => LoggingInterceptor(),
  );
  sl.registerLazySingleton<RefreshTokenInterceptor>(
    () => RefreshTokenInterceptor(secureStorageService: sl()),
  );

  final dio = DioFactory.createBase();
  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<RetryInterceptor>(
    () => RetryInterceptor(dio: sl<Dio>(), maxRetries: 3),
  );

  dio.interceptors.addAll([
    sl<ConnectivityInterceptor>(),
    sl<AuthInterceptor>(),
    sl<LoggingInterceptor>(),
    sl<RetryInterceptor>(),
    sl<RefreshTokenInterceptor>(),
  ]);

  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  // core singletons (registered before features that depend on them)
  sl.registerLazySingleton<AppInitializer>(()=>AppInitializer());
  sl.registerLazySingleton<AppState>(()=>AppState());
  sl.registerFactory<NotificationSettingsCubit>(
    () => NotificationSettingsCubit(pushNotificationService: sl()),
  );

  // features
  initAuth();
  //initChatList();
  initDashboard();
  initCreateTeam();
  initProjectsManagement();
  initTaskManagement();
  initTeamEvaluation();
  initProfile();
  initLevels();
  initReport();
  initMatching();
  initNotifications();
  initInvitaions();
  initMyTasks();
}
