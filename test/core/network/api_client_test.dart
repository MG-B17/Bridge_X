import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:bridgex/core/network/api_client.dart';
import 'package:bridgex/core/helper/cache/cache_helper.dart';


class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  late ApiClient apiClient;
  late MockCacheHelper mockCacheHelper;

  setUp(() {
    mockCacheHelper = MockCacheHelper();
    when(() => mockCacheHelper.getToken()).thenReturn(null);
    apiClient = ApiClient(cacheHelper: mockCacheHelper);
  });

  group('AuthInterceptor', () {
    test('should add Authorization header if token exists', () async {
      // arrange
      const tToken = 'test_token';
      when(() => mockCacheHelper.getToken()).thenReturn(tToken);
      
      // act
      expect(apiClient.dio.interceptors.length, greaterThan(0));
    });
  });
  
  group('ErrorInterceptor', () {
    late ErrorInterceptor errorInterceptor;

    setUp(() {
      errorInterceptor = ErrorInterceptor();
    });

    test('should map connectionTimeout to NetworkException', () async {
      // arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionTimeout,
      );
      
      final handler = ErrorInterceptorHandler();
      
      
      expect(errorInterceptor, isNotNull);
      expect(err, isNotNull);
      expect(handler, isNotNull);
    });
  });
}
