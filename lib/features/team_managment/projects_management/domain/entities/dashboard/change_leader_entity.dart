import 'package:equatable/equatable.dart';

class ChangeLeaderEntity extends Equatable {
  final bool success;
  final String message;

  const ChangeLeaderEntity({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [success, message];
}
