import 'package:equatable/equatable.dart';

class ProjectMemberEntity extends Equatable {
  final String name;
  final String? avatarUrl;
  final String track;
  final String tasksSummary;

  const ProjectMemberEntity({
    required this.name,
    required this.avatarUrl,
    required this.track,
    required this.tasksSummary,
  });

  @override
  List<Object?> get props => [name, avatarUrl, track, tasksSummary];
}
