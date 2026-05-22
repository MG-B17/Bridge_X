import 'package:bridge_x/core/services/logger_service.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerService.debug(
      '➡️ Request: ${options.method} ${options.uri}',
      tag: 'LoggingInterceptor',
    );
    if (options.queryParameters.isNotEmpty) {
      LoggerService.verbose(
        'Query Parameters: ${options.queryParameters}',
        tag: 'LoggingInterceptor',
      );
    }
    if (options.data != null) {
      LoggerService.verbose(
        'Request Body: ${options.data}',
        tag: 'LoggingInterceptor',
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LoggerService.info(
      '✅ Response: [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.path}',
      tag: 'LoggingInterceptor',
    );
    LoggerService.verbose(
      'Response Body: ${response.data}',
      tag: 'LoggingInterceptor',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerService.error(
      '❌ Error: [${err.response?.statusCode ?? 'No Status'}] ${err.requestOptions.method} ${err.requestOptions.path}\nMessage: ${err.message}',
      exception: err.error,
      stackTrace: err.stackTrace,
      tag: 'LoggingInterceptor',
    );
    super.onError(err, handler);
  }
}
