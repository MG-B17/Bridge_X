import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

class VerificationState extends Equatable {
  final AuthStatus status;
  final String? message;

  const VerificationState({
    this.status = AuthStatus.initial,
    this.message,
  });

  VerificationState copyWith({
    AuthStatus? status,
    String? message,
    bool clearMessage = false,
  }) {
    return VerificationState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
