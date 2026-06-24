import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/features/auth/data/data_source/remote_data/auth_remote_data.dart';
import 'package:bridge_x/features/auth/data/models/login_models/login_response_model.dart';
import 'package:bridge_x/features/auth/data/repo_implement/auth_repo_implement.dart';
import 'package:bridge_x/features/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/forget_password_entity/forget_password_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/register_entity/register_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/reset_password_entity/reset_password_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/change_password_entity/change_password_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteData extends Mock implements AuthRemoteData {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockCacheService extends Mock implements CacheService {}

void main() {
  late MockAuthRemoteData authRemoteData;
  late MockNetworkInfo networkInfo;
  late MockSecureStorageService secureStorageService;
  late MockCacheService cacheService;
  late AuthRepoImplement authRepoImplement;
  late LoginEntity loginEntity;
  late LoginResponseModel loginResponse;

  setUpAll(() {
    registerFallbackValue(LoginEntity(email: '', password: ''));
    registerFallbackValue(ForgetPasswordEntity(email: ''));
    registerFallbackValue(RegisterEntity(
      name: '', email: '', password: '', passwordConfirmation: '',
    ));
    registerFallbackValue(ResetPasswordEntity(
      email: '', password: '', confirmPassword: '', resetToken: '',
    ));
    registerFallbackValue(VerifyCodeEntity(email: '', code: ''));
    registerFallbackValue(ChangePasswordEntity(
      currentPassword: '', newPassword: '', passwordConfirmation: '',
    ));
  });

  setUp(() {
    loginEntity = LoginEntity(email: 'test@example.com', password: 'password123');
    loginResponse = LoginResponseModel(
      message: 'Login successful',
      token: 'test|token',
      userId: 1,
      name: 'Test',
      userName: 'testuser',
      isVerified: true,
      isProfileComplete: true,
      email: 'test@example.com',
      track: '',
      bio: '',
      exeperienceLevel: '',
      totalScore: 0,
      fcmToken: '',
      avatarUrl: '',
    );
    authRemoteData = MockAuthRemoteData();
    networkInfo = MockNetworkInfo();
    secureStorageService = MockSecureStorageService();
    cacheService = MockCacheService();
    authRepoImplement = AuthRepoImplement(
      authRemoteData: authRemoteData,
      networkInfo: networkInfo,
      secureStorageService: secureStorageService,
      cacheService: cacheService,
    );
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
  });

  group('login', () {
    test('returns LoginResultEntity on successful login', () async {
      when(() => authRemoteData.login(loginEntity: any(named: 'loginEntity')))
          .thenAnswer((_) async => loginResponse);
      when(
        () => secureStorageService.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result.isRight(), true);
      final entity = result.getOrElse(() => throw Exception());
      expect(entity.token, 'test|token');
      expect(entity.isVerified, true);
      expect(entity.isProfileComplete, true);
    });

    test('persists token and userData to secure storage', () async {
      when(() => authRemoteData.login(loginEntity: any(named: 'loginEntity')))
          .thenAnswer((_) async => loginResponse);
      when(
        () => secureStorageService.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      await authRepoImplement.login(loginEntity: loginEntity);

      verify(
        () => secureStorageService.write(key: AppKeys.authToken, value: 'test|token'),
      ).called(1);
      verify(
        () => secureStorageService.write(key: AppKeys.userDataKey, value: any(named: 'value')),
      ).called(1);
    });

    test('returns Left on ServerException', () async {
      when(() => authRemoteData.login(loginEntity: any(named: 'loginEntity')))
          .thenThrow(ServerException('Server error'));

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left on DioException', () async {
      when(() => authRemoteData.login(loginEntity: any(named: 'loginEntity')))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: '/login'),
            response: Response(
              requestOptions: RequestOptions(path: '/login'),
              statusCode: 422,
              data: {'message': 'Validation failed'},
            ),
          ));

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns NetworkFailure when offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
      verifyNever(() => authRemoteData.login(loginEntity: any(named: 'loginEntity')));
    });
  });

  group('logout', () {
    test('clears local data on successful logout', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => authRemoteData.logout()).thenAnswer((_) async {});
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result.isRight(), true);
      verify(() => secureStorageService.delete(key: AppKeys.authToken)).called(1);
      verify(() => cacheService.clearData()).called(1);
    });

    test('clears local data even on logout API error', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => authRemoteData.logout()).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/logout'),
        response: Response(
          requestOptions: RequestOptions(path: '/logout'),
          statusCode: 500,
        ),
      ));
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result.isLeft(), true);
      verify(() => secureStorageService.delete(key: AppKeys.authToken)).called(1);
      verify(() => cacheService.clearData()).called(1);
    });

    test('clears local data when offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result.isRight(), true);
      verify(() => secureStorageService.delete(key: AppKeys.authToken)).called(1);
      verify(() => cacheService.clearData()).called(1);
    });
  });
}
