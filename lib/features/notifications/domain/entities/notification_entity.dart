import 'package:bridge_x/features/notifications/domain/entities/notification_data_entity.dart';
import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String type;
  final String message;
  final NotificationDataEntity notificationData;
  final String? readAt;
  final String? createdAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.message,
    required this.notificationData,
    this.readAt,
    this.createdAt,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? type,
    String? message,
    NotificationDataEntity? notificationData,
    String? readAt,
    String? createdAt,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      message: message ?? this.message,
      notificationData: notificationData ?? this.notificationData,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    message,
    notificationData,
    readAt,
    createdAt,
    isRead,
  ];
}
