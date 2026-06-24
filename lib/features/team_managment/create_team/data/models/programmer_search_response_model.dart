import 'package:bridge_x/features/team_managment/create_team/domain/entity/programmer_search_entity.dart';

class ProgrammerSearchResponseModel {
  final int id;
  final String? userName;
  final String fullName;
  final String? avatarUrl;
  final String? track;

  const ProgrammerSearchResponseModel({
    required this.id,
    this.userName,
    required this.fullName,
    this.avatarUrl,
    this.track,
  });

  factory ProgrammerSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return ProgrammerSearchResponseModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userName: _optionalString(json['user_name'] ?? json['userName']),
      fullName: _optionalString(json['full_name'] ?? json['fullName']) ?? '',
      avatarUrl: _optionalString(json['avatar_url'] ?? json['avatarUrl']),
      track: _optionalString(json['track']),
    );
  }

  static String? _optionalString(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  ProgrammerSearchEntity toEntity() => ProgrammerSearchEntity(
    id: id,
    userName: userName,
    fullName: fullName,
    avatarUrl: avatarUrl,
    track: track,
  );
}
