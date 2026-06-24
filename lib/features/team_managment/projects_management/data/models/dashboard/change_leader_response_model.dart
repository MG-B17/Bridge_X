import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/change_leader_entity.dart';

class ChangeLeaderResponseModel {
  final bool success;
  final String message;

  ChangeLeaderResponseModel({
    required this.success,
    required this.message,
  });

  factory ChangeLeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangeLeaderResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }

  ChangeLeaderEntity toEntity() {
    return ChangeLeaderEntity(
      success: success,
      message: message,
    );
  }
}
