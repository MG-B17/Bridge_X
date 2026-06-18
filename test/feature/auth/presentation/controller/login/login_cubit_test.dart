import 'package:bloc_test/bloc_test.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity/login_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/login/login_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/login/login_state.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:bridge_x/feature/auth/utils/auth_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockAppState extends Mock implements AppState {}

class MockPushNotificationService extends Mock
    implements PushNotificationService {}

void main() {
  late MockLoginUsecase loginUsecase;
  late MockAppState appState;
  late MockPushNotificationService pushNotificationService;
  late LoginCubit loginCubit;

  setUpAll(() {
    registerFallbackValue(LoginEntity(email: '', password: ''));
  });

  setUp(() {
    loginUsecase = MockLoginUsecase();
    appState = MockAppState();
    pushNotificationService = MockPushNotificationService();
    loginCubit = LoginCubit(
      loginUsecase: loginUsecase,
      appState: appState,
      pushNotificationService: pushNotificationService,
    );
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    const email = 'test@example.com';
    const password = 'password123';
    const fcmToken = 'fcm_token_123';
    const loginResult = LoginResultEntity(
      token: 'token',
      userId: 1,
      userName: 'TestUser',
      isVerified: true,
      isProfileComplete: false,
    );
    const failureMessage = 'Invalid credentials';

    setUp(() {
      when(() => pushNotificationService.fcmToken).thenReturn(fcmToken);
    });

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login succeeds',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer((_) async => const Right(loginResult));
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.success, message: AuthStrings.loginSuccess),
      ],
      verify: (_) {
        verify(() => appState.isLoggedIn = true).called(1);
        verify(() => appState.isVerified = true).called(1);
        verify(() => appState.username = 'TestUser').called(1);
        verify(() => appState.isProfileComplete = false).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] when login fails',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => [
        const LoginState(status: AuthStatus.loading),
        const LoginState(status: AuthStatus.error, message: failureMessage),
      ],
      verify: (_) {
        verifyNever(() => appState.isLoggedIn = true);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'toggles password visibility from false to true',
      build: () => loginCubit,
      act: (cubit) => cubit.togglePasswordVisibility(),
      expect: () => const [
        LoginState(status: AuthStatus.initial, isPasswordVisible: true),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'toggles password visibility from true to false',
      build: () => loginCubit,
      setUp: () {
        loginCubit.togglePasswordVisibility();
      },
      act: (cubit) => cubit.togglePasswordVisibility(),
      expect: () => const [
        LoginState(status: AuthStatus.initial, isPasswordVisible: false),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'handles null fcm token',
      build: () => loginCubit,
      setUp: () {
        when(() => pushNotificationService.fcmToken).thenReturn(null);
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer((_) async => const Right(loginResult));
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.success, message: AuthStrings.loginSuccess),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits success with null username and profile complete',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer(
          (_) async => const Right(
            LoginResultEntity(
              token: 'token',
              userId: 2,
              isVerified: false,
              isProfileComplete: true,
            ),
          ),
        );
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.success, message: AuthStrings.loginSuccess),
      ],
      verify: (_) {
        verify(() => appState.isLoggedIn = true).called(1);
        verify(() => appState.isVerified = false).called(1);
        verify(() => appState.username = null).called(1);
        verify(() => appState.isProfileComplete = true).called(1);
      },
    );
  });
}
