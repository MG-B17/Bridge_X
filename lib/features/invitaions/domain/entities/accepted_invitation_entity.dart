import 'package:bridge_x/features/invitaions/domain/entities/accepted_member_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accepted_team_entity.dart';
import 'package:equatable/equatable.dart';

class AcceptedInvitationEntity extends Equatable {
  final AcceptedTeamEntity team;
  final AcceptedMemberEntity member;

  const AcceptedInvitationEntity({
    required this.team,
    required this.member,
  });

  @override
  List<Object?> get props => [team, member];
}
