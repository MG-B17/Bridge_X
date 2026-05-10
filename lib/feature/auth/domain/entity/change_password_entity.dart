class ChangePasswordEntity {
  final String currentPassword;
  final String oldPassword;
  final String newPassword;

  ChangePasswordEntity({
    required this.currentPassword,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }
}
