import 'package:equatable/equatable.dart';

sealed class ProjectDashboardEvent extends Equatable {
  const ProjectDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends ProjectDashboardEvent {
  final int projectId;

  const LoadDashboard(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class RefreshDashboard extends ProjectDashboardEvent {
  const RefreshDashboard();
}

class RetryDashboard extends ProjectDashboardEvent {
  const RetryDashboard();
}
