import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bridgex/core/network/api_endpoints.dart';
import 'package:bridgex/core/helper/cache/cache_helper.dart';
import 'package:bridgex/core/error/exception.dart';
import 'package:bridgex/core/error/error_strings.dart';

class AuthInterceptor extends Interceptor {
  final CacheHelper cacheHelper;

  AuthInterceptor({required this.cacheHelper});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = cacheHelper.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      await cacheHelper.deleteToken();
      // NOTE: Navigation redirect signal to be handled by app router listening to token stream
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await cacheHelper.deleteToken();
    }
    super.onError(err, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(message: ErrorStrings.networkFailureMessage),
          ),
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: const UnauthorizedException(message: ErrorStrings.unauthorizedMessage),
            ),
          );
        } else if (statusCode != null && statusCode >= 500) {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: const ServerException(message: ErrorStrings.serverFailureMessage),
            ),
          );
        }
        break;
      default:
        break;
    }
    
    // Default fallback
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: const ServerException(message: ErrorStrings.unexpectedErrorMessage),
      ),
    );
  }
}

class ApiClient {
  final Dio dio;
  final CacheHelper cacheHelper;

  ApiClient({Dio? overrideDio, required this.cacheHelper}) : dio = overrideDio ?? Dio() {
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(AuthInterceptor(cacheHelper: cacheHelper));
    dio.interceptors.add(ErrorInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
  }

  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
