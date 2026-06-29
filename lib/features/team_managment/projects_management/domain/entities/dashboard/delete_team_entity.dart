import 'package:equatable/equatable.dart';

class DeleteTeamEntity extends Equatable {
  final bool success;
  final String message;

  const DeleteTeamEntity({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [success, message];
}
