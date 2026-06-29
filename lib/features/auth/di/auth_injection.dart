import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/auth/data/data_source/local_data/auth_local_data_source.dart';
import 'package:bridge_x/features/auth/data/data_source/remote_data/auth_remote_data.dart';
import 'package:bridge_x/features/auth/data/repo_implement/auth_repo_implement.dart';
import 'package:bridge_x/features/auth/domain/repo/auth_repo.dart';
import 'package:bridge_x/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/resend_verify_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/account/account_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/login/login_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/password_reset/password_reset_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_cubit.dart';
import 'package:bridge_x/features/profile/domain/usecases/soft_delete_profile_usecase.dart';

void initAuth() {
  // Usecases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepo: sl()));
  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<VerifyEmailUsecase>(
    () => VerifyEmailUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<ForgetPasswordUsecase>(
    () => ForgetPasswordUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<VerifyPasswordUsecase>(
    () => VerifyPasswordUsecase(authRepo: sl()),
  );
  sl.registerLazySingleton<CompleteProfileUseCase>(
    () => CompleteProfileUseCase(authRepo: sl()),
  );
  sl.registerLazySingleton<ResendVerifyUseCase>(
    () => ResendVerifyUseCase(authRepo: sl()),
  );
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(authRepo: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplement(
      authRemoteData: sl(),
      networkInfo: sl(),
      secureStorageService: sl(),
      cacheService: sl(),
    ),
  );

  // Local data source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      secureStorageService: sl(),
      cacheService: sl(),
    ),
  );

  // Remote data source
  sl.registerLazySingleton<AuthRemoteData>(
    () => AuthRemoteDataImpl(apiClient: sl()),
  );

  // Cubits
  sl.registerFactory<AccountCubit>(
    () => AccountCubit(
      changePasswordUsecase: sl(),
      logoutUseCase: sl(),
      softDeleteProfileUseCase: sl<SoftDeleteProfileUseCase>(),
      appState: sl(),

      pushNotificationService: sl(),
    ),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUsecase: sl(),
      appState: sl(),
      pushNotificationService: sl(),
      saveUserChatData: sl(),
    ),
  );

  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUsecase: sl()),
  );

  sl.registerFactory<PasswordResetCubit>(
    () => PasswordResetCubit(
      forgetPasswordUsecase: sl(),
      verifyPasswordUsecase: sl(),
      resetPasswordUsecase: sl(),
    ),
  );

  sl.registerFactory<VerificationCubit>(
    () => VerificationCubit(
      verifyEmailUsecase: sl(),
      resendVerifyUseCase: sl(),
    ),
  );

  sl.registerFactory<CompleteProfileCubit>(
    () => CompleteProfileCubit(
      completeProfileUseCase: sl(),
      appState: sl(),
    ),
  );
}
