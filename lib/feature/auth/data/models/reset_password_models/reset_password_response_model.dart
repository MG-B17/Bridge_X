class ResetPasswordResponseModel {
  final String token;
  final String message;
  final String expiresAt;

  const ResetPasswordResponseModel({
    required this.message,
    required this.token,
    required this.expiresAt,
  });

  factory ResetPasswordResponseModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ResetPasswordResponseModel(
      message: json['message'],
      token: json['reset_token'],
      expiresAt: json['expires_at'],
    );
  }
}
