import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_details/project_details_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_details/project_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectDetailsUseCase getProjectDetailsUseCase;

  int? _projectId;
  String? _status;

  static const ProjectDetailsEntity _placeholder = ProjectDetailsEntity(
    id: 0,
    title: '',
    description: '',
    status: '',
    myTrack: '',
    githubLink: '',
    teamMembers: [],
    teamMembersCount: 0,
  );

  ProjectDetailsBloc({required this.getProjectDetailsUseCase})
      : super(const ProjectDetailsInitial()) {
    on<LoadProjectDetails>(_onLoadProjectDetails);
    on<RefreshProjectDetails>(_onRefreshProjectDetails);
    on<RetryProjectDetails>(_onRetryProjectDetails);
  }

  ProjectDetailsEntity _currentData() => switch (state) {
        ProjectDetailsLoaded(:final data) => data,
        ProjectDetailsRefreshing(:final data) => data,
        ProjectDetailsLoading(:final placeholderData) =>
          placeholderData ?? _placeholder,
        _ => _placeholder,
      };

  Future<void> _onLoadProjectDetails(
    LoadProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final sameParams =
        _projectId == event.projectId && _status == event.status;

    if (sameParams &&
        (state is ProjectDetailsLoading ||
            state is ProjectDetailsRefreshing)) {
      return;
    }

    _projectId = event.projectId;
    _status = event.status;

    emit(ProjectDetailsLoading(placeholderData: _placeholder));

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(
        projectId: event.projectId,
        status: event.status,
      ),
    );

    if (isClosed) return;
    if (_projectId != event.projectId || _status != event.status) return;

    result.fold(
      (failure) => emit(ProjectDetailsFailure(failure.message)),
      (data) => emit(ProjectDetailsLoaded(data)),
    );
  }

  Future<void> _onRefreshProjectDetails(
    RefreshProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final projectId = _projectId;
    final status = _status;
    if (projectId == null || status == null) return;
    if (state is ProjectDetailsLoading ||
        state is ProjectDetailsRefreshing) {
      return;
    }

    final data = _currentData();
    emit(ProjectDetailsRefreshing(data));

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(projectId: projectId, status: status),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProjectDetailsFailure(failure.message)),
      (data) => emit(ProjectDetailsLoaded(data)),
    );
  }

  Future<void> _onRetryProjectDetails(
    RetryProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final projectId = _projectId;
    final status = _status;
    if (projectId != null && status != null) {
      add(LoadProjectDetails(projectId: projectId, status: status));
    }
  }
}
