import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';

class JoinRequestProgrammerResponseModel {
  final int programmerId;
  final String name;
  final String username;
  final String? avatarUrl;
  final String track;
  final String? bio;
  final List<String> skills;
  final double averageStars;

  const JoinRequestProgrammerResponseModel({
    required this.programmerId,
    required this.name,
    required this.username,
    this.avatarUrl,
    required this.track,
    this.bio,
    required this.skills,
    this.averageStars = 0,
  });

  factory JoinRequestProgrammerResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    final skillsList = (data['skills'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    return JoinRequestProgrammerResponseModel(
      programmerId: data['programmer_id'] as int? ??
          int.tryParse(data['programmer_id']?.toString() ?? '') ??
          0,
      name: data['name'] as String? ?? '',
      username: data['username'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
      track: data['track'] as String? ?? '',
      bio: data['bio'] as String?,
      skills: skillsList,
      averageStars: (data['average_stars'] as num?)?.toDouble() ?? 0,
    );
  }
}

class JoinRequestProjectResponseModel {
  final int projectId;
  final String name;
  final String? description;

  const JoinRequestProjectResponseModel({
    required this.projectId,
    required this.name,
    this.description,
  });

  factory JoinRequestProjectResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return JoinRequestProjectResponseModel(
      projectId: data['project_id'] as int? ??
          int.tryParse(data['project_id']?.toString() ?? '') ??
          0,
      name: data['name'] as String? ?? '',
      description: data['description'] as String?,
    );
  }
}

class JoinRequestTeamResponseModel {
  final int teamId;
  final String name;

  const JoinRequestTeamResponseModel({
    required this.teamId,
    required this.name,
  });

  factory JoinRequestTeamResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return JoinRequestTeamResponseModel(
      teamId: data['team_id'] as int? ??
          int.tryParse(data['team_id']?.toString() ?? '') ??
          0,
      name: data['name'] as String? ?? '',
    );
  }
}

class JoinRequestResponseModel {
  final int joinRequestId;
  final String status;
  final String? respondedAt;
  final JoinRequestProgrammerResponseModel programmer;
  final JoinRequestProjectResponseModel project;
  final JoinRequestTeamResponseModel team;

  const JoinRequestResponseModel({
    required this.joinRequestId,
    required this.status,
    this.respondedAt,
    required this.programmer,
    required this.project,
    required this.team,
  });

  factory JoinRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return JoinRequestResponseModel(
      joinRequestId: json['join_request_id'] as int? ??
          int.tryParse(json['join_request_id']?.toString() ?? '') ??
          0,
      status: json['status'] as String? ?? '',
      respondedAt: json['responded_at'] as String?,
      programmer: JoinRequestProgrammerResponseModel.fromJson(
        json['programmer'] as Map<String, dynamic>?,
      ),
      project: JoinRequestProjectResponseModel.fromJson(
        json['project'] as Map<String, dynamic>?,
      ),
      team: JoinRequestTeamResponseModel.fromJson(
        json['team'] as Map<String, dynamic>?,
      ),
    );
  }

  JoinRequestEntity toEntity() => JoinRequestEntity(
        id: joinRequestId.toString(),
        userName: programmer.name,
        userHandle: programmer.username,
        userRole: programmer.track,
        userRating: programmer.averageStars,
        userAvatar: programmer.avatarUrl ??
            'https://i.pravatar.cc/150?u=${programmer.programmerId}',
        expertiseTags: programmer.skills,
        aboutText: programmer.bio ?? '',
        appliedTimeAgo: status == 'pending' ? 'Pending' : status,
        isNew: status == 'pending',
      );
}
