import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

class VerificationState extends Equatable {
  final AuthStatus status;
  final String? message;
  final int cooldownSeconds;

  const VerificationState({
    this.status = AuthStatus.initial,
    this.message,
    this.cooldownSeconds = 0,
  });

  bool get canResend => cooldownSeconds <= 0;

  VerificationState copyWith({
    AuthStatus? status,
    String? message,
    int? cooldownSeconds,
    bool clearMessage = false,
  }) {
    return VerificationState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
      cooldownSeconds: cooldownSeconds ?? this.cooldownSeconds,
    );
  }

  @override
  List<Object?> get props => [status, message, cooldownSeconds];
}
