import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

class PasswordResetState extends Equatable {
  final AuthStatus status;
  final String? message;
  final String? resetToken;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const PasswordResetState({
    this.status = AuthStatus.initial,
    this.message,
    this.resetToken,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  PasswordResetState copyWith({
    AuthStatus? status,
    String? message,
    String? resetToken,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool clearMessage = false,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
      resetToken: resetToken ?? this.resetToken,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props =>
      [status, message, resetToken, isPasswordVisible, isConfirmPasswordVisible];
}
