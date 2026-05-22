import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/auth/data/remote_data/auth_remote_data.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_password_result_entity.dart';
import 'package:bridge_x/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImplement extends AuthRepo {
  final AuthRemoteData authRemoteData;
  final NetworkInfo networkInfo;
  final SecureStorageService secureStorageService;

  AuthRepoImplement({
    required this.authRemoteData,
    required this.networkInfo,
    required this.secureStorageService,
  });

  @override
  Future<Either<Failure, String>> changePassword({
    required ChangePasswordEntity changePasswordEntity,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Changing password', tag: 'AuthRepo');
        final result = await authRemoteData.changePassword(
          changePasswordEntity: changePasswordEntity,
        );
        LoggerService.info('Password changed successfully', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Change password failed', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Requesting password reset for: ${forgetPasswordEntity.email}', tag: 'AuthRepo');
        final result = await authRemoteData.forgetPassword(
          forgetPasswordEntity: forgetPasswordEntity,
        );
        LoggerService.info('Password reset email sent', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Forget password request failed', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> login({required LoginEntity loginEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Attempting login for: ${loginEntity.email}', tag: 'AuthRepo');
        final token = await authRemoteData.login(loginEntity: loginEntity);
        await secureStorageService.write(key: AppKeys.authToken, value: token);
        LoggerService.info('Login successful for: ${loginEntity.email}', tag: 'AuthRepo');
        return const Right('Login successful!');
      } on ServerException catch (e) {
        LoggerService.error('Login failed for: ${loginEntity.email}', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> register({required RegisterEntity registerEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug(
          'Attempting registration for: ${registerEntity.email}',
          tag: 'AuthRepo',
        );
        final result = await authRemoteData.register(registerEntity: registerEntity);
        LoggerService.info('Registration successful for: ${registerEntity.email}', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Registration failed for: ${registerEntity.email}', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> resendVerify({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Resending verification email for: $email', tag: 'AuthRepo');
        final result = await authRemoteData.resendVerify(email: email);
        LoggerService.info('Verification email resent to: $email', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Resend verify failed for: $email', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemoteData.resetPassword(resetPasswordEntity: resetPasswordEntity);
        LoggerService.info('Password reset successful', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Password change failed', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail({required VerifyCodeEntity verifyCodeEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Verifying email code', tag: 'AuthRepo');
       final result = await authRemoteData.verifyEmail(verifyCodeEntity: verifyCodeEntity);
        LoggerService.info('Email verified successfully', tag: 'AuthRepo');
        return Right(result);
      } on ServerException catch (e) {
        LoggerService.error('Email verification failed', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, VerifyPasswordResultEntity>> verifyPassword({
    required VerifyCodeEntity verifyPasswordEntity,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Verifying password reset code', tag: 'AuthRepo');
        final result = await authRemoteData.verifyPassword(
          verifyPasswordEntity: verifyPasswordEntity,
        );
        LoggerService.info('Password reset code verified successfully', tag: 'AuthRepo');
        // Map Data model → Domain entity at the boundary
        return Right(VerifyPasswordResultEntity(
          resetToken: result.token,
          message: result.message,
          expiresAt: result.expiresAt,
        ));
      } on ServerException catch (e) {
        LoggerService.error('Password verification failed', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: 'AuthRepo');
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        LoggerService.debug('Logging out', tag: 'AuthRepo');
        await authRemoteData.logout();
        await secureStorageService.delete(key: AppKeys.authToken);
        LoggerService.info('Logout successful, token deleted', tag: 'AuthRepo');
        return Right(null);
      } on ServerException catch (e) {
        // Even if API call fails, delete the local token for security
        await secureStorageService.delete(key: AppKeys.authToken);
        LoggerService.error('Logout API failed, local token still deleted', exception: e, tag: 'AuthRepo');
        return Left(ServerFailure(message: e.message!));
      } on DioException catch (error) {
        await secureStorageService.delete(key: AppKeys.authToken);
        return left(ErrorHandler.handle(error));
      }
    } else {
      // Offline: still delete the local token
      await secureStorageService.delete(key: AppKeys.authToken);
      LoggerService.warning('No internet — local token deleted anyway', tag: 'AuthRepo');
      return Right(null);
    }
  }
}
