import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/auth/data/models/change_password_models/change_password_model.dart';
import 'package:bridge_x/features/auth/data/models/complete_profile_models/complete_profile_request_model.dart';
import 'package:bridge_x/features/auth/data/models/forget_password_models/forget_password_model.dart';
import 'package:bridge_x/features/auth/data/models/login_models/login_model.dart';
import 'package:bridge_x/features/auth/data/models/login_models/login_response_model.dart';
import 'package:bridge_x/features/auth/data/models/register_models/register_model.dart';
import 'package:bridge_x/features/auth/data/models/reset_password_models/reset_password_model.dart';
import 'package:bridge_x/features/auth/data/models/reset_password_models/reset_password_response_model.dart';
import 'package:bridge_x/features/auth/data/models/verify_code_model/verify_code_model.dart';
import 'package:bridge_x/features/auth/domain/entity/change_password_entity/change_password_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/forget_password_entity/forget_password_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/login_entity/login_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/register_entity/register_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/reset_password_entity/reset_password_entity.dart';
import 'package:bridge_x/features/auth/domain/entity/verify_code_entity.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteData {
  Future<String> register({required RegisterEntity registerEntity});
  Future<LoginResponseModel> login({required LoginEntity loginEntity});
  Future<String> verifyEmail({required VerifyCodeEntity verifyCodeEntity});
  Future<String> resendVerify({required String email});
  Future<String> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  });
  Future<ResetPasswordResponseModel> verifyPassword({
    required VerifyCodeEntity verifyPasswordEntity,
  });
  Future<String> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  });
  Future<String> changePassword({
    required ChangePasswordEntity changePasswordEntity,
  });
  Future<void> logout();
  Future<String> completeProfile({
    required CompleteProfileRequestModel request,
  });
}

class AuthRemoteDataImpl implements AuthRemoteData {
  final ApiClient apiClient;

  AuthRemoteDataImpl({required this.apiClient});

  Never _rethrowOrServerException(Object e) {
    if (e is DioException) throw e;
    throw ServerException(ErrorStrings.serverError);
  }

  @override
  Future<String> register({required RegisterEntity registerEntity}) async {
    final register = RegisterModel.fromEntity(registerEntity).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.register,
        data: register,
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> changePassword({
    required ChangePasswordEntity changePasswordEntity,
  }) async {
    final data = ChangePasswordModel(
      currentPassword: changePasswordEntity.currentPassword,
      newPassword: changePasswordEntity.newPassword,
      passwordConfirmation: changePasswordEntity.passwordConfirmation,
    ).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.changePassword,
        data: data,
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    final data = ForgetPasswordModel(email: forgetPasswordEntity.email).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.forgetPassword,
        data: data,
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<LoginResponseModel> login({required LoginEntity loginEntity}) async {
    final data = LoginModel(
      email: loginEntity.email,
      password: loginEntity.password,
      fcmToken: loginEntity.fcmToken,
    ).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.login,
        data: data,
      );
      if (response.data == null) {
        throw ServerException('Empty login response');
      }
      final model = LoginResponseModel.fromJson(response.data);
      LoggerService.debug('Login parsed userId=${model.userId}', tag: 'AuthRemoteData');
      return model;
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> resendVerify({required String email}) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.resendVerificationCode,
        data: {'email': email},
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  }) async {
    final data = ResetPasswordModel(
      email: resetPasswordEntity.email,
      password: resetPasswordEntity.password,
      confirmPassword: resetPasswordEntity.confirmPassword,
      resetToken: resetPasswordEntity.resetToken,
    ).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.resetPassword,
        data: data,
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> verifyEmail({
    required VerifyCodeEntity verifyCodeEntity,
  }) async {
    final data = VerifyCodeModel(
      email: verifyCodeEntity.email,
      code: verifyCodeEntity.code,
    ).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.verifyEmail,
        data: data,
      );
      return _extractMessage(response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<ResetPasswordResponseModel> verifyPassword({
    required VerifyCodeEntity verifyPasswordEntity,
  }) async {
    final data = VerifyCodeModel(
      email: verifyPasswordEntity.email,
      code: verifyPasswordEntity.code,
    ).toJson();
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.verifyPassword,
        data: data,
      );
      if (response.data == null) {
        throw ServerException('Empty verify password response');
      }
      return ResetPasswordResponseModel.fromJson(json: response.data);
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map && data['message'] != null) {
      return data['message'] as String;
    }
    return '';
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post(path: ApiEndpoint.logout, data: {});
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }

  @override
  Future<String> completeProfile({
    required CompleteProfileRequestModel request,
  }) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoint.completeProfile,
        data: request.toJson(),
      );
      return response.data['message'] as String? ?? '';
    } catch (e) {
      _rethrowOrServerException(e);
    }
  }
}
