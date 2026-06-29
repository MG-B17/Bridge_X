import 'dart:async';
import 'package:bridge_x/features/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/resend_verify_usecase.dart';
import 'package:bridge_x/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit({
    required this.verifyEmailUsecase,
    required this.resendVerifyUseCase,
  }) : super(VerificationState());

  final VerifyEmailUsecase verifyEmailUsecase;
  final ResendVerifyUseCase resendVerifyUseCase;

  Timer? _cooldownTimer;
  int _cooldownRemaining = 0;

  @override
  Future<void> close() {
    _cooldownTimer?.cancel();
    return super.close();
  }

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

  void startResendCooldown() {
    emit(state.copyWith(cooldownSeconds: 30, clearMessage: true));
    _startCooldown();
  }

  Future<void> resendVerify({required String email}) async {
    if (!state.canResend) return;

    final result = await resendVerifyUseCase(email: email);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) {
        emit(state.copyWith(cooldownSeconds: 30, clearMessage: true));
        _startCooldown();
      },
    );
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _cooldownRemaining = 30;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _cooldownRemaining--;
      if (_cooldownRemaining <= 0) {
        timer.cancel();
        emit(state.copyWith(cooldownSeconds: 0));
      } else {
        emit(state.copyWith(cooldownSeconds: _cooldownRemaining));
      }
    });
  }
}
