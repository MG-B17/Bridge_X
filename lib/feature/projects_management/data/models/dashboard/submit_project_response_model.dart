import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/submit_project_entity.dart';

class SubmitProjectResponseModel {
  final bool success;
  final String message;
  final String projectStatus;

  SubmitProjectResponseModel({
    required this.success,
    required this.message,
    required this.projectStatus,
  });

  factory SubmitProjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubmitProjectResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      projectStatus: json['project_status'] as String? ?? '',
    );
  }

  SubmitProjectEntity toEntity() {
    return SubmitProjectEntity(
      success: success,
      message: message,
      projectStatus: projectStatus,
    );
  }
}
