import 'package:equatable/equatable.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/invitation_details_entity.dart';

class ProjectInvitationEntity extends Equatable {
  final String id;
  final String projectName;
  final String projectType;
  final String status;
  final String membersCount;
  final String creatorName;
  final String description;
  final String leaderName;
  final String roleName;
  final List<String> memberAvatars;
  final String logoAssetName; // if using a local asset/logo

  const ProjectInvitationEntity({
    required this.id,
    required this.projectName,
    required this.projectType,
    required this.status,
    required this.membersCount,
    required this.creatorName,
    required this.description,
    required this.leaderName,
    required this.roleName,
    required this.memberAvatars,
    this.logoAssetName = '',
  });

  factory ProjectInvitationEntity.fromInvitationEntity(
    InvitationEntity invitation,
  ) {
    return ProjectInvitationEntity(
      id: invitation.invitationId.toString(),
      projectName: invitation.team.project.title,
      projectType: invitation.team.project.category,
      status: invitation.status,
      membersCount: invitation.team.membersCount.toString(),
      creatorName: invitation.invitedBy.name,
      description: invitation.team.project.description,
      leaderName: invitation.invitedBy.name,
      roleName: invitation.invitedBy.track,
      memberAvatars: invitation.team.membersAvatars,
    );
  }

  factory ProjectInvitationEntity.fromInvitationDetailsEntity(
    InvitationDetailsEntity invitation,
  ) {
    return ProjectInvitationEntity(
      id: invitation.invitationId.toString(),
      projectName: invitation.team.project.title,
      projectType: invitation.team.project.category,
      status: invitation.status,
      membersCount: invitation.team.membersCount.toString(),
      creatorName: invitation.invitedBy.name,
      description: invitation.team.project.description,
      leaderName: invitation.invitedBy.name,
      roleName: invitation.invitedBy.track,
      memberAvatars: invitation.team.members
          .map((member) => member.avatarUrl)
          .whereType<String>()
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        projectName,
        projectType,
        status,
        membersCount,
        creatorName,
        description,
        leaderName,
        roleName,
        memberAvatars,
        logoAssetName,
      ];
}
