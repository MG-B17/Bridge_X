// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_project_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitProjectResponseModel _$SubmitProjectResponseModelFromJson(
  Map<String, dynamic> json,
) => SubmitProjectResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  projectStatus: json['project_status'] as String,
);

Map<String, dynamic> _$SubmitProjectResponseModelToJson(
  SubmitProjectResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'project_status': instance.projectStatus,
};
