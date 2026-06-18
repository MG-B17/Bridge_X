class LoginResponseModel {
  final String token;
  final int userId;
  final String? userName;
  final bool isVerified;
  final bool isProfileComplete;

  const LoginResponseModel({
    required this.token,
    required this.userId,
    this.userName,
    required this.isVerified,
    this.isProfileComplete = false,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] is Map
        ? json['data'] as Map<String, dynamic>
        : json);
    final user = (data['user'] is Map
        ? data['user'] as Map<String, dynamic>
        : data);

    return LoginResponseModel(
      token: json['token'] as String? ?? data['token'] as String? ?? '',
      userId: user['id'] is int
          ? user['id'] as int
          : int.tryParse('${user['id']}') ?? 0,
      userName: user['user_name'] as String? ?? user['name'] as String?,
      isVerified: _parseBool(user['is_verified']),
      isProfileComplete: _parseBool(user['is_profile_complete']),
    );
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value == 'true';
    return false;
  }
}
