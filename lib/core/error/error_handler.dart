import 'package:bridge_x/core/error/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler {

  static Failure handle(DioException error) {

    final response = error.response;

    final statusCode = response?.statusCode;

    final data = response?.data;

    final message =
        data?['message'] ??
        'Something went wrong';

    switch (statusCode) {

      case 401:
        return AuthFailure(
          message: message,
          statusCode: 401,
        );

      case 422:
        return ValidationFailure(
          message: message,
          statusCode: 422,
          errors: data?['errors'],
        );

      case 500:
        return ServerFailure(
          message: message,
          statusCode: 500,
        );

      default:
        return ServerFailure(
          message: message,
          statusCode: statusCode,
        );
    }
  }
}
