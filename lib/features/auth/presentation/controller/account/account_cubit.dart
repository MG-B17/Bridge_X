import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/features/auth/domain/entity/change_password_entity/change_password_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/account/account_state.dart';
import 'package:bridge_x/features/profile/domain/usecases/soft_delete_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.changePasswordUsecase,
    required this.logoutUseCase,
    required this.softDeleteProfileUseCase,
    required this.appState,
    required this.pushNotificationService,
  }) : super(AccountState());

  final ChangePasswordUsecase changePasswordUsecase;
  final LogoutUseCase logoutUseCase;
  final SoftDeleteProfileUseCase softDeleteProfileUseCase;
  final AppState appState;

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
    if (state.status == AuthStatus.loading && state.action == AuthAction.logout) return;
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
    await logoutUseCase();
    _resetAppState();
    pushNotificationService.refreshToken();
  }

  void _resetAppState() {
    appState.isLoggedIn = false;
    appState.userData = null;
  }
}
