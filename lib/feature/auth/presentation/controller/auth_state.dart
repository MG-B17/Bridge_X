import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AuthStatus status;

  final String? message;

  final AuthAction? action;

  const AuthState({
    this.status = AuthStatus.initial,
    this.message,
    this.action,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? message,

    AuthAction? action,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      action: action ?? this.action,
    );
  }
  
  @override
  List<Object?> get props => [status, message, action];
}

