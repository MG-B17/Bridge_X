import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProjectDashboardState extends Equatable {
  const ProjectDashboardState();

  @override
  List<Object?> get props => [];
}

class ProjectDashboardInitial extends ProjectDashboardState {
  const ProjectDashboardInitial();
}

class ProjectDashboardLoading extends ProjectDashboardState {
  final ProjectDashboardEntity? placeholderData;

  const ProjectDashboardLoading({this.placeholderData});

  @override
  List<Object?> get props => [placeholderData];
}

class ProjectDashboardLoaded extends ProjectDashboardState {
  final ProjectDashboardEntity dashboard;

  const ProjectDashboardLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ProjectDashboardRefreshing extends ProjectDashboardState {
  final ProjectDashboardEntity dashboard;

  const ProjectDashboardRefreshing({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ProjectDashboardError extends ProjectDashboardState {
  final String message;

  const ProjectDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
