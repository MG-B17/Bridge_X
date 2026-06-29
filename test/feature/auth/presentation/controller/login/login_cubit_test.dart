import 'package:bloc_test/bloc_test.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:bridge_x/features/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/login_entity/login_result_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/login_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/login/login_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/login/login_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'package:bridge_x/features/chat/domain/usecases/save_user_chat_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockAppState extends Mock implements AppState {}

class MockPushNotificationService extends Mock implements PushNotificationService {}

class MockSaveUserChatData extends Mock implements SaveUserChatData {}

void main() {
  late MockLoginUsecase loginUsecase;
  late MockAppState appState;
  late MockPushNotificationService pushNotificationService;
  late MockSaveUserChatData saveUserChatData;
  late LoginCubit loginCubit;

  const email = 'test@example.com';
  const password = 'password123';

  const entity = LoginResultEntity(
    message: 'Login successful',
    token: 'token|123',
    userId: 1,
    userName: 'testuser',
    name: 'Test User',
    email: email,
    isVerified: true,
    isProfileComplete: true,
  );

  setUpAll(() {
    registerFallbackValue(LoginEntity(email: '', password: ''));
    registerFallbackValue(UserDataModel(userId: '', userName: '', userEmail: ''));
  });

  setUp(() {
    loginUsecase = MockLoginUsecase();
    appState = MockAppState();
    pushNotificationService = MockPushNotificationService();
    saveUserChatData = MockSaveUserChatData();
    when(() => pushNotificationService.fcmToken).thenReturn(null);
    loginCubit = LoginCubit(
      loginUsecase: loginUsecase,
      appState: appState,
      pushNotificationService: pushNotificationService,
      saveUserChatData: saveUserChatData,
    );
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] and updates AppState on successful login',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer((_) async => Right(entity));
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.success, message: AuthStrings.loginSuccess),
      ],
      verify: (_) {
        verify(
          () => appState.batchUpdate(
            isLoggedIn: any(named: 'isLoggedIn'),
            isVerified: any(named: 'isVerified'),
            isProfileComplete: any(named: 'isProfileComplete'),
            userData: any(named: 'userData'),
          ),
        ).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] on login failure',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: 'Invalid credentials')),
        );
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.error, message: 'Invalid credentials'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'passes null FCM token to usecase when unavailable',
      build: () => loginCubit,
      setUp: () {
        when(
          () => loginUsecase(loginEntity: any(named: 'loginEntity')),
        ).thenAnswer((_) async => Right(entity));
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => const [
        LoginState(status: AuthStatus.loading),
        LoginState(status: AuthStatus.success, message: AuthStrings.loginSuccess),
      ],
      verify: (_) {
        verify(
          () => loginUsecase(
            loginEntity: any(
              named: 'loginEntity',
              that: isA<LoginEntity>()
                  .having((e) => e.email, 'email', email)
                  .having((e) => e.fcmToken, 'fcmToken', null),
            ),
          ),
        ).called(1);
      },
    );

    test('toggles password visibility', () {
      expect(loginCubit.state.isPasswordVisible, false);
      loginCubit.togglePasswordVisibility();
      expect(loginCubit.state.isPasswordVisible, true);
      loginCubit.togglePasswordVisibility();
      expect(loginCubit.state.isPasswordVisible, false);
    });
  });

  group('AppState.batchUpdate', () {
    test('applies all provided values in single notification', () {
      final state = AppState();
      int notificationCount = 0;
      state.addListener(() => notificationCount++);

      state.batchUpdate(
        isLoggedIn: true,
        isVerified: true,
        isProfileComplete: true,
        userData: UserDataModel(
          userId: '1', userName: 'test', userEmail: email,
        ),
      );

      expect(notificationCount, 1);
      expect(state.isLoggedIn, true);
      expect(state.isVerified, true);
      expect(state.isProfileComplete, true);
      expect(state.userData?.userName, 'test');
    });

    test('skips notification when no values change', () {
      final state = AppState();
      int notificationCount = 0;
      state.addListener(() => notificationCount++);

      state.batchUpdate();
      expect(notificationCount, 0);
    });
  });
}
