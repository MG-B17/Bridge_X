import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_member_entity.dart';

class TeamMemberModel {
  final int programmerId;
  final String name;
  final String track;
  final String? avatarUrl;
  final String? role;

  const TeamMemberModel({
    required this.programmerId,
    required this.name,
    required this.track,
    required this.avatarUrl,
    this.role,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      programmerId: json['programmer_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      track: json['track'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String?,
    );
  }

  TeamMemberEntity toEntity() => TeamMemberEntity(
    programmerId: programmerId,
    name: name,
    track: track,
    avatarUrl: avatarUrl,
    role: role,
  );
}
