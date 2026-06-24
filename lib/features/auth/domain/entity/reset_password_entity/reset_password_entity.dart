class ResetPasswordEntity {
  final String email;
  final String password;
  final String confirmPassword;
  final String resetToken;

  ResetPasswordEntity({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.resetToken,
  });
}
