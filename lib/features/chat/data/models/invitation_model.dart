import 'package:bridge_x/features/chat/domain/entities/invitation_entity.dart';

class InvitationModel extends InvitationEntity {
  const InvitationModel({
    required super.invitationId,
    required super.roomId,
    required super.inviterId,
    required super.inviteeId,
    super.inviterName,
    super.teamName,
    required super.status,
    super.createdAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      invitationId: json['invitation_id'] as String,
      roomId: json['room_id'] as String,
      inviterId: json['inviter_id'] as int,
      inviteeId: json['invitee_id'] as int,
      inviterName: json['inviter_name'] as String?,
      teamName: json['team_name'] as String?,
      status: json['status'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitation_id': invitationId,
      'room_id': roomId,
      'inviter_id': inviterId,
      'invitee_id': inviteeId,
      'inviter_name': inviterName,
      'team_name': teamName,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
