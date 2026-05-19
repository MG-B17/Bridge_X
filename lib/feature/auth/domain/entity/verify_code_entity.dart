class VerifyCodeEntity {
  final String email;
  final String code;

  VerifyCodeEntity({required this.code, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}
