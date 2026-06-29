import 'package:bridge_x/features/auth/domain/entity/register_entity/register_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUsecase}) : super(RegisterState());

  final RegisterUsecase registerUsecase;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await registerUsecase(
      registerEntity: RegisterEntity(
        name: name,
        email: email,
        password: password,
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

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void toggleAgreeTerms(bool? val) {
    emit(state.copyWith(agreeTerms: val ?? false));
  }
}
