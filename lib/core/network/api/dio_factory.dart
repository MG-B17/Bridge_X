import 'package:dio/dio.dart';

const String baseUrl = "https://teamwork2-main-opmxfq.free.laravel.cloud/"; 

class DioFactory {
  static Dio createBase() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        
      ),
    );
  }

  static Dio createAuthDio() {
    final dio = createBase();
    return dio;
  }

  static Dio createSecureDio({
    required Interceptor authInterceptor,
    required Interceptor errorInterceptor,
    required Interceptor loggerInterceptor,
  }) {
    final dio = createBase();

    dio.interceptors.addAll([
      authInterceptor,
      errorInterceptor,
      loggerInterceptor,
    ]);

    return dio;
  }
}
