import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final AuthStatus status;
  final String? message;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool agreeTerms;

  const RegisterState({
    this.status = AuthStatus.initial,
    this.message,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.agreeTerms = false,
  });

  RegisterState copyWith({
    AuthStatus? status,
    String? message,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? agreeTerms,
    bool clearMessage = false,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      agreeTerms: agreeTerms ?? this.agreeTerms,
    );
  }

  @override
  List<Object?> get props =>
      [status, message, isPasswordVisible, isConfirmPasswordVisible, agreeTerms];
}
