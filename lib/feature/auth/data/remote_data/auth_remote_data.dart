
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/auth/data/models/register_model.dart';
import 'package:bridge_x/feature/auth/data/models/rest_password_reponse_model.dart';
import 'package:bridge_x/feature/auth/domain/entity/change_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/forget_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/login_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/reset_password_entity.dart';
import 'package:bridge_x/feature/auth/domain/entity/verify_code_entity.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteData {
  Future<String> register({required RegisterEntity registerEntity});
  Future<String> login({required LoginEntity loginEntity});
  Future<String> verifyEmail({required VerifyCodeEntity verifyCodeEntity});
  Future<String> resendVerify({required String email});
  Future<String> forgetPassword({required ForgetPasswordEntity forgetPasswordEntity});
  Future<RestPasswordReponseModel> verifyPassword({required VerifyCodeEntity verifyPasswordEntity});
  Future<String> resetPassword({required ResetPasswordEntity resetPasswordEntity});
  Future<String> changePassword({required ChangePasswordEntity changePasswordEntity});
  Future<void> logout();
}

class AuthRemoteDataImpl implements AuthRemoteData {
  final ApiClient apiClient;

  AuthRemoteDataImpl({required this.apiClient});
  @override
  Future<String> register({required RegisterEntity registerEntity}) async {
    final register = RegisterModel.fromEntity(registerEntity).toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.register, data: register);
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> changePassword({required ChangePasswordEntity changePasswordEntity}) async {
    final changePassword = changePasswordEntity.toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.changePassword, data: changePassword);
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> forgetPassword({required ForgetPasswordEntity forgetPasswordEntity}) async {
    final forgetPassword = forgetPasswordEntity.toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.forgetPassword, data: forgetPassword);
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> login({required LoginEntity loginEntity}) async {
    final login = loginEntity.toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.login, data: login);
      final token = response.data['token'];
      if (token == null) {
        throw ServerException('Token not found in login response');
      }
      return token;
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> resendVerify({required String email}) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.resendVerificationCode,
        data: {'email': email},
      );
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> resetPassword({required ResetPasswordEntity resetPasswordEntity}) async {
    final resetPassword = resetPasswordEntity.toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.resetPassword, data: resetPassword);
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<String> verifyEmail({required VerifyCodeEntity verifyCodeEntity}) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.verifyEmail,
        data: verifyCodeEntity.toJson(),
      );
      return response.data['message'];
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<RestPasswordReponseModel> verifyPassword({
    required VerifyCodeEntity verifyPasswordEntity,
  }) async {
    final verifyPassword = verifyPasswordEntity.toJson();
    try {
      final response = await apiClient.post(path: ApiEndpoint.verifyPassword, data: verifyPassword);
      return RestPasswordReponseModel.fromjson(json: response.data);
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post(path: ApiEndpoint.logout, data: {});
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }
}
