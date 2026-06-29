import 'package:bridge_x/core/error/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    String? message,
    super.statusCode,
  }) : super(message: message ?? 'An unexpected error occurred');
}
