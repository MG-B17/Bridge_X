import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProjectsListState extends Equatable {
  const ProjectsListState();

  @override
  List<Object?> get props => [];
}

class ProjectsListInitial extends ProjectsListState {
  const ProjectsListInitial();
}

class ProjectsListLoading extends ProjectsListState {
  final AllProjectsEntity? placeholderData;
  final int selectedFilter;

  const ProjectsListLoading({
    this.placeholderData,
    this.selectedFilter = 0,
  });

  @override
  List<Object?> get props => [placeholderData, selectedFilter];
}

class ProjectsListLoaded extends ProjectsListState {
  final AllProjectsEntity data;
  final int selectedFilter;

  const ProjectsListLoaded(this.data, {this.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class ProjectsListLoadingMore extends ProjectsListState {
  final AllProjectsEntity data;
  final int selectedFilter;

  const ProjectsListLoadingMore(this.data, {this.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class ProjectsListRefreshing extends ProjectsListState {
  final AllProjectsEntity data;
  final int selectedFilter;

  const ProjectsListRefreshing(this.data, {this.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class ProjectsListFailure extends ProjectsListState {
  final String errorMessage;
  final AllProjectsEntity? lastData;
  final int selectedFilter;

  const ProjectsListFailure(
    this.errorMessage, {
    this.lastData,
    this.selectedFilter = 0,
  });

  @override
  List<Object?> get props => [errorMessage, lastData, selectedFilter];
}
