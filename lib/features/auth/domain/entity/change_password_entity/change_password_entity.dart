class ChangePasswordEntity {
  final String currentPassword;
  final String newPassword;
  final String passwordConfirmation;

  const ChangePasswordEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.passwordConfirmation,
  });
}
