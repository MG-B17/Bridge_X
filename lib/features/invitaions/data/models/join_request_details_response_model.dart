import 'package:bridge_x/features/invitaions/data/models/join_request_response_model.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_programmer_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_project_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_team_entity.dart';

class JoinRequestDetailsResponseModel {
  final int joinRequestId;
  final String status;
  final String createdAt;
  final String? respondedAt;
  final JoinRequestProgrammerResponseModel programmer;
  final JoinRequestProjectResponseModel project;
  final JoinRequestTeamResponseModel team;

  const JoinRequestDetailsResponseModel({
    required this.joinRequestId,
    required this.status,
    required this.createdAt,
    this.respondedAt,
    required this.programmer,
    required this.project,
    required this.team,
  });

  factory JoinRequestDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return JoinRequestDetailsResponseModel(
      joinRequestId: data['join_request_id'] as int? ??
          int.tryParse(data['join_request_id']?.toString() ?? '') ??
          0,
      status: data['status'] as String? ?? '',
      createdAt: data['created_at'] as String? ?? '',
      respondedAt: data['responded_at'] as String?,
      programmer: JoinRequestProgrammerResponseModel.fromJson(
        data['programmer'] as Map<String, dynamic>?,
      ),
      project: JoinRequestProjectResponseModel.fromJson(
        data['project'] as Map<String, dynamic>?,
      ),
      team: JoinRequestTeamResponseModel.fromJson(
        data['team'] as Map<String, dynamic>?,
      ),
    );
  }

  JoinRequestDetailsEntity toEntity() => JoinRequestDetailsEntity(
        joinRequestId: joinRequestId,
        status: status,
        createdAt: createdAt,
        respondedAt: respondedAt,
        programmer: JoinRequestProgrammerEntity(
          programmerId: programmer.programmerId,
          name: programmer.name,
          username: programmer.username,
          avatarUrl: programmer.avatarUrl,
          track: programmer.track,
          bio: programmer.bio,
          skills: programmer.skills,
          averageStars: programmer.averageStars,
        ),
        project: JoinRequestProjectEntity(
          projectId: project.projectId,
          name: project.name,
          description: project.description,
        ),
        team: JoinRequestTeamEntity(
          teamId: team.teamId,
          name: team.name,
        ),
      );
}
