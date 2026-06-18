class LoginResultEntity {
  final String token;
  final int userId;
  final String? userName;
  final bool isVerified;
  final bool isProfileComplete;

  const LoginResultEntity({
    required this.token,
    required this.userId,
    this.userName,
    required this.isVerified,
    required this.isProfileComplete,
  });
}
