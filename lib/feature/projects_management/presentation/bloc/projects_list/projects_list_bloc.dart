import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/completed_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_all_projects_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsListBloc extends Bloc<ProjectsListEvent, ProjectsListState> {
  final GetAllProjectsUseCase getAllProjectsUseCase;

  int _currentPage = 1;

  static final AllProjectsEntity _placeholder = AllProjectsEntity(
    ongoingProjects: List.generate(
      3,
      (i) => OngoingProjectEntity(
        id: i,
        title: '',
        description: '',
        category: '',
        estimatedDurationDays: 0,
        expectedEndDate: '',
        projectCompletionPercentage: 0.0,
        myCompletionPercentage: 0.0,
        mySpecialization: '',
        memberCount: 0,
      ),
    ),
    completedProjects: List.generate(
      2,
      (i) => CompletedProjectEntity(
        id: i + 100,
        title: '',
        description: '',
        category: '',
        estimatedDurationDays: 0,
        expectedEndDate: '',
        projectCompletionPercentage: 0.0,
        myCompletionPercentage: 0.0,
        mySpecialization: '',
      ),
    ),
  );

  ProjectsListBloc({required this.getAllProjectsUseCase})
      : super(const ProjectsListInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<RefreshProjects>(_onRefreshProjects);
    on<LoadMoreProjects>(_onLoadMoreProjects);
    on<ChangeFilter>(_onChangeFilter);
  }

  int _getFilter() => switch (state) {
        ProjectsListLoaded(:final selectedFilter) => selectedFilter,
        ProjectsListLoadingMore(:final selectedFilter) => selectedFilter,
        ProjectsListRefreshing(:final selectedFilter) => selectedFilter,
        ProjectsListLoading(:final selectedFilter) => selectedFilter,
        ProjectsListFailure(:final selectedFilter) => selectedFilter,
        _ => 0,
      };

  AllProjectsEntity _currentData() => switch (state) {
        ProjectsListLoaded(:final data) => data,
        ProjectsListLoadingMore(:final data) => data,
        ProjectsListRefreshing(:final data) => data,
        ProjectsListLoading(:final placeholderData) =>
          placeholderData ?? _placeholder,
        ProjectsListFailure(:final lastData) => lastData ?? _placeholder,
        _ => _placeholder,
      };

  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectsListState> emit,
  ) async {
    if (state is ProjectsListLoading || state is ProjectsListRefreshing) return;
    _currentPage = 1;

    emit(ProjectsListLoading(
      placeholderData: _placeholder,
      selectedFilter: _getFilter(),
    ));

    final result = await getAllProjectsUseCase(const GetAllProjectsParams());
    result.fold(
      (failure) => emit(ProjectsListFailure(
        failure.message,
        lastData: _currentData(),
        selectedFilter: _getFilter(),
      )),
      (data) => emit(ProjectsListLoaded(data, selectedFilter: _getFilter())),
    );
  }

  Future<void> _onRefreshProjects(
    RefreshProjects event,
    Emitter<ProjectsListState> emit,
  ) async {
    if (state is ProjectsListLoading || state is ProjectsListRefreshing) return;
    _currentPage = 1;

    final data = _currentData();
    emit(ProjectsListRefreshing(data, selectedFilter: _getFilter()));

    final result = await getAllProjectsUseCase(const GetAllProjectsParams());
    result.fold(
      (failure) => emit(ProjectsListFailure(
        failure.message,
        lastData: data,
        selectedFilter: _getFilter(),
      )),
      (data) => emit(ProjectsListLoaded(data, selectedFilter: _getFilter())),
    );
  }

  Future<void> _onLoadMoreProjects(
    LoadMoreProjects event,
    Emitter<ProjectsListState> emit,
  ) async {
    if (state is! ProjectsListLoaded ||
        !(state as ProjectsListLoaded).data.hasMore) {
      return;
    }
    if (state is ProjectsListLoadingMore) return;

    final data = _currentData();
    emit(ProjectsListLoadingMore(data, selectedFilter: _getFilter()));

    final nextPage = _currentPage + 1;
    final result = await getAllProjectsUseCase(GetAllProjectsParams(page: nextPage));
    result.fold(
      (_) => emit(ProjectsListLoaded(data, selectedFilter: _getFilter())),
      (newData) {
        _currentPage = nextPage;
        emit(ProjectsListLoaded(
          AllProjectsEntity(
            ongoingProjects: [...data.ongoingProjects, ...newData.ongoingProjects],
            completedProjects: [...data.completedProjects, ...newData.completedProjects],
            currentPage: newData.currentPage,
            totalPages: newData.totalPages,
            hasMore: newData.hasMore,
          ),
          selectedFilter: _getFilter(),
        ));
      },
    );
  }

  void _onChangeFilter(ChangeFilter event, Emitter<ProjectsListState> emit) {
    final data = _currentData();
    emit(switch (state) {
      ProjectsListLoaded _ => ProjectsListLoaded(data, selectedFilter: event.filterIndex),
      ProjectsListLoadingMore _ => ProjectsListLoadingMore(data, selectedFilter: event.filterIndex),
      ProjectsListRefreshing _ => ProjectsListRefreshing(data, selectedFilter: event.filterIndex),
      _ => ProjectsListLoading(placeholderData: _placeholder, selectedFilter: event.filterIndex),
    });
  }
}
