import 'package:bridge_x/core/error/failure.dart';

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.message,
    super.statusCode = 401,
  });
}
