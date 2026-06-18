import 'package:bridge_x/feature/invitaions/domain/entities/accepted_invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/accepted_member_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/accepted_team_entity.dart';

class AcceptedTeamResponseModel {
  final int id;
  final String name;
  final int currentMembers;
  final int maxMembers;

  const AcceptedTeamResponseModel({
    required this.id,
    required this.name,
    required this.currentMembers,
    required this.maxMembers,
  });

  factory AcceptedTeamResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return AcceptedTeamResponseModel(
      id: data['id'] as int? ?? int.tryParse(data['id']?.toString() ?? '') ?? 0,
      name: data['name'] as String? ?? '',
      currentMembers: data['current_members'] as int? ??
          int.tryParse(data['current_members']?.toString() ?? '') ??
          0,
      maxMembers: data['max_members'] as int? ??
          int.tryParse(data['max_members']?.toString() ?? '') ??
          0,
    );
  }

  AcceptedTeamEntity toEntity() => AcceptedTeamEntity(
        id: id,
        name: name,
        currentMembers: currentMembers,
        maxMembers: maxMembers,
      );
}

class AcceptedMemberResponseModel {
  final int id;
  final String role;
  final String joinedAt;

  const AcceptedMemberResponseModel({
    required this.id,
    required this.role,
    required this.joinedAt,
  });

  factory AcceptedMemberResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return AcceptedMemberResponseModel(
      id: data['id'] as int? ?? int.tryParse(data['id']?.toString() ?? '') ?? 0,
      role: data['role'] as String? ?? '',
      joinedAt: data['joined_at'] as String? ?? '',
    );
  }

  AcceptedMemberEntity toEntity() => AcceptedMemberEntity(
        id: id,
        role: role,
        joinedAt: joinedAt,
      );
}

class AcceptInvitationResponseModel {
  final String message;
  final AcceptedTeamResponseModel team;
  final AcceptedMemberResponseModel member;

  const AcceptInvitationResponseModel({
    required this.message,
    required this.team,
    required this.member,
  });

  factory AcceptInvitationResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? const {};

    return AcceptInvitationResponseModel(
      message: json['message'] as String? ?? '',
      team: AcceptedTeamResponseModel.fromJson(
        data['team'] as Map<String, dynamic>?,
      ),
      member: AcceptedMemberResponseModel.fromJson(
        data['member'] as Map<String, dynamic>?,
      ),
    );
  }

  AcceptedInvitationEntity toEntity() => AcceptedInvitationEntity(
        team: team.toEntity(),
        member: member.toEntity(),
      );
}
