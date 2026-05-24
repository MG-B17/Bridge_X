import 'package:bridge_x/feature/project_details/domain/entities/team_member_entity.dart';

class TeamMemberModel {
  final int id;
  final String name;
  final String? avatarUrl;
  final String roleInTeam;

  const TeamMemberModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.roleInTeam,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      roleInTeam: json['role_in_team'] as String? ?? '',
    );
  }

  TeamMemberEntity toEntity() => TeamMemberEntity(
        id: id,
        name: name,
        avatarUrl: avatarUrl,
        roleInTeam: roleInTeam,
      );
}
