import 'package:bridge_x/features/invitaions/data/models/leader_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/project_info_response_model.dart';
import 'package:bridge_x/features/invitaions/data/models/team_member_response_model.dart';
import 'package:bridge_x/features/invitaions/domain/entities/team_details_entity.dart';

class TeamDetailsResponseModel {
  final String name;
  final int membersCount;
  final ProjectInfoResponseModel project;
  final LeaderResponseModel leader;
  final List<TeamMemberResponseModel> members;

  const TeamDetailsResponseModel({
    required this.name,
    required this.membersCount,
    required this.project,
    required this.leader,
    this.members = const [],
  });

  factory TeamDetailsResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    final rawMembers = data['members'] as List? ?? const [];

    return TeamDetailsResponseModel(
      name: data['name'] as String? ?? '',
      membersCount: data['members_count'] as int? ??
          int.tryParse(data['members_count']?.toString() ?? '') ??
          0,
      project: ProjectInfoResponseModel.fromJson(
        data['project'] as Map<String, dynamic>?,
      ),
      leader: LeaderResponseModel.fromJson(
        data['leader'] as Map<String, dynamic>?,
      ),
      members: rawMembers
          .whereType<Map>()
          .map(
            (member) => TeamMemberResponseModel.fromJson(
              Map<String, dynamic>.from(member),
            ),
          )
          .toList(),
    );
  }

  TeamDetailsEntity toEntity() => TeamDetailsEntity(
        name: name,
        membersCount: membersCount,
        project: project.toEntity(),
        leader: leader.toEntity(),
        members: members.map((member) => member.toEntity()).toList(),
      );
}
