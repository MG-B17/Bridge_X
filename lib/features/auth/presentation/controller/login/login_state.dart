import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final AuthStatus status;
  final String? message;
  final bool isPasswordVisible;

  const LoginState({
    this.status = AuthStatus.initial,
    this.message,
    this.isPasswordVisible = false,
  });

  LoginState copyWith({
    AuthStatus? status,
    String? message,
    bool? isPasswordVisible,
    bool clearMessage = false,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [status, message, isPasswordVisible];
}
