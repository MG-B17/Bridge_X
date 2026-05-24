import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects/domain/entities/completed_project_entity.dart';
import 'package:bridge_x/feature/projects/domain/entities/ongoing_project_entity.dart';
import 'package:bridge_x/feature/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:bridge_x/feature/projects/presentation/controller/all_projects_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProjectsCubit extends Cubit<AllProjectsState> {
  final GetAllProjectsUseCase getAllProjectsUseCase;

  AllProjectsCubit({required this.getAllProjectsUseCase}) : super(const AllProjectsInitial());

  static final AllProjectsEntity _placeholderData = AllProjectsEntity(
    ongoingProjects: List.generate(
      3,
      (i) => OngoingProjectEntity(
        id: i,
        title: 'Loading Project ${i + 1}',
        description: 'Loading description...',
        category: 'Loading',
        estimatedDurationDays: 30,
        expectedEndDate: '2024-12-31',
        projectCompletionPercentage: 0.5,
        myCompletionPercentage: 0.3,
        mySpecialization: 'Developer',
      ),
    ),
    completedProjects: List.generate(
      2,
      (i) => CompletedProjectEntity(
        id: i + 100,
        title: 'Completed Project ${i + 1}',
        description: 'Loading description...',
        category: 'Loading',
        estimatedDurationDays: 30,
        expectedEndDate: '2024-06-30',
        projectCompletionPercentage: 1.0,
        myCompletionPercentage: 1.0,
        mySpecialization: 'Developer',
      ),
    ),
  );

  int _currentPage = 1;

  int get _filter => state.selectedFilter;

  AllProjectsEntity _currentData() => switch (state) {
    AllProjectsLoaded(:final data) => data,
    AllProjectsLoadingMore(:final data) => data,
    AllProjectsRefreshing(:final data) => data,
    AllProjectsLoading(:final placeholderData) => placeholderData ?? _placeholderData,
    AllProjectsFailure(:final lastData) => lastData ?? _placeholderData,
    _ => _placeholderData,
  };

  Future<void> loadProjects() async {
    if (state is AllProjectsLoading || state is AllProjectsRefreshing) return;
    _currentPage = 1;

    emit(AllProjectsLoading(placeholderData: _placeholderData, selectedFilter: _filter));

    final result = await getAllProjectsUseCase(NoParams());
    result.fold(
      (failure) => emit(
        AllProjectsFailure(failure.message, lastData: _currentData(), selectedFilter: _filter),
      ),
      (data) => emit(AllProjectsLoaded(data, selectedFilter: _filter)),
    );
  }

  Future<void> refreshProjects() async {
    if (state is AllProjectsLoading || state is AllProjectsRefreshing) return;
    _currentPage = 1;

    final data = _currentData();
    emit(AllProjectsRefreshing(data, selectedFilter: _filter));

    final result = await getAllProjectsUseCase(NoParams());
    result.fold(
      (failure) =>
          emit(AllProjectsFailure(failure.message, lastData: data, selectedFilter: _filter)),
      (data) => emit(AllProjectsLoaded(data, selectedFilter: _filter)),
    );
  }

  Future<void> loadMore() async {
    if (state is! AllProjectsLoaded || !(state as AllProjectsLoaded).data.hasMore) return;
    if (state is AllProjectsLoadingMore) return;

    final data = _currentData();
    emit(AllProjectsLoadingMore(data, selectedFilter: _filter));

    final nextPage = _currentPage + 1;
    final result = await getAllProjectsUseCase.loadMore(nextPage);
    result.fold((_) => emit(AllProjectsLoaded(data, selectedFilter: _filter)), (newData) {
      _currentPage = nextPage;
      emit(
        AllProjectsLoaded(
          AllProjectsEntity(
            ongoingProjects: [...data.ongoingProjects, ...newData.ongoingProjects],
            completedProjects: [...data.completedProjects, ...newData.completedProjects],
            currentPage: newData.currentPage,
            totalPages: newData.totalPages,
            hasMore: newData.hasMore,
          ),
          selectedFilter: _filter,
        ),
      );
    });
  }

  void changeFilter(int filterIndex) {
    final data = _currentData();
    emit(switch (state) {
      AllProjectsLoaded _ => AllProjectsLoaded(data, selectedFilter: filterIndex),
      AllProjectsLoadingMore _ => AllProjectsLoadingMore(data, selectedFilter: filterIndex),
      AllProjectsRefreshing _ => AllProjectsRefreshing(data, selectedFilter: filterIndex),
      _ => AllProjectsLoading(placeholderData: _placeholderData, selectedFilter: filterIndex),
    });
  }
}
