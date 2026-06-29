import 'package:bridge_x/features/auth/domain/entity/login_entity/login_result_entity.dart';

class LoginResponseModel {
  final String message;
  final String token;
  final int userId;
  final String name;
  final String userName;
  final bool isVerified;
  final bool isProfileComplete;
  final String email;
  final String track;
  final String bio;
  final String exeperienceLevel;
  final int totalScore;
  final String fcmToken;
  final String avatarUrl;

  const LoginResponseModel({
    required this.message,
    required this.token,
    required this.userId,
    required this.name,
    required this.userName,
    required this.isVerified,
    required this.isProfileComplete,
    required this.email,
    required this.track,
    required this.bio,
    required this.exeperienceLevel,
    required this.totalScore,
    required this.fcmToken,
    required this.avatarUrl,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] is Map
        ? json['data'] as Map<String, dynamic>
        : json);
    final user = (data['user'] is Map
        ? data['user'] as Map<String, dynamic>
        : data);

    return LoginResponseModel(
      message: json['message'] as String? ?? data['message'] as String? ?? '',
      token: json['token'] as String? ?? data['token'] as String? ?? '',
      userId: user['programmer_id'] is int
          ? user['programmer_id'] as int
          : int.tryParse('${user['programmer_id']}') ?? 0,
      userName:
          user['user_name'] as String? ?? user['username'] as String? ?? '',
      name: user['name'] as String? ?? '',
      isVerified: _parseBool(user['is_verified']),
      isProfileComplete: _parseBool(user['is_profile_complete'] ?? user['profile_completed']),
      email: user['email'] as String? ?? '',
      track: user['track'] as String? ?? '',
      bio: user['bio'] as String? ?? '',
      exeperienceLevel: user['experience_level'] as String? ?? '',
      totalScore: user['total_score'] is int
          ? user['total_score'] as int
          : int.tryParse('${user['total_score']}') ?? 0,
      fcmToken: user['fcm_token'] as String? ?? '',
      avatarUrl: user['avatar_url'] as String? ?? '',
    );
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value == 'true';
    return false;
  }

  LoginResultEntity toEntity() => LoginResultEntity(
    message: message,
    token: token,
    userId: userId,
    name: name,
    userName: userName,
    isVerified: isVerified,
    isProfileComplete: isProfileComplete,
    email: email,
  );
}
