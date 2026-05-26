sealed class ProjectsTabEvent {
  const ProjectsTabEvent();
}

class LoadProjectsTab extends ProjectsTabEvent {
  const LoadProjectsTab();
}

class RefreshProjectsTab extends ProjectsTabEvent {
  const RefreshProjectsTab();
}

class LoadMoreProjectsTab extends ProjectsTabEvent {
  const LoadMoreProjectsTab();
}
