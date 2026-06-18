import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/notification_services/firebase_push_notification_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/feature/profile/domain/usecases/soft_delete_profile_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.resetPasswordUsecase,
    required this.verifyEmailUsecase,
    required this.forgetPasswordUsecase,
    required this.changePasswordUsecase,
    required this.verifyPasswordUsecase,
    required this.completeProfileUseCase,
    required this.appState,
    required this.pushNotificationService,
    required this.softDeleteProfileUseCase,
    required this.secureStorageService,
    required this.cacheService,
  }) : super(AuthState());

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final VerifyEmailUsecase verifyEmailUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final VerifyPasswordUsecase verifyPasswordUsecase;
  final CompleteProfileUseCase completeProfileUseCase;
  final AppState appState;
  final PushNotificationService pushNotificationService;
  final SoftDeleteProfileUseCase softDeleteProfileUseCase;
  final SecureStorageService secureStorageService;
  final CacheService cacheService;

  Future<void> login({required String email, required String password}) async {
    final token = pushNotificationService.fcmToken;
    if (kDebugMode) {
      LoggerService.info('FCM token for login: $token', tag: 'AuthCubit');
    }
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.login));
    final result = await loginUsecase(
      loginEntity: LoginEntity(email: email, password: password, fcmToken: token),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) {
        appState.isLoggedIn = true;
        emit(state.copyWith(status: AuthStatus.success, message: success));
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.register));
    final result = await registerUsecase(
      registerEntity: RegisterEntity(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> verifyEmail({required String email, required String code}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.verifyEmail));
    final result = await verifyEmailUsecase(
      verifyCodeEntity: VerifyCodeEntity(email: email, code: code),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.forgetPassword));
    final result = await forgetPasswordUsecase(
      forgetPasswordEntity: ForgetPasswordEntity(email: email),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> verifyPassword({required String email, required String code}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.verifyPassword));
    final result = await verifyPasswordUsecase(
      verifyPasswordEntity: VerifyCodeEntity(email: email, code: code),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (entity) => emit(
        state.copyWith(
          status: AuthStatus.success,
          message: entity.message,
          resetToken: entity.resetToken,
        ),
      ),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.resetPassword));
    final result = await resetPasswordUsecase(
      resetPasswordEntity: ResetPasswordEntity(
        email: email,
        password: newPassword,
        confirmPassword: passwordConfirmation,
        resetToken: code,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.changePassword));
    final result = await changePasswordUsecase(
      changePasswordEntity: ChangePasswordEntity(
        currentPassword: currentPassword,
        newPassword: newPassword,
        oldPassword: passwordConfirmation,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.logout));
    final result = await verifyPasswordUsecase.authRepo.logout();
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (_) {
        appState.isLoggedIn = false;
        pushNotificationService.refreshToken();
        emit(state.copyWith(status: AuthStatus.success, message: AppFeedbackMessages.logoutSuccess));
      },
    );
  }

  Future<void> completeProfile({
    required String track,
    required String experienceLevel,
  }) async {
    if (state.status == AuthStatus.loading &&
        state.action == AuthAction.completeProfile) {
      return;
    }
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.completeProfile));
    final result = await completeProfileUseCase(
      track: track,
      experienceLevel: experienceLevel,
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (_) => emit(state.copyWith(status: AuthStatus.success, message: 'Profile completed')),
    );
  }

  Future<void> softDeleteProfile() async {
    if (state.status == AuthStatus.loading &&
        state.action == AuthAction.softDeleteProfile) {
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        action: AuthAction.softDeleteProfile,
        message: null,
      ),
    );

    final result = await softDeleteProfileUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.error,
          action: AuthAction.softDeleteProfile,
          message: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: AuthStatus.success,
          action: AuthAction.softDeleteProfile,
          message: 'Account deleted successfully',
        ),
      ),
    );
  }

  Future<void> completeSoftDeleteSignOut() async {
    await _clearLocalSession();
    appState.isLoggedIn = false;
    await pushNotificationService.refreshToken();
  }

  Future<void> _clearLocalSession() async {
    await secureStorageService.delete(key: AppKeys.authToken);
    await secureStorageService.delete(key: AppKeys.userId);
    await secureStorageService.delete(key: AppKeys.userName);
    await cacheService.clearData();
  }
}
