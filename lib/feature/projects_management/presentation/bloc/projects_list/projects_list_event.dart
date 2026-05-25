import 'package:equatable/equatable.dart';

sealed class ProjectsListEvent extends Equatable {
  const ProjectsListEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjects extends ProjectsListEvent {
  const LoadProjects();
}

class RefreshProjects extends ProjectsListEvent {
  const RefreshProjects();
}

class LoadMoreProjects extends ProjectsListEvent {
  const LoadMoreProjects();
}

class ChangeFilter extends ProjectsListEvent {
  final int filterIndex;

  const ChangeFilter(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}
