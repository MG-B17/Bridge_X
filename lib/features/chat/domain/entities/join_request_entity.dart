import 'package:equatable/equatable.dart';

class JoinRequestEntity extends Equatable {
  final String requestId;
  final String roomId;
  final int userId;
  final String? username;
  final String status;
  final DateTime? createdAt;

  const JoinRequestEntity({
    required this.requestId,
    required this.roomId,
    required this.userId,
    this.username,
    required this.status,
    this.createdAt,
  });

  JoinRequestEntity copyWith({
    String? requestId,
    String? roomId,
    int? userId,
    String? username,
    String? status,
    DateTime? createdAt,
  }) {
    return JoinRequestEntity(
      requestId: requestId ?? this.requestId,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [requestId, roomId, userId, username, status, createdAt];
}
