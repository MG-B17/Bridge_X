import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_project_response_model.g.dart';

@JsonSerializable()
class SubmitProjectResponseModel {
  final bool success;
  final String message;
  @JsonKey(name: 'project_status')
  final String projectStatus;

  SubmitProjectResponseModel({
    required this.success,
    required this.message,
    required this.projectStatus,
  });

  factory SubmitProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitProjectResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitProjectResponseModelToJson(this);

  SubmitProjectEntity toEntity() {
    return SubmitProjectEntity(
      success: success,
      message: message,
      projectStatus: projectStatus,
    );
  }
}
