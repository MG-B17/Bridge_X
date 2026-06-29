import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/project_item_entity.dart';
import 'package:equatable/equatable.dart';

enum ProjectsTabType { all, ongoing, completed }

enum ProjectsTabStatus { initial, loading, loaded, loadingMore, refreshing, failure }

class ProjectTabData extends Equatable {
  final ProjectsTabStatus status;
  final List<ProjectItemEntity> items;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const ProjectTabData({
    this.status = ProjectsTabStatus.initial,
    this.items = const [],
    this.hasMore = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  ProjectTabData copyWith({
    ProjectsTabStatus? status,
    List<ProjectItemEntity>? items,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProjectTabData(
      status: status ?? this.status,
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, items, hasMore, currentPage, errorMessage];
}

enum ScreenDataStatus { initial, loading, loaded, refreshing, failure }

class ScreenDataState<T> extends Equatable {
  final ScreenDataStatus status;
  final T? data;
  final String? errorMessage;

  const ScreenDataState({
    this.status = ScreenDataStatus.initial,
    this.data,
    this.errorMessage,
  });

  ScreenDataState<T> copyWith({
    ScreenDataStatus? status,
    T? data,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ScreenDataState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}

enum FeatureActionStatus { idle, loading, success, failure }

class FeatureActionState extends Equatable {
  final FeatureActionStatus status;
  final String? message;

  const FeatureActionState({
    this.status = FeatureActionStatus.idle,
    this.message,
  });

  FeatureActionState copyWith({
    FeatureActionStatus? status,
    String? message,
  }) {
    return FeatureActionState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}

class ProjectsFeatureState extends Equatable {
  final ProjectTabData allProjects;
  final ProjectTabData ongoingProjects;
  final ProjectTabData completedProjects;
  final int selectedTabIndex;
  final ScreenDataState<ProjectDashboardEntity> dashboard;
  final ScreenDataState<ProjectDetailsEntity> details;
  final ScreenDataState<CompletedProjectDetailsEntity> completedDetails;
  final ScreenDataState<TeamSettingsEntity> teamSettings;
  final FeatureActionState submitProject;
  final FeatureActionState changeLeader;
  final FeatureActionState deleteTeam;
  final int? dashboardProjectId;
  final int? detailsProjectId;
  final String? detailsStatus;
  final int? completedDetailsProjectId;
  final int? teamSettingsProjectId;

  const ProjectsFeatureState({
    this.allProjects = const ProjectTabData(),
    this.ongoingProjects = const ProjectTabData(),
    this.completedProjects = const ProjectTabData(),
    this.selectedTabIndex = 0,
    this.dashboard = const ScreenDataState<ProjectDashboardEntity>(),
    this.details = const ScreenDataState<ProjectDetailsEntity>(),
    this.completedDetails = const ScreenDataState<CompletedProjectDetailsEntity>(),
    this.teamSettings = const ScreenDataState<TeamSettingsEntity>(),
    this.submitProject = const FeatureActionState(),
    this.changeLeader = const FeatureActionState(),
    this.deleteTeam = const FeatureActionState(),
    this.dashboardProjectId,
    this.detailsProjectId,
    this.detailsStatus,
    this.completedDetailsProjectId,
    this.teamSettingsProjectId,
  });

  ProjectsFeatureState copyWith({
    ProjectTabData? allProjects,
    ProjectTabData? ongoingProjects,
    ProjectTabData? completedProjects,
    int? selectedTabIndex,
    ScreenDataState<ProjectDashboardEntity>? dashboard,
    ScreenDataState<ProjectDetailsEntity>? details,
    ScreenDataState<CompletedProjectDetailsEntity>? completedDetails,
    ScreenDataState<TeamSettingsEntity>? teamSettings,
    FeatureActionState? submitProject,
    FeatureActionState? changeLeader,
    FeatureActionState? deleteTeam,
    int? dashboardProjectId,
    int? detailsProjectId,
    String? detailsStatus,
    int? completedDetailsProjectId,
    int? teamSettingsProjectId,
    bool clearDashboardProjectId = false,
    bool clearDetailsProjectId = false,
    bool clearDetailsStatus = false,
    bool clearCompletedDetailsProjectId = false,
    bool clearTeamSettingsProjectId = false,
  }) {
    return ProjectsFeatureState(
      allProjects: allProjects ?? this.allProjects,
      ongoingProjects: ongoingProjects ?? this.ongoingProjects,
      completedProjects: completedProjects ?? this.completedProjects,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      dashboard: dashboard ?? this.dashboard,
      details: details ?? this.details,
      completedDetails: completedDetails ?? this.completedDetails,
      teamSettings: teamSettings ?? this.teamSettings,
      submitProject: submitProject ?? this.submitProject,
      changeLeader: changeLeader ?? this.changeLeader,
      deleteTeam: deleteTeam ?? this.deleteTeam,
      dashboardProjectId: clearDashboardProjectId
          ? null
          : (dashboardProjectId ?? this.dashboardProjectId),
      detailsProjectId: clearDetailsProjectId
          ? null
          : (detailsProjectId ?? this.detailsProjectId),
      detailsStatus: clearDetailsStatus
          ? null
          : (detailsStatus ?? this.detailsStatus),
      completedDetailsProjectId: clearCompletedDetailsProjectId
          ? null
          : (completedDetailsProjectId ?? this.completedDetailsProjectId),
      teamSettingsProjectId: clearTeamSettingsProjectId
          ? null
          : (teamSettingsProjectId ?? this.teamSettingsProjectId),
    );
  }

  ProjectTabData tabData(ProjectsTabType type) => switch (type) {
        ProjectsTabType.all => allProjects,
        ProjectsTabType.ongoing => ongoingProjects,
        ProjectsTabType.completed => completedProjects,
      };

  ProjectTabData tabDataUpdated(
    ProjectsTabType type, {
    ProjectsTabStatus? status,
    List<ProjectItemEntity>? items,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
    bool clearError = false,
  }) {
    return tabData(type).copyWith(
      status: status,
      items: items,
      hasMore: hasMore,
      currentPage: currentPage,
      errorMessage: errorMessage,
      clearError: clearError,
    );
  }

  @override
  List<Object?> get props => [
        allProjects,
        ongoingProjects,
        completedProjects,
        selectedTabIndex,
        dashboard,
        details,
        completedDetails,
        teamSettings,
        submitProject,
        changeLeader,
        deleteTeam,
        dashboardProjectId,
        detailsProjectId,
        detailsStatus,
        completedDetailsProjectId,
        teamSettingsProjectId,
      ];
}
