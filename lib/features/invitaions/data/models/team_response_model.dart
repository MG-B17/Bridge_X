import 'package:bridge_x/features/invitaions/data/models/project_response_model.dart';
import 'package:bridge_x/features/invitaions/domain/entities/team_entity.dart';

class TeamResponseModel {
  final String name;
  final int membersCount;
  final ProjectResponseModel project;
  final String? leaderAvatar;
  final List<String> membersAvatars;

  const TeamResponseModel({
    required this.name,
    required this.membersCount,
    required this.project,
    this.leaderAvatar,
    this.membersAvatars = const [],
  });

  factory TeamResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    final avatars = data['members_avatars'] as List? ?? const [];

    return TeamResponseModel(
      name: data['name'] as String? ?? '',
      membersCount: data['members_count'] as int? ??
          int.tryParse(data['members_count']?.toString() ?? '') ??
          0,
      project: ProjectResponseModel.fromJson(
        data['project'] as Map<String, dynamic>?,
      ),
      leaderAvatar: data['leader_avatar'] as String?,
      membersAvatars: avatars
          .where((avatar) => avatar != null)
          .map((avatar) => avatar.toString())
          .toList(),
    );
  }

  TeamEntity toEntity() => TeamEntity(
        name: name,
        membersCount: membersCount,
        project: project.toEntity(),
        leaderAvatar: leaderAvatar,
        membersAvatars: membersAvatars,
      );
}
