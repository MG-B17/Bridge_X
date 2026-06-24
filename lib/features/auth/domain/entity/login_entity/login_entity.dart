class LoginEntity {
  final String email;
  final String password;
  final String? fcmToken;

  LoginEntity({required this.email, required this.password, this.fcmToken});
}
