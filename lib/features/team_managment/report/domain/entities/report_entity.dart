import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final int id;
  final int targetUserId;
  final int reporterUserId;
  final String description;
  final String status;

  const ReportEntity({
    required this.id,
    required this.targetUserId,
    required this.reporterUserId,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [id, targetUserId, reporterUserId, description, status];
}
