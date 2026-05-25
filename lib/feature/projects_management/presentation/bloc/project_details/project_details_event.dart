import 'package:equatable/equatable.dart';

sealed class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjectDetails extends ProjectDetailsEvent {
  final int projectId;
  final String status;

  const LoadProjectDetails({
    required this.projectId,
    required this.status,
  });

  @override
  List<Object?> get props => [projectId, status];
}

class RefreshProjectDetails extends ProjectDetailsEvent {
  const RefreshProjectDetails();
}

class RetryProjectDetails extends ProjectDetailsEvent {
  const RetryProjectDetails();
}
