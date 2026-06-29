import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/attachment_entity.dart';

class AttachmentResponseModel {
  final int id;
  final String name;
  final String? url;
  final String? type;

  const AttachmentResponseModel({
    required this.id,
    required this.name,
    this.url,
    this.type,
  });

  factory AttachmentResponseModel.fromJson(Map<String, dynamic> json) {
    return AttachmentResponseModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      url: json['url'] as String?,
      type: json['type'] as String?,
    );
  }

  AttachmentEntity toEntity() => AttachmentEntity(
        id: id,
        name: name,
        url: url,
        type: type,
      );
}
