import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_password_result_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure,String>> register({required RegisterEntity registerEntity});

  Future<Either<Failure,String>> login({required LoginEntity loginEntity});

  Future<Either<Failure,String>> verifyEmail({required VerifyCodeEntity verifyCodeEntity});

  Future<Either<Failure,String>> resendVerify({required String email});

  Future<Either<Failure,String>> forgetPassword({required ForgetPasswordEntity forgetPasswordEntity});

  Future<Either<Failure, VerifyPasswordResultEntity>> verifyPassword({required VerifyCodeEntity verifyPasswordEntity});

  Future<Either<Failure,String>> resetPassword({required ResetPasswordEntity resetPasswordEntity});

  Future<Either<Failure, String>> changePassword({required ChangePasswordEntity changePasswordEntity});

  Future<Either<Failure, void>> logout();
}