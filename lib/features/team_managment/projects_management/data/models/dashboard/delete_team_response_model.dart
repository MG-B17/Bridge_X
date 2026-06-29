import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/delete_team_entity.dart';

class DeleteTeamResponseModel {
  final bool success;
  final String message;

  DeleteTeamResponseModel({
    required this.success,
    required this.message,
  });

  factory DeleteTeamResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteTeamResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }

  DeleteTeamEntity toEntity() {
    return DeleteTeamEntity(
      success: success,
      message: message,
    );
  }
}
