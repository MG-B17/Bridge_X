import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_completed_project_details_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/completed_project_details/completed_project_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedProjectDetailsCubit extends Cubit<CompletedProjectDetailsState> {
  final GetCompletedProjectDetailsUseCase _useCase;
  int? _projectId;

  static const CompletedProjectDetailsEntity _placeholder =
      CompletedProjectDetailsEntity(
    id: 0,
    title: '',
    description: '',
    status: 'completed',
    myTrack: '',
    teamMembers: [],
    category: '',
    durationDays: 0,
    completionDate: '',
    feedbacks: [],
    myRating: 0,
    starsPercentage: 0,
    impacts: [],
  );

  CompletedProjectDetailsCubit({
    required GetCompletedProjectDetailsUseCase useCase,
  })  : _useCase = useCase,
        super(const CompletedProjectDetailsInitial());

  CompletedProjectDetailsEntity _currentData() => switch (state) {
        CompletedProjectDetailsLoaded(:final data) => data,
        CompletedProjectDetailsRefreshing(:final data) => data,
        CompletedProjectDetailsLoading(:final placeholderData) =>
          placeholderData ?? _placeholder,
        _ => _placeholder,
      };

  Future<void> load(int projectId) async {
    if (_projectId == projectId &&
        (state is CompletedProjectDetailsLoading ||
            state is CompletedProjectDetailsRefreshing)) {
      return;
    }
    _projectId = projectId;
    emit(CompletedProjectDetailsLoading(placeholderData: _placeholder));

    final result = await _useCase(
      GetCompletedProjectDetailsParams(projectId: projectId),
    );

    if (isClosed || _projectId != projectId) return;

    result.fold(
      (failure) => emit(CompletedProjectDetailsFailure(failure.message)),
      (data) => emit(CompletedProjectDetailsLoaded(data)),
    );
  }

  Future<void> refresh() async {
    final projectId = _projectId;
    if (projectId == null) return;
    if (state is CompletedProjectDetailsLoading ||
        state is CompletedProjectDetailsRefreshing) {
      return;
    }

    final data = _currentData();
    emit(CompletedProjectDetailsRefreshing(data));

    final result = await _useCase(
      GetCompletedProjectDetailsParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(CompletedProjectDetailsFailure(failure.message)),
      (data) => emit(CompletedProjectDetailsLoaded(data)),
    );
  }

  void retry() {
    final projectId = _projectId;
    if (projectId != null) load(projectId);
  }
}
