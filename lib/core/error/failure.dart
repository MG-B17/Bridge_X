import 'package:equatable/equatable.dart';

export 'server_failure.dart';
export 'cache_failure.dart';
export 'network_failure.dart';
export 'unauthorized_failure.dart';

abstract class Failure extends Equatable {

  final String message;

  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
      ];
}



class AuthFailure extends Failure {

  const AuthFailure({
    required super.message,
    super.statusCode,
  });
}


class ValidationFailure extends Failure {

  final Map<String, dynamic>? errors;

  const ValidationFailure({
    required super.message,
    super.statusCode,
    this.errors,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
        errors,
      ];
}

