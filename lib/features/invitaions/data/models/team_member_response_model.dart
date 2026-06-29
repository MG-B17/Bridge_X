import 'package:bridge_x/features/invitaions/domain/entities/team_member_entity.dart';

class TeamMemberResponseModel {
  final String name;
  final String? avatarUrl;
  final String track;

  const TeamMemberResponseModel({
    required this.name,
    this.avatarUrl,
    required this.track,
  });

  factory TeamMemberResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return TeamMemberResponseModel(
      name: data['name'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
      track: data['track'] as String? ?? '',
    );
  }

  TeamMemberEntity toEntity() => TeamMemberEntity(
        name: name,
        avatarUrl: avatarUrl,
        track: track,
      );
}
