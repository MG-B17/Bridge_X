import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';

class ReportedUserInfoResponseModel extends ReportedUserInfoEntity {
  const ReportedUserInfoResponseModel({
    required super.id,
    required super.name,
    required super.track,
    super.avatarUrl,
  });

  factory ReportedUserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return ReportedUserInfoResponseModel(
      id: data['id'] as int? ?? 0,
      name: data['name'] as String? ?? '',
      track: data['track'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
    );
  }
}
