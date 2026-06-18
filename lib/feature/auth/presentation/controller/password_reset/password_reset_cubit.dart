import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/password_reset/password_reset_state.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit({
    required this.forgetPasswordUsecase,
    required this.verifyPasswordUsecase,
    required this.resetPasswordUsecase,
  }) : super(PasswordResetState());

  final ForgetPasswordUsecase forgetPasswordUsecase;
  final VerifyPasswordUsecase verifyPasswordUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  Future<void> forgetPassword({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await forgetPasswordUsecase(
      forgetPasswordEntity: ForgetPasswordEntity(email: email),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, message: failure.message),
      ),
      (success) =>
          emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> verifyPassword({
    required String email,
    required String code,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await verifyPasswordUsecase(
      verifyPasswordEntity: VerifyCodeEntity(email: email, code: code),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, message: failure.message),
      ),
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
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await resetPasswordUsecase(
      resetPasswordEntity: ResetPasswordEntity(
        email: email,
        password: newPassword,
        confirmPassword: passwordConfirmation,
        resetToken: code,
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

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }
}
