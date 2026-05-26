import 'package:bridge_x/feature/profile/domain/entities/edit_profile_entity.dart';

class DisplayProfileResponseModel extends EditProfileEntity {
  const DisplayProfileResponseModel({
    required super.id,
    required super.userName,
    required super.fullName,
    required super.email,
    required super.bio,
    required super.track,
    super.avatarUrl,
  });

  factory DisplayProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return DisplayProfileResponseModel(
      id: data['id'] as int? ?? 0,
      userName: data['user_name'] as String? ?? '',
      fullName: data['full_name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      bio: data['bio'] as String? ?? '',
      track: data['track'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
    );
  }
}

class UpdateProfileResponseModel extends EditProfileEntity {
  const UpdateProfileResponseModel({
    required super.id,
    required super.userName,
    required super.fullName,
    required super.email,
    required super.bio,
    required super.track,
    super.avatarUrl,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return UpdateProfileResponseModel(
      id: data['id'] as int? ?? 0,
      userName: data['user_name'] as String? ?? '',
      fullName: data['full_name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      bio: data['bio'] as String? ?? '',
      track: data['track'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
    );
  }
}
