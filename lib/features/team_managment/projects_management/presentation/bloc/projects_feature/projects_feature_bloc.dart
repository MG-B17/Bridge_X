import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/paginated_projects_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/change_leader_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/delete_team_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_completed_project_details_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_project_dashboard_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_projects_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_team_settings_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/submit_project_as_complete_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsFeatureBloc
    extends Bloc<ProjectsFeatureEvent, ProjectsFeatureState> {
  final GetProjectsUseCase getProjectsUseCase;
  final GetProjectDashboardUseCase getProjectDashboardUseCase;
  final GetProjectDetailsUseCase getProjectDetailsUseCase;
  final GetCompletedProjectDetailsUseCase getCompletedProjectDetailsUseCase;
  final GetTeamSettingsUseCase getTeamSettingsUseCase;
  final SubmitProjectAsCompleteUseCase submitProjectAsCompleteUseCase;
  final ChangeLeaderUseCase changeLeaderUseCase;
  final DeleteTeamUseCase deleteTeamUseCase;

  ProjectsFeatureBloc({
    required this.getProjectsUseCase,
    required this.getProjectDashboardUseCase,
    required this.getProjectDetailsUseCase,
    required this.getCompletedProjectDetailsUseCase,
    required this.getTeamSettingsUseCase,
    required this.submitProjectAsCompleteUseCase,
    required this.changeLeaderUseCase,
    required this.deleteTeamUseCase,
  }) : super(const ProjectsFeatureState()) {
    on<ProjectsLoadAllTabsRequested>(_onLoadAllTabs);
    on<ProjectsPullToRefreshRequested>(_onRefreshAllTabs);
    on<ProjectsLoadMoreRequested>(_onLoadMore);
    on<ProjectsTabChanged>(_onTabChanged);
    on<ProjectDashboardOpened>(_onDashboardOpened);
    on<ProjectDashboardRefreshRequested>(_onDashboardRefresh);
    on<ProjectDetailsOpened>(_onDetailsOpened);
    on<ProjectDetailsRefreshRequested>(_onDetailsRefresh);
    on<CompletedProjectDetailsOpened>(_onCompletedDetailsOpened);
    on<CompletedProjectDetailsRefreshRequested>(_onCompletedDetailsRefresh);
    on<TeamSettingsOpened>(_onTeamSettingsOpened);
    on<TeamSettingsRefreshRequested>(_onTeamSettingsRefresh);
    on<SubmitProjectConfirmed>(_onSubmitProject);
    on<ChangeLeaderRequested>(_onChangeLeader);
    on<DeleteTeamRequested>(_onDeleteTeam);
    on<ClearSubmitProjectAction>(_onClearSubmitProject);
    on<ClearChangeLeaderAction>(_onClearChangeLeader);
    on<ClearDeleteTeamAction>(_onClearDeleteTeam);
    on<ProjectsExternalMutationCompleted>(_onExternalMutationCompleted);
  }

  // ----- Tabs -----

  Future<void> _onLoadAllTabs(
    ProjectsLoadAllTabsRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    emit(
      state.copyWith(
        allProjects: state.allProjects.copyWith(
          status: ProjectsTabStatus.loading,
        ),
        ongoingProjects: state.ongoingProjects.copyWith(
          status: ProjectsTabStatus.loading,
        ),
        completedProjects: state.completedProjects.copyWith(
          status: ProjectsTabStatus.loading,
        ),
      ),
    );

    final results = await Future.wait([
      getProjectsUseCase(const GetProjectsParams(page: 1)),
      getProjectsUseCase(const GetProjectsParams(page: 1, status: 'ongoing')),
      getProjectsUseCase(const GetProjectsParams(page: 1, status: 'completed')),
    ]);

    if (isClosed) return;

    emit(
      state.copyWith(
        allProjects: _tabResult(results[0], state.allProjects),
        ongoingProjects: _tabResult(results[1], state.ongoingProjects),
        completedProjects: _tabResult(results[2], state.completedProjects),
      ),
    );
  }

  Future<void> _onRefreshAllTabs(
    ProjectsPullToRefreshRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.allProjects.status == ProjectsTabStatus.refreshing ||
        state.allProjects.status == ProjectsTabStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        allProjects: state.allProjects.copyWith(
          status: ProjectsTabStatus.refreshing,
        ),
        ongoingProjects: state.ongoingProjects.copyWith(
          status: ProjectsTabStatus.refreshing,
        ),
        completedProjects: state.completedProjects.copyWith(
          status: ProjectsTabStatus.refreshing,
        ),
      ),
    );

    final results = await Future.wait([
      getProjectsUseCase(const GetProjectsParams(page: 1)),
      getProjectsUseCase(const GetProjectsParams(page: 1, status: 'ongoing')),
      getProjectsUseCase(const GetProjectsParams(page: 1, status: 'completed')),
    ]);

    if (isClosed) return;

    emit(
      state.copyWith(
        allProjects: _tabResult(results[0], state.allProjects),
        ongoingProjects: _tabResult(results[1], state.ongoingProjects),
        completedProjects: _tabResult(results[2], state.completedProjects),
      ),
    );
  }

  Future<void> _onLoadMore(
    ProjectsLoadMoreRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    final tab = _tabForType(event.tabType);
    if (tab.status != ProjectsTabStatus.loaded || !tab.hasMore) return;
    if (tab.status == ProjectsTabStatus.loadingMore) return;

    final updated = tab.copyWith(status: ProjectsTabStatus.loadingMore);
    emit(_updateTab(event.tabType, updated));

    final result = await getProjectsUseCase(
      GetProjectsParams(
        page: tab.currentPage + 1,
        status: _statusForType(event.tabType),
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        final restored = tab.copyWith(
          status: ProjectsTabStatus.loaded,
          errorMessage: failure.message,
        );
        emit(_updateTab(event.tabType, restored));
      },
      (data) {
        final next = tab.copyWith(
          status: ProjectsTabStatus.loaded,
          items: [...tab.items, ...data.projects],
          hasMore: data.hasMore,
          currentPage: tab.currentPage + 1,
        );
        emit(_updateTab(event.tabType, next));
      },
    );
  }

  void _onTabChanged(
    ProjectsTabChanged event,
    Emitter<ProjectsFeatureState> emit,
  ) {
    emit(state.copyWith(selectedTabIndex: event.index));
  }

  // ----- Dashboard -----

  Future<void> _onDashboardOpened(
    ProjectDashboardOpened event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.dashboardProjectId == event.projectId &&
        state.dashboard.status == ScreenDataStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        dashboard: state.dashboard.copyWith(status: ScreenDataStatus.loading),
        dashboardProjectId: event.projectId,
      ),
    );

    final result = await getProjectDashboardUseCase(
      GetProjectDashboardParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          dashboard: state.dashboard.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          dashboard: state.dashboard.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
            clearError: true,
          ),
        ),
      ),
    );
  }

  Future<void> _onDashboardRefresh(
    ProjectDashboardRefreshRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    final projectId = state.dashboardProjectId;
    if (projectId == null) return;
    if (state.dashboard.status == ScreenDataStatus.loading ||
        state.dashboard.status == ScreenDataStatus.refreshing) {
      return;
    }

    emit(
      state.copyWith(
        dashboard: state.dashboard.copyWith(
          status: ScreenDataStatus.refreshing,
        ),
      ),
    );

    final result = await getProjectDashboardUseCase(
      GetProjectDashboardParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          dashboard: state.dashboard.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          dashboard: state.dashboard.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
          ),
        ),
      ),
    );
  }

  // ----- Details -----

  Future<void> _onDetailsOpened(
    ProjectDetailsOpened event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.detailsProjectId == event.projectId &&
        state.detailsStatus == event.status &&
        state.details.status == ScreenDataStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        details: state.details.copyWith(status: ScreenDataStatus.loading),
        detailsProjectId: event.projectId,
        detailsStatus: event.status,
      ),
    );

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(projectId: event.projectId, status: event.status),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          details: state.details.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          details: state.details.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
            clearError: true,
          ),
        ),
      ),
    );
  }

  Future<void> _onDetailsRefresh(
    ProjectDetailsRefreshRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    final projectId = state.detailsProjectId;
    final status = state.detailsStatus;
    if (projectId == null || status == null) return;
    if (state.details.status == ScreenDataStatus.loading ||
        state.details.status == ScreenDataStatus.refreshing) {
      return;
    }

    emit(
      state.copyWith(
        details: state.details.copyWith(status: ScreenDataStatus.refreshing),
      ),
    );

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(projectId: projectId, status: status),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          details: state.details.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          details: state.details.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
          ),
        ),
      ),
    );
  }

  // ----- Completed Details -----

  Future<void> _onCompletedDetailsOpened(
    CompletedProjectDetailsOpened event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.completedDetailsProjectId == event.projectId &&
        state.completedDetails.status == ScreenDataStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        completedDetails: state.completedDetails.copyWith(
          status: ScreenDataStatus.loading,
        ),
        completedDetailsProjectId: event.projectId,
      ),
    );

    final result = await getCompletedProjectDetailsUseCase(
      GetCompletedProjectDetailsParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          completedDetails: state.completedDetails.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          completedDetails: state.completedDetails.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
            clearError: true,
          ),
        ),
      ),
    );
  }

  Future<void> _onCompletedDetailsRefresh(
    CompletedProjectDetailsRefreshRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    final projectId = state.completedDetailsProjectId;
    if (projectId == null) return;
    if (state.completedDetails.status == ScreenDataStatus.loading ||
        state.completedDetails.status == ScreenDataStatus.refreshing) {
      return;
    }

    emit(
      state.copyWith(
        completedDetails: state.completedDetails.copyWith(
          status: ScreenDataStatus.refreshing,
        ),
      ),
    );

    final result = await getCompletedProjectDetailsUseCase(
      GetCompletedProjectDetailsParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          completedDetails: state.completedDetails.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          completedDetails: state.completedDetails.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
          ),
        ),
      ),
    );
  }

  // ----- Team Settings -----

  Future<void> _onTeamSettingsOpened(
    TeamSettingsOpened event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.teamSettingsProjectId == event.projectId &&
        state.teamSettings.status == ScreenDataStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        teamSettings: state.teamSettings.copyWith(
          status: ScreenDataStatus.loading,
        ),
        teamSettingsProjectId: event.projectId,
      ),
    );

    final result = await getTeamSettingsUseCase(
      GetTeamSettingsParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          teamSettings: state.teamSettings.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          teamSettings: state.teamSettings.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
            clearError: true,
          ),
        ),
      ),
    );
  }

  Future<void> _onTeamSettingsRefresh(
    TeamSettingsRefreshRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    final projectId = state.teamSettingsProjectId;
    if (projectId == null) return;
    if (state.teamSettings.status == ScreenDataStatus.loading ||
        state.teamSettings.status == ScreenDataStatus.refreshing) {
      return;
    }

    emit(
      state.copyWith(
        teamSettings: state.teamSettings.copyWith(
          status: ScreenDataStatus.refreshing,
        ),
      ),
    );

    final result = await getTeamSettingsUseCase(
      GetTeamSettingsParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          teamSettings: state.teamSettings.copyWith(
            status: ScreenDataStatus.failure,
            errorMessage: failure.message,
          ),
        ),
      ),
      (data) => emit(
        state.copyWith(
          teamSettings: state.teamSettings.copyWith(
            status: ScreenDataStatus.loaded,
            data: data,
          ),
        ),
      ),
    );
  }

  // ----- Actions -----

  Future<void> _onSubmitProject(
    SubmitProjectConfirmed event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.submitProject.status == FeatureActionStatus.loading) return;

    emit(
      state.copyWith(
        submitProject: const FeatureActionState(
          status: FeatureActionStatus.loading,
        ),
      ),
    );

    final result = await submitProjectAsCompleteUseCase(
      SubmitProjectAsCompleteParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          submitProject: FeatureActionState(
            status: FeatureActionStatus.failure,
            message: failure.message,
          ),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            submitProject: FeatureActionState(
              status: FeatureActionStatus.success,
              message: data.message,
            ),
          ),
        );
        add(const ProjectsLoadAllTabsRequested());
      },
    );
  }

  Future<void> _onChangeLeader(
    ChangeLeaderRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.changeLeader.status == FeatureActionStatus.loading) return;

    emit(
      state.copyWith(
        changeLeader: const FeatureActionState(
          status: FeatureActionStatus.loading,
        ),
      ),
    );

    final result = await changeLeaderUseCase(
      ChangeLeaderParams(projectId: event.projectId, userId: event.userId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          changeLeader: FeatureActionState(
            status: FeatureActionStatus.failure,
            message: failure.message,
          ),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            changeLeader: FeatureActionState(
              status: FeatureActionStatus.success,
              message: data.message,
            ),
          ),
        );
        add(const ProjectsLoadAllTabsRequested());
      },
    );
  }

  Future<void> _onDeleteTeam(
    DeleteTeamRequested event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    if (state.deleteTeam.status == FeatureActionStatus.loading) return;

    emit(
      state.copyWith(
        deleteTeam: const FeatureActionState(
          status: FeatureActionStatus.loading,
        ),
      ),
    );

    final result = await deleteTeamUseCase(
      DeleteTeamParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteTeam: FeatureActionState(
            status: FeatureActionStatus.failure,
            message: failure.message,
          ),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            deleteTeam: FeatureActionState(
              status: FeatureActionStatus.success,
              message: data.message,
            ),
          ),
        );
        add(const ProjectsLoadAllTabsRequested());
      },
    );
  }

  void _onClearSubmitProject(
    ClearSubmitProjectAction event,
    Emitter<ProjectsFeatureState> emit,
  ) {
    emit(state.copyWith(submitProject: const FeatureActionState()));
  }

  void _onClearChangeLeader(
    ClearChangeLeaderAction event,
    Emitter<ProjectsFeatureState> emit,
  ) {
    emit(state.copyWith(changeLeader: const FeatureActionState()));
  }

  void _onClearDeleteTeam(
    ClearDeleteTeamAction event,
    Emitter<ProjectsFeatureState> emit,
  ) {
    emit(state.copyWith(deleteTeam: const FeatureActionState()));
  }

  Future<void> _onExternalMutationCompleted(
    ProjectsExternalMutationCompleted event,
    Emitter<ProjectsFeatureState> emit,
  ) async {
    add(const ProjectsLoadAllTabsRequested());
  }

  // ----- Helpers -----

  ProjectTabData _tabResult(
    Either<Failure, PaginatedProjectsEntity> result,
    ProjectTabData previous,
  ) {
    return result.fold(
      (failure) => previous.copyWith(
        status: ProjectsTabStatus.failure,
        errorMessage: failure.message,
      ),
      (data) => previous.copyWith(
        status: ProjectsTabStatus.loaded,
        items: data.projects,
        hasMore: data.hasMore,
        currentPage: 1,
        clearError: true,
      ),
    );
  }

  ProjectsFeatureState _updateTab(ProjectsTabType type, ProjectTabData tab) {
    return state.copyWith(
      allProjects: type == ProjectsTabType.all ? tab : state.allProjects,
      ongoingProjects: type == ProjectsTabType.ongoing
          ? tab
          : state.ongoingProjects,
      completedProjects: type == ProjectsTabType.completed
          ? tab
          : state.completedProjects,
    );
  }

  ProjectTabData _tabForType(ProjectsTabType type) => switch (type) {
    ProjectsTabType.all => state.allProjects,
    ProjectsTabType.ongoing => state.ongoingProjects,
    ProjectsTabType.completed => state.completedProjects,
  };

  String? _statusForType(ProjectsTabType type) => switch (type) {
    ProjectsTabType.all => null,
    ProjectsTabType.ongoing => 'ongoing',
    ProjectsTabType.completed => 'completed',
  };
}
