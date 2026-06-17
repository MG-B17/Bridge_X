class LoginResponseModel {
  final String token;
  final int userId;
  final String? userName;

  const LoginResponseModel({required this.token, required this.userId, this.userName});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map ? json['data'] as Map<String, dynamic> : json;
    final userObj = data['user'] is Map ? data['user'] as Map<String, dynamic> : data;
    final rawId = userObj['id'];
    final id = rawId is int ? rawId : int.tryParse('$rawId') ?? 0;
    final nameField = userObj['name'];
    final userNameVal = nameField is String
        ? nameField
        : userObj['user_name'] is String
            ? userObj['user_name'] as String
            : userObj['full_name'] is String ? userObj['full_name'] as String : null;
    return LoginResponseModel(
      token: json['token'] as String? ?? data['token'] as String? ?? '',
      userId: id,
      userName: userNameVal,
    );
  }
}
