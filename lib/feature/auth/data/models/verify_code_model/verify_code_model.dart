class VerifyCodeModel {
  final String email;
  final String code;

  VerifyCodeModel({required this.code, required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email, 'code': code};
  }
}
