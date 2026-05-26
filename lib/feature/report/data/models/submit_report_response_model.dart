import 'package:bridge_x/feature/report/domain/entities/report_entity.dart';

class SubmitReportResponseModel extends ReportEntity {
  const SubmitReportResponseModel({
    required super.id,
    required super.targetUserId,
    required super.reporterUserId,
    required super.description,
    required super.status,
  });

  factory SubmitReportResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return SubmitReportResponseModel(
      id: data['id'] as int? ?? 0,
      targetUserId: data['target_user_id'] as int? ?? 0,
      reporterUserId: data['reporter_user_id'] as int? ?? 0,
      description: data['description'] as String? ?? '',
      status: data['status'] as String? ?? '',
    );
  }
}
