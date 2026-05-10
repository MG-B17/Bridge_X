import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.resetPasswordUsecase,
    required this.verifyEmailUsecase,
    required this.forgetPasswordUsecase,
    required this.changePasswordUsecase,
    required this.verifyPasswordUsecase
  }) : super(AuthState());

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final VerifyEmailUsecase verifyEmailUsecase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final VerifyPasswordUsecase verifyPasswordUsecase;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.login));
    final result = await loginUsecase(
      loginEntity: LoginEntity(email: email, password: password),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> register({required String name, required String email, required String password, required String passwordConfirmation}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.register));
    final result = await registerUsecase(registerEntity: RegisterEntity(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> verifyEmail({required String email, required String code}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.verifyEmail));
    final result = await verifyEmailUsecase(verifyCodeEntity: VerifyCodeEntity(email: email, code: code));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }


  Future<void> forgetPassword({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.forgetPassword));
    final result = await forgetPasswordUsecase(forgetPasswordEntity: ForgetPasswordEntity(email: email));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> verifyPassword({required String email, required String code}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.verifyPassword));
    final result = await verifyPasswordUsecase(verifyPasswordEntity: VerifyCodeEntity(email: email, code: code));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success.message)),
    );
  }


  Future<void> resetPassword({required String email, required String code, required String newPassword, required String passwordConfirmation}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.resetPassword));
    final result = await resetPasswordUsecase(resetPasswordEntity: ResetPasswordEntity(email: email, password: newPassword, confirmPassword: passwordConfirmation,resetToken: code));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> changePassword({required String currentPassword, required String newPassword, required String passwordConfirmation}) async {
    emit(state.copyWith(status: AuthStatus.loading, action: AuthAction.changePassword));
    final result = await changePasswordUsecase(changePasswordEntity: ChangePasswordEntity(currentPassword: currentPassword, newPassword: newPassword, oldPassword: passwordConfirmation));
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }
  
}
