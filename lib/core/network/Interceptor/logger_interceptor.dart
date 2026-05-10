import 'package:bridge_x/core/services/logger_service.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    LoggerService.debug('➡️ Request: ${options.method} ${options.path}', tag: 'LoggerInterceptor');

    if (options.queryParameters.isNotEmpty) {
      LoggerService.verbose('Query Params: ${options.queryParameters}', tag: 'LoggerInterceptor');
    }

    if (options.data != null) {
      LoggerService.verbose('Body: ${options.data}', tag: 'LoggerInterceptor');
    }

    LoggerService.verbose('Headers: ${options.headers}', tag: 'LoggerInterceptor');

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    LoggerService.debug(
      '✅ Response: ${response.statusCode} ${response.requestOptions.path}',
      tag: 'LoggerInterceptor',
    );

    LoggerService.verbose('Response Data: ${response.data}', tag: 'LoggerInterceptor');

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    LoggerService.error('❌ Error: ${err.type} - ${err.message}', tag: 'LoggerInterceptor');

    super.onError(err, handler);
  }
}
