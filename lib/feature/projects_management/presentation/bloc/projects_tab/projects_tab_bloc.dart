import 'package:bridge_x/feature/projects_management/domain/entities/project_item_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_projects_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'projects_tab_event.dart';
import 'projects_tab_state.dart';

class ProjectsTabBloc extends Bloc<ProjectsTabEvent, ProjectsTabState> {
  final GetProjectsUseCase getProjectsUseCase;
  final String? status;

  int _currentPage = 1;

  static final List<ProjectItemEntity> _placeholder = List.generate(
    3,
    (i) => ProjectItemEntity(
      id: i,
      title: '',
      description: '',
      category: '',
      estimatedDurationDays: 0,
      expectedEndDate: '',
      projectCompletionPercentage: 0.0,
      myCompletionPercentage: 0.0,
      mySpecialization: '',
    ),
  );

  ProjectsTabBloc({
    required this.getProjectsUseCase,
    this.status,
  }) : super(const ProjectsTabInitial()) {
    on<LoadProjectsTab>(_onLoad);
    on<RefreshProjectsTab>(_onRefresh);
    on<LoadMoreProjectsTab>(_onLoadMore);
  }

  List<ProjectItemEntity> _currentProjects() => switch (state) {
        ProjectsTabLoaded(:final projects) => projects,
        ProjectsTabLoadingMore(:final projects) => projects,
        ProjectsTabRefreshing(:final projects) => projects,
        ProjectsTabLoading(:final placeholderData) => placeholderData,
        ProjectsTabFailure(:final lastData) => lastData ?? _placeholder,
        _ => _placeholder,
      };

  Future<void> _onLoad(
    LoadProjectsTab event,
    Emitter<ProjectsTabState> emit,
  ) async {
    if (state is ProjectsTabLoading || state is ProjectsTabRefreshing) return;
    _currentPage = 1;

    emit(ProjectsTabLoading(placeholderData: _placeholder));

    final result = await getProjectsUseCase(
      GetProjectsParams(page: 1, status: status),
    );
    result.fold(
      (failure) => emit(ProjectsTabFailure(failure.message)),
      (data) => emit(ProjectsTabLoaded(
        projects: data.projects,
        hasMore: data.hasMore,
      )),
    );
  }

  Future<void> _onRefresh(
    RefreshProjectsTab event,
    Emitter<ProjectsTabState> emit,
  ) async {
    if (state is ProjectsTabLoading || state is ProjectsTabRefreshing) return;
    _currentPage = 1;

    final current = _currentProjects();
    emit(ProjectsTabRefreshing(projects: current));

    final result = await getProjectsUseCase(
      GetProjectsParams(page: 1, status: status),
    );
    result.fold(
      (failure) => emit(ProjectsTabFailure(failure.message, lastData: current)),
      (data) => emit(ProjectsTabLoaded(
        projects: data.projects,
        hasMore: data.hasMore,
      )),
    );
  }

  Future<void> _onLoadMore(
    LoadMoreProjectsTab event,
    Emitter<ProjectsTabState> emit,
  ) async {
    if (state is! ProjectsTabLoaded) return;
    final loaded = state as ProjectsTabLoaded;
    if (!loaded.hasMore) return;

    emit(ProjectsTabLoadingMore(projects: loaded.projects));

    final nextPage = _currentPage + 1;
    final result = await getProjectsUseCase(
      GetProjectsParams(page: nextPage, status: status),
    );
    result.fold(
      (_) => emit(ProjectsTabLoaded(
        projects: loaded.projects,
        hasMore: loaded.hasMore,
      )),
      (data) {
        _currentPage = nextPage;
        emit(ProjectsTabLoaded(
          projects: [...loaded.projects, ...data.projects],
          hasMore: data.hasMore,
        ));
      },
    );
  }
}
