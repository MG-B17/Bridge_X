class RestPasswordReponseModel {
  final String token;
  final String message;
  final String expiresAt;

  RestPasswordReponseModel({required this.message, required this.token, required this.expiresAt});

  factory RestPasswordReponseModel.fromjson({required Map<String, dynamic> json}) {
    return RestPasswordReponseModel(
      message: json['message'],
      token: json['reset_token'],
      expiresAt: json['expires_at'],
    );
  }
}
