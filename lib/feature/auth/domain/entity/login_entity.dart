class LoginEntity {
  final String email;
  final String password;
  final String? fcmToken;

  LoginEntity({
    required this.email,
    required this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (fcmToken != null) 'fcm_token': fcmToken,
    };
  }
}
