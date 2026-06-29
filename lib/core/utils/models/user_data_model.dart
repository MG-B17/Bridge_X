import 'dart:convert';

class UserDataModel {
  final String userId;
  final String userName;
  final String userEmail;
  final bool isVerified;
  final bool isProfileComplete;

  UserDataModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.isVerified = false,
    this.isProfileComplete = false,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['user_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      userEmail: json['user_email'] as String? ?? '',
      isVerified: json['is_verified'] as bool? ?? false,
      isProfileComplete: json['is_profile_complete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'user_email': userEmail,
      'is_verified': isVerified,
      'is_profile_complete': isProfileComplete,
    };
  }

  UserDataModel copyWith({
    String? userId,
    String? userName,
    String? userEmail,
    bool? isVerified,
    bool? isProfileComplete,
  }) {
    return UserDataModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isVerified: isVerified ?? this.isVerified,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  static String userEncodedata({required UserDataModel userDataModel}) {
    return jsonEncode(userDataModel.toJson());
  }

  static UserDataModel userDecodedata({required String userEncodedData}) {
    return UserDataModel.fromJson(jsonDecode(userEncodedData));
  }
}
