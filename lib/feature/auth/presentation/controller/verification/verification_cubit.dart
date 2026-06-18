import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/resend_verify_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit({
    required this.verifyEmailUsecase,
    required this.resendVerifyUseCase,
  }) : super(VerificationState());

  final VerifyEmailUsecase verifyEmailUsecase;
  final ResendVerifyUseCase resendVerifyUseCase;

  Future<void> verifyEmail({required String email, required String code}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await verifyEmailUsecase(
      verifyCodeEntity: VerifyCodeEntity(email: email, code: code),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }

  Future<void> resendVerify({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await resendVerifyUseCase(email: email);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) => emit(state.copyWith(status: AuthStatus.success, message: success)),
    );
  }
}
