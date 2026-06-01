import 'package:bridge_x/feature/team_evaluation/domain/entities/evaluation_member_entity.dart';

class EvaluationMemberModel {
  final int programmerId;
  final String name;
  final String track;
  final String? avatarUrl;

  const EvaluationMemberModel({
    required this.programmerId,
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  factory EvaluationMemberModel.fromJson(Map<String, dynamic> json) {
    return EvaluationMemberModel(
      programmerId: json['programmer_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      track: json['track'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  EvaluationMemberEntity toEntity() => EvaluationMemberEntity(
        programmerId: programmerId,
        name: name,
        track: track,
        avatarUrl: avatarUrl,
      );
}
