import 'package:bridge_x/features/chat/domain/entities/join_request_entity.dart';

class JoinRequestModel extends JoinRequestEntity {
  const JoinRequestModel({
    required super.requestId,
    required super.roomId,
    required super.userId,
    super.username,
    required super.status,
    super.createdAt,
  });

  factory JoinRequestModel.fromJson(Map<String, dynamic> json) {
    return JoinRequestModel(
      requestId: json['request_id'] as String,
      roomId: json['room_id'] as String,
      userId: json['user_id'] as int,
      username: json['username'] as String?,
      status: json['status'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'room_id': roomId,
      'user_id': userId,
      'username': username,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
