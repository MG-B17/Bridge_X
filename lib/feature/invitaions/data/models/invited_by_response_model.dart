import 'package:bridge_x/feature/invitaions/domain/entities/invited_by_entity.dart';

class InvitedByResponseModel {
  final String name;
  final String track;
  final String? avatarUrl;

  const InvitedByResponseModel({
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  factory InvitedByResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return InvitedByResponseModel(
      name: data['name'] as String? ?? '',
      track: data['track'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
    );
  }

  InvitedByEntity toEntity() => InvitedByEntity(
        name: name,
        track: track,
        avatarUrl: avatarUrl,
      );
}
