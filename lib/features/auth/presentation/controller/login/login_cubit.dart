import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/features/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/login/login_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUsecase,
    required this.appState,
    required this.pushNotificationService,
  }) : super(LoginState());

  final LoginUsecase loginUsecase;
  final AppState appState;
  final PushNotificationService pushNotificationService;

  Future<void> login({required String email, required String password}) async {
    final token = pushNotificationService.fcmToken;
    if (kDebugMode) {
      LoggerService.info('FCM token for login: $token', tag: 'LoginCubit');
    }
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await loginUsecase(
      loginEntity: LoginEntity(email: email, password: password, fcmToken: token),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (entity) {
        appState.batchUpdate(
          isLoggedIn: true,
          isVerified: entity.isVerified,
          isProfileComplete: entity.isProfileComplete,
          userData: UserDataModel(
            userId: entity.userId.toString(),
            userName: entity.userName,
            userEmail: entity.email,
            isVerified: entity.isVerified,
            isProfileComplete: entity.isProfileComplete,
          ),
        );
        emit(state.copyWith(status: AuthStatus.success, message: AuthStrings.loginSuccess));
      },
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}
