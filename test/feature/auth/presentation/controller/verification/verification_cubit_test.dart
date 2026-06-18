import 'package:bloc_test/bloc_test.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/usecases/resend_verify_usecase.dart';
import 'package:bridge_x/feature/auth/domain/usecases/verify_email_usecase.dart';
import 'package:bridge_x/feature/auth/presentation/controller/verification/verification_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifyEmailUsecase extends Mock implements VerifyEmailUsecase {}

class MockResendVerifyUseCase extends Mock implements ResendVerifyUseCase {}

void main() {
  late MockVerifyEmailUsecase verifyEmailUsecase;
  late MockResendVerifyUseCase resendVerifyUseCase;
  late VerificationCubit verificationCubit;

  setUpAll(() {
    registerFallbackValue(VerifyCodeEntity(email: '', code: ''));
  });

  setUp(() {
    verifyEmailUsecase = MockVerifyEmailUsecase();
    resendVerifyUseCase = MockResendVerifyUseCase();
    verificationCubit = VerificationCubit(
      verifyEmailUsecase: verifyEmailUsecase,
      resendVerifyUseCase: resendVerifyUseCase,
    );
  });

  tearDown(() {
    verificationCubit.close();
  });

  group('VerificationCubit - verifyEmail', () {
    const email = 'test@example.com';
    const code = '123456';
    const successMessage = 'Email verified';
    const failureMessage = 'Invalid code';

    blocTest<VerificationCubit, VerificationState>(
      'emits [loading, success] when verifyEmail succeeds',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => verifyEmailUsecase(
            verifyCodeEntity: any(named: 'verifyCodeEntity'),
          ),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.verifyEmail(email: email, code: code),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.success, message: successMessage),
      ],
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits [loading, error] when verifyEmail fails',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => verifyEmailUsecase(
            verifyCodeEntity: any(named: 'verifyCodeEntity'),
          ),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.verifyEmail(email: email, code: code),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.error, message: failureMessage),
      ],
    );

    blocTest<VerificationCubit, VerificationState>(
      'calls verifyEmail with correct entity',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => verifyEmailUsecase(
            verifyCodeEntity: any(named: 'verifyCodeEntity'),
          ),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.verifyEmail(email: email, code: code),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.success, message: successMessage),
      ],
      verify: (_) {
        verify(
          () => verifyEmailUsecase(
            verifyCodeEntity: any(
              named: 'verifyCodeEntity',
              that: isA<VerifyCodeEntity>()
                  .having((e) => e.email, 'email', email)
                  .having((e) => e.code, 'code', code),
            ),
          ),
        ).called(1);
      },
    );
  });

  group('VerificationCubit - resendVerify', () {
    const email = 'test@example.com';
    const successMessage = 'Code resent';
    const failureMessage = 'Resend failed';

    blocTest<VerificationCubit, VerificationState>(
      'emits [loading, success] when resendVerify succeeds',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => resendVerifyUseCase(email: any(named: 'email')),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.resendVerify(email: email),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.success, message: successMessage),
      ],
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits [loading, error] when resendVerify fails',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => resendVerifyUseCase(email: any(named: 'email')),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.resendVerify(email: email),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.error, message: failureMessage),
      ],
    );

    blocTest<VerificationCubit, VerificationState>(
      'calls resendVerify with correct email',
      build: () => verificationCubit,
      setUp: () {
        when(
          () => resendVerifyUseCase(email: any(named: 'email')),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.resendVerify(email: email),
      expect: () => const [
        VerificationState(status: AuthStatus.loading),
        VerificationState(status: AuthStatus.success, message: successMessage),
      ],
      verify: (_) {
        verify(() => resendVerifyUseCase(email: email)).called(1);
      },
    );
  });
}
