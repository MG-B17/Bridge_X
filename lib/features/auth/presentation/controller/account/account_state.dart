import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:equatable/equatable.dart';

const Object _undefined = Object();

class AccountState extends Equatable {
  final AuthStatus status;
  final String? message;
  final AuthAction? action;

  const AccountState({
    this.status = AuthStatus.initial,
    this.message,
    this.action,
  });

  AccountState copyWith({
    AuthStatus? status,
    AuthAction? action,
    Object? message = _undefined,
  }) {
    return AccountState(
      status: status ?? this.status,
      action: action ?? this.action,
      message: message == _undefined ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => [status, message, action];
}
