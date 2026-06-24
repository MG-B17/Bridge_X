import 'package:bridge_x/features/invitaions/data/models/join_request_response_model.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_requests_entity.dart';

class JoinRequestsResponseModel {
  final bool success;
  final List<JoinRequestResponseModel> data;
  final int count;

  const JoinRequestsResponseModel({
    required this.success,
    required this.data,
    required this.count,
  });

  factory JoinRequestsResponseModel.fromJson(Map<String, dynamic> json) {
    final dataList = (json['data'] as List<dynamic>?)
            ?.map(
              (e) => JoinRequestResponseModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
    return JoinRequestsResponseModel(
      success: json['success'] as bool? ?? false,
      data: dataList,
      count: json['count'] as int? ?? dataList.length,
    );
  }

  JoinRequestsEntity toEntity() => JoinRequestsEntity(
        requests: data.map((e) => e.toEntity()).toList(),
        count: count,
      );
}
