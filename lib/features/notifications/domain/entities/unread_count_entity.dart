import 'package:equatable/equatable.dart';

class UnreadCountEntity extends Equatable {
  final int unreadCount;

  const UnreadCountEntity({required this.unreadCount});

  @override
  List<Object?> get props => [unreadCount];
}
