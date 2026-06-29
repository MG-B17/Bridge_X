class ResetPasswordModel {
  final String email;
  final String password;
  final String confirmPassword;
  final String resetToken;

  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.resetToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "reset_token": resetToken,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
    };
  }
}
