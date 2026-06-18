import 'package:bloc_test/bloc_test.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_password_entity/verify_password_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_password_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/password_reset/password_reset_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/password_reset/password_reset_state.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgetPasswordUsecase extends Mock
    implements ForgetPasswordUsecase {}

class MockVerifyPasswordUsecase extends Mock
    implements VerifyPasswordUsecase {}

class MockResetPasswordUsecase extends Mock
    implements ResetPasswordUsecase {}

void main() {
  late MockForgetPasswordUsecase forgetPasswordUsecase;
  late MockVerifyPasswordUsecase verifyPasswordUsecase;
  late MockResetPasswordUsecase resetPasswordUsecase;
  late PasswordResetCubit passwordResetCubit;

  setUpAll(() {
    registerFallbackValue(ForgetPasswordEntity(email: ''));
    registerFallbackValue(VerifyCodeEntity(email: '', code: ''));
    registerFallbackValue(
      ResetPasswordEntity(email: '', password: '', confirmPassword: '', resetToken: ''),
    );
  });

  setUp(() {
    forgetPasswordUsecase = MockForgetPasswordUsecase();
    verifyPasswordUsecase = MockVerifyPasswordUsecase();
    resetPasswordUsecase = MockResetPasswordUsecase();
    passwordResetCubit = PasswordResetCubit(
      forgetPasswordUsecase: forgetPasswordUsecase,
      verifyPasswordUsecase: verifyPasswordUsecase,
      resetPasswordUsecase: resetPasswordUsecase,
    );
  });

  tearDown(() {
    passwordResetCubit.close();
  });

  group('PasswordResetCubit - forgetPassword', () {
    const email = 'test@example.com';
    const successMessage = 'Reset link sent';
    const failureMessage = 'Email not found';

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, success] when forgetPassword succeeds',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => forgetPasswordUsecase(
            forgetPasswordEntity: any(named: 'forgetPasswordEntity'),
          ),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.forgetPassword(email: email),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.success, message: successMessage),
      ],
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, error] when forgetPassword fails',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => forgetPasswordUsecase(
            forgetPasswordEntity: any(named: 'forgetPasswordEntity'),
          ),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.forgetPassword(email: email),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.error, message: failureMessage),
      ],
    );
  });

  group('PasswordResetCubit - verifyPassword', () {
    const email = 'test@example.com';
    const code = '123456';
    const resetToken = 'reset_token_abc';
    const successMessage = 'Code verified';
    const failureMessage = 'Invalid code';

    const verifyResult = VerifyPasswordResultEntity(
      resetToken: resetToken,
      message: successMessage,
      expiresAt: '2026-01-01T00:00:00Z',
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, success with resetToken] when verifyPassword succeeds',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => verifyPasswordUsecase(
            verifyPasswordEntity: any(named: 'verifyPasswordEntity'),
          ),
        ).thenAnswer((_) async => const Right(verifyResult));
      },
      act: (cubit) => cubit.verifyPassword(email: email, code: code),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(
          status: AuthStatus.success,
          message: successMessage,
          resetToken: resetToken,
        ),
      ],
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, error] when verifyPassword fails',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => verifyPasswordUsecase(
            verifyPasswordEntity: any(named: 'verifyPasswordEntity'),
          ),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.verifyPassword(email: email, code: code),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.error, message: failureMessage),
      ],
    );
  });

  group('PasswordResetCubit - resetPassword', () {
    const email = 'test@example.com';
    const code = '123456';
    const newPassword = 'newPassword123';
    const passwordConfirmation = 'newPassword123';
    const successMessage = 'Password reset successfully';
    const failureMessage = 'Reset failed';

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, success] when resetPassword succeeds',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => resetPasswordUsecase(
            resetPasswordEntity: any(named: 'resetPasswordEntity'),
          ),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.success, message: successMessage),
      ],
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'emits [loading, error] when resetPassword fails',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => resetPasswordUsecase(
            resetPasswordEntity: any(named: 'resetPasswordEntity'),
          ),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.error, message: failureMessage),
      ],
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'resets password with correct entity fields',
      build: () => passwordResetCubit,
      setUp: () {
        when(
          () => resetPasswordUsecase(
            resetPasswordEntity: any(named: 'resetPasswordEntity'),
          ),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        PasswordResetState(status: AuthStatus.loading),
        PasswordResetState(status: AuthStatus.success, message: successMessage),
      ],
      verify: (_) {
        verify(
          () => resetPasswordUsecase(
            resetPasswordEntity: any(
              named: 'resetPasswordEntity',
              that: isA<ResetPasswordEntity>()
                  .having((e) => e.email, 'email', email)
                  .having((e) => e.password, 'password', newPassword)
                  .having(
                    (e) => e.confirmPassword,
                    'confirmPassword',
                    passwordConfirmation,
                  )
                  .having((e) => e.resetToken, 'resetToken', code),
            ),
          ),
        ).called(1);
      },
    );
  });

  group('PasswordResetCubit - toggles', () {
    blocTest<PasswordResetCubit, PasswordResetState>(
      'toggles password visibility',
      build: () => passwordResetCubit,
      act: (cubit) => cubit.togglePasswordVisibility(),
      expect: () => const [
        PasswordResetState(status: AuthStatus.initial, isPasswordVisible: true),
      ],
    );

    blocTest<PasswordResetCubit, PasswordResetState>(
      'toggles confirm password visibility',
      build: () => passwordResetCubit,
      act: (cubit) => cubit.toggleConfirmPasswordVisibility(),
      expect: () => const [
        PasswordResetState(
          status: AuthStatus.initial,
          isConfirmPasswordVisible: true,
        ),
      ],
    );
  });
}
