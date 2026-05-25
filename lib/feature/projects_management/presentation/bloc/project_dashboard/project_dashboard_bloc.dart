import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_project_dashboard_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDashboardBloc
    extends Bloc<ProjectDashboardEvent, ProjectDashboardState> {
  final GetProjectDashboardUseCase getProjectDashboardUseCase;

  int? _projectId;

  static const ProjectDashboardEntity _placeholder = ProjectDashboardEntity(
    projectId: 0,
    projectTitle: '',
    description: '',
    totalMembers: 0,
    pendingTasks: 0,
    members: [],
  );

  ProjectDashboardBloc({required this.getProjectDashboardUseCase})
      : super(const ProjectDashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
    on<RetryDashboard>(_onRetryDashboard);
  }

  ProjectDashboardEntity _currentData() => switch (state) {
        ProjectDashboardLoaded(:final dashboard) => dashboard,
        ProjectDashboardRefreshing(:final dashboard) => dashboard,
        ProjectDashboardLoading(:final placeholderData) =>
          placeholderData ?? _placeholder,
        _ => _placeholder,
      };

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<ProjectDashboardState> emit,
  ) async {
    final sameParams = _projectId == event.projectId;

    if (sameParams &&
        (state is ProjectDashboardLoading ||
            state is ProjectDashboardRefreshing)) {
      return;
    }

    _projectId = event.projectId;

    if (state is! ProjectDashboardRefreshing) {
      emit(ProjectDashboardLoading(placeholderData: _placeholder));
    }

    final result = await getProjectDashboardUseCase(
      GetProjectDashboardParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProjectDashboardError(message: failure.message)),
      (data) => emit(ProjectDashboardLoaded(dashboard: data)),
    );
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<ProjectDashboardState> emit,
  ) async {
    final projectId = _projectId;
    if (projectId == null) return;
    if (state is ProjectDashboardLoading ||
        state is ProjectDashboardRefreshing) {
      return;
    }

    final data = _currentData();
    emit(ProjectDashboardRefreshing(dashboard: data));

    final result = await getProjectDashboardUseCase(
      GetProjectDashboardParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProjectDashboardError(message: failure.message)),
      (data) => emit(ProjectDashboardLoaded(dashboard: data)),
    );
  }

  Future<void> _onRetryDashboard(
    RetryDashboard event,
    Emitter<ProjectDashboardState> emit,
  ) async {
    final projectId = _projectId;
    if (projectId != null) {
      add(LoadDashboard(projectId));
    }
  }
}
