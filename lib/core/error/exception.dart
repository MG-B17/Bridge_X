import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  const ServerException({required this.message});

  @override
  List<Object?> get props => [message];
}

class CacheException extends Equatable implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkException extends Equatable implements Exception {
  final String message;
  const NetworkException({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnauthorizedException extends Equatable implements Exception {
  final String message;
  const UnauthorizedException({required this.message});

  @override
  List<Object?> get props => [message];
}
