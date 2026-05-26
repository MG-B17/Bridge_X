import 'package:bridge_x/feature/projects_management/domain/entities/project_item_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProjectsTabState extends Equatable {
  const ProjectsTabState();

  @override
  List<Object?> get props => [];
}

class ProjectsTabInitial extends ProjectsTabState {
  const ProjectsTabInitial();
}

class ProjectsTabLoading extends ProjectsTabState {
  final List<ProjectItemEntity> placeholderData;

  const ProjectsTabLoading({required this.placeholderData});

  @override
  List<Object?> get props => [placeholderData];
}

class ProjectsTabLoaded extends ProjectsTabState {
  final List<ProjectItemEntity> projects;
  final bool hasMore;

  const ProjectsTabLoaded({required this.projects, required this.hasMore});

  @override
  List<Object?> get props => [projects, hasMore];
}

class ProjectsTabRefreshing extends ProjectsTabState {
  final List<ProjectItemEntity> projects;

  const ProjectsTabRefreshing({required this.projects});

  @override
  List<Object?> get props => [projects];
}

class ProjectsTabLoadingMore extends ProjectsTabState {
  final List<ProjectItemEntity> projects;

  const ProjectsTabLoadingMore({required this.projects});

  @override
  List<Object?> get props => [projects];
}

class ProjectsTabFailure extends ProjectsTabState {
  final String errorMessage;
  final List<ProjectItemEntity>? lastData;

  const ProjectsTabFailure(this.errorMessage, {this.lastData});

  @override
  List<Object?> get props => [errorMessage, lastData];
}
