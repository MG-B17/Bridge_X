import 'package:equatable/equatable.dart';

class InvitationEntity extends Equatable {
  final String invitationId;
  final String roomId;
  final int inviterId;
  final int inviteeId;
  final String? inviterName;
  final String? teamName;
  final String status;
  final DateTime? createdAt;

  const InvitationEntity({
    required this.invitationId,
    required this.roomId,
    required this.inviterId,
    required this.inviteeId,
    this.inviterName,
    this.teamName,
    required this.status,
    this.createdAt,
  });

  InvitationEntity copyWith({
    String? invitationId,
    String? roomId,
    int? inviterId,
    int? inviteeId,
    String? inviterName,
    String? teamName,
    String? status,
    DateTime? createdAt,
  }) {
    return InvitationEntity(
      invitationId: invitationId ?? this.invitationId,
      roomId: roomId ?? this.roomId,
      inviterId: inviterId ?? this.inviterId,
      inviteeId: inviteeId ?? this.inviteeId,
      inviterName: inviterName ?? this.inviterName,
      teamName: teamName ?? this.teamName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    invitationId,
    roomId,
    inviterId,
    inviteeId,
    inviterName,
    teamName,
    status,
    createdAt,
  ];
}
