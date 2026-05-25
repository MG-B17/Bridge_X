import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/init/init_app.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/dio_factory.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/services/app_lifecycle_service.dart';
import 'package:bridge_x/core/services/connectivity_service.dart';
import 'package:bridge_x/core/theme/theme_controller.dart';
import 'package:bridge_x/feature/auth/data/remote_data/auth_remote_data.dart';
import 'package:bridge_x/feature/auth/data/repo_implement/auth_repo_implement.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:bridge_x/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
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
import 'package:bridge_x/feature/dashboard/di/dashboard_injection.dart';
import 'package:bridge_x/feature/create_team/di/create_team_injection.dart';
import 'package:bridge_x/feature/create_task/di/create_task_injection.dart';
import 'package:bridge_x/feature/projects_management/di/projects_management_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // state management
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<OnboardingProvider>(() => OnboardingProvider(sl(), sl()));
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      loginUsecase: sl(),
      registerUsecase: sl(),
      resetPasswordUsecase: sl(),
      verifyEmailUsecase: sl(),
      forgetPasswordUsecase: sl(),
      verifyPasswordUsecase: sl(),
      changePasswordUsecase: sl(),
      appState: sl(),
    ),
  );
  sl.registerLazySingleton<ScrollCubit>(()=>ScrollCubit());

  // usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepo: sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(authRepo: sl()));
  sl.registerLazySingleton<ResetPasswordUsecase>(() => ResetPasswordUsecase(authRepo: sl()));
  sl.registerLazySingleton<VerifyEmailUsecase>(() => VerifyEmailUsecase(authRepo: sl()));
  sl.registerLazySingleton<ForgetPasswordUsecase>(() => ForgetPasswordUsecase(authRepo: sl()));
  sl.registerLazySingleton<ChangePasswordUsecase>(() => ChangePasswordUsecase(authRepo: sl()));
  sl.registerLazySingleton<VerifyPasswordUsecase>(() => VerifyPasswordUsecase(authRepo: sl()));

  // repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplement(authRemoteData: sl(), networkInfo: sl(), secureStorageService: sl()),
  );

  // data sources
  sl.registerLazySingleton<AuthRemoteData>(() => AuthRemoteDataImpl(apiClient: sl()));

  //services
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl(sl()));
  sl.registerLazySingleton<AppLifecycleService>(() => AppLifecycleService());
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService(sl()));
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

  // features
  initDashboard();
  initCreateTeam();
  initCreateTask();
  initProjectsManagement();

  // other 
  sl.registerLazySingleton<AppInitializer>(()=>AppInitializer());
  sl.registerLazySingleton<AppState>(()=>AppState());
}
