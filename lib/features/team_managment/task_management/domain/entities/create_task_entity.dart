import 'package:equatable/equatable.dart';

class CreateTaskEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status;
  final int programmerId;
  final String programmerName;
  final String deadline;
  final String priority;
  final int estimatedHours;
  final String? gitLink;
  final List<String> tags;
  final int teamId;

  const CreateTaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.programmerId,
    required this.programmerName,
    required this.deadline,
    required this.priority,
    this.estimatedHours = 0,
    this.gitLink,
    required this.tags,
    required this.teamId,
  });

  @override
  List<Object?> get props => [
        id, title, description, status, programmerId, programmerName,
        deadline, priority, estimatedHours, gitLink, tags, teamId,
      ];
}
