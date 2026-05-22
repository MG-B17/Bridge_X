import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityInterceptor extends Interceptor {
  final InternetConnection internetConnection;

  ConnectivityInterceptor({required this.internetConnection});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection available',
          type: DioExceptionType.connectionError,
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
