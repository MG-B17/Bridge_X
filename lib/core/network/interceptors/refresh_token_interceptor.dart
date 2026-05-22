import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  RefreshTokenInterceptor({required this.secureStorageService});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      LoggerService.warning(
        '401 Unauthorized encountered. Future token refresh logic hook goes here.',
        tag: 'RefreshTokenInterceptor',
      );
      // Future-proof placeholder: trigger refresh token endpoint, save to storage, and retry.
    }
    super.onError(err, handler);
  }
}
