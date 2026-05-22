import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  AuthInterceptor({required this.secureStorageService});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorageService.read(key: AppKeys.authToken);

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
