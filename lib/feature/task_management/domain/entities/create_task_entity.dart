import 'package:equatable/equatable.dart';

class CreateTaskEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status;
  final int programmerId;
  final String programmerName;
  final String deadline;
  final int priority;
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
    this.gitLink,
    required this.tags,
    required this.teamId,
  });

  @override
  List<Object?> get props => [id, title, description, status, programmerId, deadline, priority, gitLink, tags, teamId];
}
