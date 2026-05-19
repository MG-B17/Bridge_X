class ForgetPasswordEntity {
  final String email;

  ForgetPasswordEntity({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
