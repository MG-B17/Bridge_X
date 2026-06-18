import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/feature/auth/data/data_source/remote_data/auth_remote_data.dart';
import 'package:bridge_x/feature/auth/data/models/login_models/login_response_model.dart';
import 'package:bridge_x/feature/auth/data/models/reset_password_models/reset_password_response_model.dart';
import 'package:bridge_x/feature/auth/data/repo_implement/auth_repo_implement.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_password_entity/verify_password_result_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteData extends Mock implements AuthRemoteData {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSecureStorageService extends Mock
    implements SecureStorageService {}

class MockCacheService extends Mock implements CacheService {}

void main() {
  late MockAuthRemoteData authRemoteData;
  late MockNetworkInfo networkInfo;
  late MockSecureStorageService secureStorageService;
  late MockCacheService cacheService;
  late AuthRepoImplement authRepoImplement;

  setUpAll(() {
    registerFallbackValue(LoginEntity(email: '', password: ''));
    registerFallbackValue(RegisterEntity(
      name: '',
      email: '',
      password: '',
      passwordConfirmation: '',
    ));
    registerFallbackValue(ForgetPasswordEntity(email: ''));
    registerFallbackValue(VerifyCodeEntity(email: '', code: ''));
    registerFallbackValue(ResetPasswordEntity(
      email: '',
      password: '',
      confirmPassword: '',
      resetToken: '',
    ));
    registerFallbackValue(AppKeys.authToken);
    registerFallbackValue(AppKeys.userId);
    registerFallbackValue(AppKeys.userName);
  });

  setUp(() {
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
    final loginEntity = LoginEntity(email: 'test@example.com', password: 'pass123');
    final loginResponse = LoginResponseModel(
      token: 'token_abc',
      userId: 42,
      userName: 'TestUser',
      isVerified: true,
      isProfileComplete: false,
    );

    test('returns Right with mapped entity on success', () async {
      when(
        () => authRemoteData.login(loginEntity: any(named: 'loginEntity')),
      ).thenAnswer((_) async => loginResponse);
      when(
        () => secureStorageService.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async => Future.value());

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result, isA<Right<Failure, LoginResultEntity>>());
      final entity = result.getOrElse(() => throw 'unexpected');
      expect(entity.token, 'token_abc');
      expect(entity.userId, 42);
      expect(entity.userName, 'TestUser');
      expect(entity.isVerified, true);
      expect(entity.isProfileComplete, false);

      verify(
        () => secureStorageService.write(key: AppKeys.authToken, value: 'token_abc'),
      ).called(1);
      verify(
        () => secureStorageService.write(key: AppKeys.userId, value: '42'),
      ).called(1);
      verify(
        () => secureStorageService.write(key: AppKeys.userName, value: 'TestUser'),
      ).called(1);
    });

    test('returns Left with ServerFailure on ServerException', () async {
      when(
        () => authRemoteData.login(loginEntity: any(named: 'loginEntity')),
      ).thenThrow(ServerException('Server error'));

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result, isA<Left<Failure, LoginResultEntity>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server error');
        },
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left with network failure when offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result, isA<Left<Failure, LoginResultEntity>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
        },
        (_) => fail('Expected Left'),
      );
    });

    test('handles null userName with fallback', () async {
      final responseNoName = LoginResponseModel(
        token: 'token',
        userId: 7,
        isVerified: false,
        isProfileComplete: true,
      );
      when(
        () => authRemoteData.login(loginEntity: any(named: 'loginEntity')),
      ).thenAnswer((_) async => responseNoName);
      when(
        () => secureStorageService.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async => Future.value());

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      final entity = result.getOrElse(() => throw 'unexpected');
      expect(entity.userName, isNull);
      verify(
        () => secureStorageService.write(key: AppKeys.userName, value: 'User 7'),
      ).called(1);
    });
  });

  group('register', () {
    final registerEntity = RegisterEntity(
      name: 'Test',
      email: 'test@example.com',
      password: 'pass123',
      passwordConfirmation: 'pass123',
    );

    test('returns Right with message on success', () async {
      when(
        () => authRemoteData.register(registerEntity: any(named: 'registerEntity')),
      ).thenAnswer((_) async => 'Registration successful');

      final result = await authRepoImplement.register(registerEntity: registerEntity);

      expect(result, isA<Right<Failure, String>>());
      expect(result.getOrElse(() => ''), 'Registration successful');
    });

    test('returns Left on network failure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await authRepoImplement.register(registerEntity: registerEntity);

      expect(result, isA<Left<Failure, String>>());
    });
  });

  group('forgetPassword', () {
    final entity = ForgetPasswordEntity(email: 'test@example.com');

    test('returns Right on success', () async {
      when(
        () => authRemoteData.forgetPassword(
          forgetPasswordEntity: any(named: 'forgetPasswordEntity'),
        ),
      ).thenAnswer((_) async => 'Reset email sent');

      final result = await authRepoImplement.forgetPassword(forgetPasswordEntity: entity);

      expect(result, isA<Right<Failure, String>>());
      expect(result.getOrElse(() => ''), 'Reset email sent');
    });

    test('returns Left on ServerException', () async {
      when(
        () => authRemoteData.forgetPassword(
          forgetPasswordEntity: any(named: 'forgetPasswordEntity'),
        ),
      ).thenThrow(ServerException('Email not found'));

      final result = await authRepoImplement.forgetPassword(forgetPasswordEntity: entity);

      expect(result, isA<Left<Failure, String>>());
      result.fold(
        (failure) => expect(failure.message, 'Email not found'),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left when offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await authRepoImplement.forgetPassword(forgetPasswordEntity: entity);

      expect(result, isA<Left<Failure, String>>());
    });
  });

  group('verifyPassword', () {
    final entity = VerifyCodeEntity(email: 'test@example.com', code: '123456');

    test('returns Right with mapped entity on success', () async {
      final response = ResetPasswordResponseModel(
        message: 'Code verified',
        token: 'reset_token_abc',
        expiresAt: '2026-01-01T00:00:00Z',
      );
      when(
        () => authRemoteData.verifyPassword(
          verifyPasswordEntity: any(named: 'verifyPasswordEntity'),
        ),
      ).thenAnswer((_) async => response);

      final result = await authRepoImplement.verifyPassword(
        verifyPasswordEntity: entity,
      );

      expect(result, isA<Right<Failure, VerifyPasswordResultEntity>>());
      result.fold(
        (_) => fail('Expected Right'),
        (entity) {
          expect(entity.resetToken, 'reset_token_abc');
          expect(entity.message, 'Code verified');
          expect(entity.expiresAt, '2026-01-01T00:00:00Z');
        },
      );
    });

    test('returns Left on ServerException', () async {
      when(
        () => authRemoteData.verifyPassword(
          verifyPasswordEntity: any(named: 'verifyPasswordEntity'),
        ),
      ).thenThrow(ServerException('Invalid code'));

      final result = await authRepoImplement.verifyPassword(
        verifyPasswordEntity: entity,
      );

      expect(result, isA<Left<Failure, VerifyPasswordResultEntity>>());
    });
  });

  group('resetPassword', () {
    final entity = ResetPasswordEntity(
      email: 'test@example.com',
      password: 'newPass123',
      confirmPassword: 'newPass123',
      resetToken: 'token_abc',
    );

    test('returns Right on success', () async {
      when(
        () => authRemoteData.resetPassword(
          resetPasswordEntity: any(named: 'resetPasswordEntity'),
        ),
      ).thenAnswer((_) async => 'Password reset');

      final result = await authRepoImplement.resetPassword(resetPasswordEntity: entity);

      expect(result, isA<Right<Failure, String>>());
    });
  });

  group('verifyEmail', () {
    final entity = VerifyCodeEntity(email: 'test@example.com', code: '123456');

    test('returns Right on success', () async {
      when(
        () => authRemoteData.verifyEmail(verifyCodeEntity: any(named: 'verifyCodeEntity')),
      ).thenAnswer((_) async => 'Email verified');

      final result = await authRepoImplement.verifyEmail(verifyCodeEntity: entity);

      expect(result, isA<Right<Failure, String>>());
    });
  });

  group('DioException handling', () {
    final loginEntity = LoginEntity(email: 'test@example.com', password: 'pass');

    test('returns Left with mapped Failure on DioException', () async {
      when(
        () => authRemoteData.login(loginEntity: any(named: 'loginEntity')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/login'),
            statusCode: 422,
            data: {'message': 'Validation error'},
          ),
        ),
      );

      final result = await authRepoImplement.login(loginEntity: loginEntity);

      expect(result, isA<Left<Failure, LoginResultEntity>>());
    });
  });

  group('logout', () {
    test('clears local data even when API succeeds', () async {
      when(() => authRemoteData.logout()).thenAnswer((_) async => Future.value());
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async => Future.value());
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result, isA<Right<Failure, void>>());
      verify(() => cacheService.clearData()).called(1);
    });

    test('clears local data even on ServerException', () async {
      when(() => authRemoteData.logout()).thenThrow(ServerException('API error'));
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async => Future.value());
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result, isA<Left<Failure, void>>());
      verify(() => cacheService.clearData()).called(1);
    });

    test('returns Right when offline (clears local data)', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => secureStorageService.delete(key: any(named: 'key')),
      ).thenAnswer((_) async => Future.value());
      when(() => cacheService.clearData()).thenAnswer((_) async => true);

      final result = await authRepoImplement.logout();

      expect(result, isA<Right<Failure, void>>());
      verify(() => cacheService.clearData()).called(1);
    });
  });
}
