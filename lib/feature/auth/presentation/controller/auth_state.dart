import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:equatable/equatable.dart';

// Sentinel to distinguish "not provided" from explicit null
const Object _undefined = Object();

class AuthState extends Equatable {
  final AuthStatus status;
  final String? message;
  final String? resetToken;
  final AuthAction? action;

  const AuthState({
    this.status = AuthStatus.initial,
    this.message,
    this.resetToken,
    this.action,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthAction? action,
    Object? message = _undefined,
    Object? resetToken = _undefined,
  }) {
    return AuthState(
      status: status ?? this.status,
      action: action ?? this.action,
      message: message == _undefined ? this.message : message as String?,
      resetToken: resetToken == _undefined ? this.resetToken : resetToken as String?,
    );
  }

  @override
  List<Object?> get props => [status, message, resetToken, action];
}
