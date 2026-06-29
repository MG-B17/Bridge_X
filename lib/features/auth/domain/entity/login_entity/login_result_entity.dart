class LoginResultEntity {
  final String message;
  final String token;
  final int userId;
  final String userName;
  final String name;
  final String email;
  final bool isVerified;
  final bool isProfileComplete;

  const LoginResultEntity({
    required this.message,
    required this.token,
    required this.userId,
    required this.userName,
    required this.name,
    required this.email,
    required this.isVerified,
    required this.isProfileComplete,
  });
}
