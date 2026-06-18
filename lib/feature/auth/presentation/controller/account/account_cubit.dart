import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:bridge_x/feature/auth/data/data_source/local_data/auth_local_data_source.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/logout_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/account/account_state.dart';
import 'package:bridge_x/feature/profile/domain/usecases/soft_delete_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.changePasswordUsecase,
    required this.logoutUseCase,
    required this.softDeleteProfileUseCase,
    required this.appState,
    required this.authLocalDataSource,
    required this.pushNotificationService,
  }) : super(AccountState());

  final ChangePasswordUsecase changePasswordUsecase;
  final LogoutUseCase logoutUseCase;
  final SoftDeleteProfileUseCase softDeleteProfileUseCase;
  final AppState appState;
  final AuthLocalDataSource authLocalDataSource;
  final PushNotificationService pushNotificationService;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        action: AuthAction.changePassword,
      ),
    );
    final result = await changePasswordUsecase(
      changePasswordEntity: ChangePasswordEntity(
        currentPassword: currentPassword,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, message: failure.message),
      ),
      (success) =>
          emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.logout));
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, message: failure.message),
      ),
      (_) {
        _resetAppState();
        pushNotificationService.refreshToken();
        emit(state.copyWith(status: AuthStatus.success));
      },
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
        ),
      ),
    );
  }

  Future<void> completeSoftDeleteSignOut() async {
    await _clearLocalSession();
    _resetAppState();
    await pushNotificationService.refreshToken();
  }

  Future<void> _clearLocalSession() async {
    await authLocalDataSource.clearSession();
  }

  void _resetAppState() {
    appState.isLoggedIn = false;
    appState.isVerified = false;
    appState.trackSelectionCompleted = false;
    appState.isProfileComplete = false;
    appState.username = null;
  }
}
