import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/send_join_request_entity.dart';

class JoinRequestSubmissionResponseModel {
  final int joinRequestId;
  final int teamId;
  final int projectId;
  final String projectName;
  final String status;
  final String createdAt;

  const JoinRequestSubmissionResponseModel({
    required this.joinRequestId,
    required this.teamId,
    required this.projectId,
    required this.projectName,
    required this.status,
    required this.createdAt,
  });

  factory JoinRequestSubmissionResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return JoinRequestSubmissionResponseModel(
      joinRequestId: data['join_request_id'] as int? ??
          int.tryParse(data['join_request_id']?.toString() ?? '') ??
          0,
      teamId: data['team_id'] as int? ??
          int.tryParse(data['team_id']?.toString() ?? '') ??
          0,
      projectId: data['project_id'] as int? ??
          int.tryParse(data['project_id']?.toString() ?? '') ??
          0,
      projectName: data['project_name'] as String? ?? '',
      status: data['status'] as String? ?? '',
      createdAt: data['created_at'] as String? ?? '',
    );
  }
}

class SendJoinRequestResponseModel {
  final bool success;
  final String message;
  final JoinRequestSubmissionResponseModel? data;

  const SendJoinRequestResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SendJoinRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return SendJoinRequestResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? JoinRequestSubmissionResponseModel.fromJson(
              json['data'] as Map<String, dynamic>?,
            )
          : null,
    );
  }

  SendJoinRequestEntity toEntity() => SendJoinRequestEntity(
        joinRequestId: data?.joinRequestId ?? 0,
        teamId: data?.teamId ?? 0,
        projectId: data?.projectId ?? 0,
        projectName: data?.projectName ?? '',
        status: data?.status ?? '',
        createdAt: data?.createdAt ?? '',
        message: message,
      );
}
