import 'package:bloc_test/bloc_test.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/auth/domain/entity/register_entity/register_entity.dart';
import 'package:bridge_x/features/auth/domain/usecases/register_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

void main() {
  late MockRegisterUsecase registerUsecase;
  late RegisterCubit registerCubit;

  setUpAll(() {
    registerFallbackValue(
      RegisterEntity(name: '', email: '', password: '', passwordConfirmation: ''),
    );
  });

  setUp(() {
    registerUsecase = MockRegisterUsecase();
    registerCubit = RegisterCubit(registerUsecase: registerUsecase);
  });

  tearDown(() {
    registerCubit.close();
  });

  group('RegisterCubit', () {
    const name = 'Test User';
    const email = 'test@example.com';
    const password = 'password123';
    const passwordConfirmation = 'password123';
    const successMessage = 'Registration successful';
    const failureMessage = 'Email already taken';

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, success] when registration succeeds',
      build: () => registerCubit,
      setUp: () {
        when(
          () => registerUsecase(registerEntity: any(named: 'registerEntity')),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        RegisterState(status: AuthStatus.loading),
        RegisterState(status: AuthStatus.success, message: successMessage),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, error] when registration fails',
      build: () => registerCubit,
      setUp: () {
        when(
          () => registerUsecase(registerEntity: any(named: 'registerEntity')),
        ).thenAnswer(
          (_) async => Left(AuthFailure(message: failureMessage)),
        );
      },
      act: (cubit) => cubit.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        RegisterState(status: AuthStatus.loading),
        RegisterState(status: AuthStatus.error, message: failureMessage),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'toggles password visibility',
      build: () => registerCubit,
      act: (cubit) => cubit.togglePasswordVisibility(),
      expect: () => const [
        RegisterState(status: AuthStatus.initial, isPasswordVisible: true),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'toggles confirm password visibility',
      build: () => registerCubit,
      act: (cubit) => cubit.toggleConfirmPasswordVisibility(),
      expect: () => const [
        RegisterState(
          status: AuthStatus.initial,
          isConfirmPasswordVisible: true,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'sets agreeTerms to true when toggled with true',
      build: () => registerCubit,
      act: (cubit) => cubit.toggleAgreeTerms(true),
      expect: () => const [
        RegisterState(status: AuthStatus.initial, agreeTerms: true),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'sets agreeTerms to false when toggled with false',
      build: () => registerCubit,
      act: (cubit) => cubit.toggleAgreeTerms(false),
      expect: () => const [
        RegisterState(status: AuthStatus.initial, agreeTerms: false),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'sets agreeTerms to false when toggled with null',
      build: () => registerCubit,
      act: (cubit) => cubit.toggleAgreeTerms(null),
      expect: () => const [
        RegisterState(status: AuthStatus.initial, agreeTerms: false),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'passes correct entity to usecase',
      build: () => registerCubit,
      setUp: () {
        when(
          () => registerUsecase(registerEntity: any(named: 'registerEntity')),
        ).thenAnswer((_) async => const Right(successMessage));
      },
      act: (cubit) => cubit.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
      expect: () => const [
        RegisterState(status: AuthStatus.loading),
        RegisterState(status: AuthStatus.success, message: successMessage),
      ],
      verify: (_) {
        verify(
          () => registerUsecase(
            registerEntity: any(
              named: 'registerEntity',
              that: isA<RegisterEntity>()
                  .having((e) => e.name, 'name', name)
                  .having((e) => e.email, 'email', email)
                  .having((e) => e.password, 'password', password)
                  .having(
                    (e) => e.passwordConfirmation,
                    'passwordConfirmation',
                    passwordConfirmation,
                  ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
