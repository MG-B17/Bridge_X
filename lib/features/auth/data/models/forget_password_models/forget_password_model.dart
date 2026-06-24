class ForgetPasswordModel {
  final String email;

  ForgetPasswordModel({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
