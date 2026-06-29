import 'package:equatable/equatable.dart';

class SendJoinRequestEntity extends Equatable {
  final int joinRequestId;
  final int teamId;
  final int projectId;
  final String projectName;
  final String status;
  final String createdAt;
  final String message;

  const SendJoinRequestEntity({
    required this.joinRequestId,
    required this.teamId,
    required this.projectId,
    required this.projectName,
    required this.status,
    required this.createdAt,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        joinRequestId,
        teamId,
        projectId,
        projectName,
        status,
        createdAt,
        message,
      ];
}
