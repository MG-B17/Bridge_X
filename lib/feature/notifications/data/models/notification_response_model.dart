import 'package:bridge_x/feature/notifications/data/models/notification_data_response_model.dart';
import 'package:bridge_x/feature/notifications/domain/entities/notification_entity.dart';

class NotificationResponseModel {
  final String id;
  final String type;
  final String message;
  final NotificationDataResponseModel data;
  final String? readAt;
  final String? createdAt;
  final bool isRead;

  const NotificationResponseModel({
    required this.id,
    required this.type,
    required this.message,
    required this.data,
    this.readAt,
    this.createdAt,
    required this.isRead,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final payload = json['notification'] as Map<String, dynamic>? ?? json;
    final readAt = _optionalString(payload['read_at'] ?? payload['readAt']);
    final isReadValue = payload['is_read'] ?? payload['isRead'];

    return NotificationResponseModel(
      id: _optionalString(payload['id']) ?? '',
      type: _optionalString(payload['type']) ?? '',
      message: _optionalString(payload['message']) ?? '',
      data: NotificationDataResponseModel.fromJson(
        payload['data'] is Map<String, dynamic>
            ? payload['data'] as Map<String, dynamic>
            : null,
      ),
      readAt: readAt,
      createdAt: _optionalString(payload['created_at'] ?? payload['createdAt']),
      isRead: _parseReadStatus(isReadValue, readAt),
    );
  }

  static String? _optionalString(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  static bool _parseReadStatus(dynamic value, String? readAt) {
    if (value is bool) return value;
    if (value is num) return value == 1;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return readAt != null;
  }

  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    type: type,
    message: message,
    notificationData: data.toEntity(),
    readAt: readAt,
    createdAt: createdAt,
    isRead: isRead,
  );
}
