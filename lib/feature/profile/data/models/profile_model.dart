import 'package:bridge_x/feature/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.name,
    required super.track,
    super.avatarUrl,
    required super.level,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String? ?? '',
      track: json['track'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      level: json['level'] as String? ?? '',
    );
  }
}
