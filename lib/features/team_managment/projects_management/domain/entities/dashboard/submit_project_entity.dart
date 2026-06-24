import 'package:equatable/equatable.dart';

class SubmitProjectEntity extends Equatable {
  final bool success;
  final String message;
  final String projectStatus;

  const SubmitProjectEntity({
    required this.success,
    required this.message,
    required this.projectStatus,
  });

  @override
  List<Object?> get props => [success, message, projectStatus];
}
