import 'package:bridge_x/core/error/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}
