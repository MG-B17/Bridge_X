import 'package:bridge_x/feature/invitaions/domain/entities/leader_entity.dart';

class LeaderResponseModel {
  final String name;
  final String track;
  final String? avatarUrl;

  const LeaderResponseModel({
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  factory LeaderResponseModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    return LeaderResponseModel(
      name: data['name'] as String? ?? '',
      track: data['track'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
    );
  }

  LeaderEntity toEntity() => LeaderEntity(
        name: name,
        track: track,
        avatarUrl: avatarUrl,
      );
}
