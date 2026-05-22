import 'dart:io';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryDelayMs;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelayMs = 1000,
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    var retryCount = extra['retry_count'] ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      retryCount++;
      extra['retry_count'] = retryCount;

      LoggerService.warning(
        'Retrying request: ${err.requestOptions.path} ($retryCount/$maxRetries)',
        tag: 'RetryInterceptor',
      );

      await Future.delayed(Duration(milliseconds: retryDelayMs));

      try {
        final response = await dio.request(
          err.requestOptions.path,
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
          onSendProgress: err.requestOptions.onSendProgress,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: extra,
            responseType: err.requestOptions.responseType,
            contentType: err.requestOptions.contentType,
            validateStatus: err.requestOptions.validateStatus,
            receiveTimeout: err.requestOptions.receiveTimeout,
            sendTimeout: err.requestOptions.sendTimeout,
          ),
        );
        return handler.resolve(response);
      } on DioException catch (retryErr) {
        return super.onError(retryErr, handler);
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        (err.type == DioExceptionType.unknown && err.error is SocketException);
  }
}
