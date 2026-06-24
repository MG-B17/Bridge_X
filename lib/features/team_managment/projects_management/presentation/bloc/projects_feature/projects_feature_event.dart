import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:equatable/equatable.dart';

sealed class ProjectsFeatureEvent extends Equatable {
  const ProjectsFeatureEvent();

  @override
  List<Object?> get props => [];
}

class ProjectsFeatureStarted extends ProjectsFeatureEvent {
  const ProjectsFeatureStarted();
}

class ProjectsLoadAllTabsRequested extends ProjectsFeatureEvent {
  const ProjectsLoadAllTabsRequested();
}

class ProjectsPullToRefreshRequested extends ProjectsFeatureEvent {
  const ProjectsPullToRefreshRequested();
}

class ProjectsLoadMoreRequested extends ProjectsFeatureEvent {
  final ProjectsTabType tabType;
  const ProjectsLoadMoreRequested(this.tabType);

  @override
  List<Object?> get props => [tabType];
}

class ProjectsTabChanged extends ProjectsFeatureEvent {
  final int index;
  const ProjectsTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class ProjectDashboardOpened extends ProjectsFeatureEvent {
  final int projectId;
  const ProjectDashboardOpened(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class ProjectDashboardRefreshRequested extends ProjectsFeatureEvent {
  const ProjectDashboardRefreshRequested();
}

class ProjectDetailsOpened extends ProjectsFeatureEvent {
  final int projectId;
  final String status;
  const ProjectDetailsOpened(this.projectId, this.status);

  @override
  List<Object?> get props => [projectId, status];
}

class ProjectDetailsRefreshRequested extends ProjectsFeatureEvent {
  const ProjectDetailsRefreshRequested();
}

class CompletedProjectDetailsOpened extends ProjectsFeatureEvent {
  final int projectId;
  const CompletedProjectDetailsOpened(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class CompletedProjectDetailsRefreshRequested extends ProjectsFeatureEvent {
  const CompletedProjectDetailsRefreshRequested();
}

class TeamSettingsOpened extends ProjectsFeatureEvent {
  final int projectId;
  const TeamSettingsOpened(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class TeamSettingsRefreshRequested extends ProjectsFeatureEvent {
  const TeamSettingsRefreshRequested();
}

class SubmitProjectConfirmed extends ProjectsFeatureEvent {
  final int projectId;
  const SubmitProjectConfirmed(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class ChangeLeaderRequested extends ProjectsFeatureEvent {
  final int projectId;
  final int userId;
  const ChangeLeaderRequested(this.projectId, this.userId);

  @override
  List<Object?> get props => [projectId, userId];
}

class DeleteTeamRequested extends ProjectsFeatureEvent {
  final int projectId;
  const DeleteTeamRequested(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class ClearSubmitProjectAction extends ProjectsFeatureEvent {
  const ClearSubmitProjectAction();
}

class ClearChangeLeaderAction extends ProjectsFeatureEvent {
  const ClearChangeLeaderAction();
}

class ClearDeleteTeamAction extends ProjectsFeatureEvent {
  const ClearDeleteTeamAction();
}

class ProjectsExternalMutationCompleted extends ProjectsFeatureEvent {
  const ProjectsExternalMutationCompleted();
}
