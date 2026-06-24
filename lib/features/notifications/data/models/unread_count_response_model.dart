import 'package:bridge_x/features/notifications/domain/entities/unread_count_entity.dart';

class UnreadCountResponseModel {
  final int unreadCount;

  const UnreadCountResponseModel({required this.unreadCount});

  factory UnreadCountResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final value = data['unread_count'] ?? data['unreadCount'];

    return UnreadCountResponseModel(
      unreadCount: value is int
          ? value
          : int.tryParse(value?.toString() ?? '') ?? 0,
    );
  }

  UnreadCountEntity toEntity() => UnreadCountEntity(unreadCount: unreadCount);
}
