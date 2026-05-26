# Projects Management Feature — Technical Documentation

> **Feature:** Projects Management  
> **Entry Screen:** `ProjectsScreen` (`lib/feature/projects_management/presentation/screens/projects_screen.dart`)  
> **Entry point:** Registered as the `projects` tab in the bottom navigation bar.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Screens & Navigation](#3-screens--navigation)
4. [Data Model & API Contracts](#4-data-model--api-contracts)
5. [State Machines](#5-state-machines)
6. [Data Flow](#6-data-flow)
7. [Widget Tree](#7-widget-tree)
8. [Edge Cases & Logic Rules](#8-edge-cases--logic-rules)
9. [Dependency Injection](#9-dependency-injection)
10. [File Map](#10-file-map)

---

## 1. Overview

The Projects Management feature is the central hub for managing team projects. It provides:

- **Projects List** — View all ongoing and completed projects with filter tabs
- **Project Details** — View project info, team members, GitHub link, role
- **Completed Project Details** — Extended view with rating, feedback, duration, impact sections
- **Project Dashboard** — Stats, completion progress, team members, submit-as-complete action
- **Team Settings** — Team info, members, project controls, danger zone, create/assign task entry point

---

## 2. Architecture

The feature follows **Clean Architecture** with strict layer separation:

```
Presentation  →  Domain  →  Data
(Bloc/Cubit/UI)   (UseCases/Entities)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|
| **Presentation** | UI rendering, state management via Bloc/Cubit |
| **Domain** | Business rules via use cases, pure entities |
| **Data** | API calls, JSON parsing, local cache |

### Key Design Decisions
- **Bloc** used for complex event-driven flows (projects list, project details, project dashboard, team settings)
- **Cubit** used for simpler flows (completed project details, submit project)
- **BridgeXSkeletonizer** for loading states with placeholder data
- **BridgeXRefreshIndicator** for pull-to-refresh with skeleton (not both visible simultaneously)
- **BridgeXErrorWidget** for full-screen error states with retry

---

## 3. Screens & Navigation

All screens are registered under the `project_route` in `lib/core/navigation/routes/project_route.dart`.

| Screen | Route Name | Transition | Entry Point |
|---|---|---|---|
| `ProjectsScreen` | `projects` | Tab (bottom nav) | Bottom navigation bar |
| `ProjectDetailsScreen` | `project-details` | SlideRight | Ongoing project card tap |
| `CompletedProjectDetailsScreen` | `completed-project-details` | SlideRight | Completed project "View Report" tap |
| `ProjectDashboardScreen` | `project-dashboard` | SlideRight | Ongoing project "Your Team" tap |
| `TeamSettingsScreen` | `team-settings` | SlideRight | Dashboard action button |

### Navigation Args

| Screen | Args Class | Fields |
|---|---|---|
| `ProjectDetailsScreen` | `ProjectDetailsArgs` | `projectId`, `status` |
| `CompletedProjectDetailsScreen` | `ProjectDetailsArgs` | `projectId`, `status` |
| `ProjectDashboardScreen` | `ProjectDashboardArgs` | `projectId` |
| `TeamSettingsScreen` | `TeamSettingsArgs` | `projectId` |

---

## 4. Data Model & API Contracts

### 4.1 All Projects

**Endpoint:** `GET /api/my-projects` (`ApiEndpoint.allProject`)  
**Query:** `?page=N` for pagination

**Response:**
```json
{
  "data": {
    "ongoing_projects": [...],
    "completed_projects": [...],
    "current_page": 1,
    "total_pages": 3
  }
}
```

**Entity:** `AllProjectsEntity`

| Field | Type |
|---|---|
| `ongoingProjects` | `List<OngoingProjectEntity>` |
| `completedProjects` | `List<CompletedProjectEntity>` |
| `currentPage` | `int?` |
| `totalPages` | `int?` |
| `hasMore` | `bool` |

---

### 4.2 Project Details (Ongoing)

**Endpoint:** `GET /api/my-projects/:id/details?status=ongoing`

**Entity:** `ProjectDetailsEntity`

| Field | Type |
|---|---|
| `id` | `int` |
| `title` | `String` |
| `description` | `String` |
| `status` | `String` |
| `myTrack` | `String` |
| `githubLink` | `String?` |
| `teamMembers` | `List<TeamMemberEntity>` |
| `teamMembersCount` | `int` |

---

### 4.3 Completed Project Details

**Endpoint:** `GET /api/my-projects/:id/details?status=completed`

**Entity:** `CompletedProjectDetailsEntity`

| Field | Type |
|---|---|
| `id` | `int` |
| `title`, `description`, `status`, `myTrack` | `String` |
| `githubLink` | `String?` |
| `teamMembers` | `List<TeamMemberEntity>` |
| `category` | `String` |
| `durationDays` | `int` |
| `completionDate` | `String` |
| `feedbacks` | `List<FeedbackEntity>` |
| `myRating` | `double` |
| `starsPercentage` | `double` |
| `impacts` | `List<ImpactEntity>` |

---

### 4.4 Project Dashboard

**Endpoint:** `GET /api/zero-project/:id`

**Entity:** `ProjectDashboardEntity`

| Field | Type |
|---|---|
| `projectName` | `String` |
| `totalTasks`, `completedTasks`, `pendingTasks` | `int` |
| `completionPercentage` | `double` |
| `members` | `List<ProjectMemberEntity>` |

---

### 4.5 Team Settings

**Endpoint:** `GET /api/teams/:id/details`

**Entity:** `TeamSettingsEntity`

| Field | Type |
|---|---|
| `teamName` | `String` |
| `githubLink` | `String` |
| `projectDescription` | `String` |
| `members` | `List<TeamMemberEntity>` |

---

### 4.6 Submit Project as Complete

**Endpoint:** `PATCH /api/projects/:id/complete`

**Entity:** `SubmitProjectEntity`

---

## 5. State Machines

### 5.1 ProjectsListBloc

```
ProjectsListInitial → LoadProjects → ProjectsListLoading → ProjectsListLoaded
                                                          → ProjectsListFailure
ProjectsListLoaded → RefreshProjects → ProjectsListRefreshing → ProjectsListLoaded
ProjectsListLoaded → LoadMoreProjects → ProjectsListLoadingMore → ProjectsListLoaded
ProjectsListLoaded → ChangeFilter → ProjectsListLoaded (new filter index)
```

### 5.2 ProjectDetailsBloc

```
ProjectDetailsInitial → LoadProjectDetails → ProjectDetailsLoading → ProjectDetailsLoaded
                                                                    → ProjectDetailsFailure
ProjectDetailsLoaded → RefreshProjectDetails → ProjectDetailsRefreshing → ProjectDetailsLoaded
ProjectDetailsFailure → RetryProjectDetails → LoadProjectDetails
```

### 5.3 CompletedProjectDetailsCubit

```
Initial → load(projectId) → Loading → Loaded / Failure
Loaded → refresh() → Refreshing → Loaded / Failure
Failure → retry() → Loading
```

### 5.4 ProjectDashboardBloc / TeamSettingsBloc

Same pattern as ProjectDetailsBloc.

---

## 6. Data Flow

### Projects List — Initial Load

```
ProjectsScreen mounted
    └─► ShellRoute creates ProjectsListBloc..add(LoadProjects())
            └─► emit(ProjectsListLoading(placeholderData: placeholder))
                    └─► GetAllProjectsUseCase → Repository → RemoteDataSource
                            └─► Success: emit(ProjectsListLoaded(data))
                            └─► Failure: emit(ProjectsListFailure(message))
```

### Projects List — Pagination

```
ScrollController reaches maxScrollExtent - 200
    └─► add(LoadMoreProjects())
            └─► Guard: only if state is ProjectsListLoaded && hasMore
            └─► emit(ProjectsListLoadingMore(data))
            └─► Fetch page N+1 → merge with existing data
```

### Project Details — Load

```
ProjectDetailsScreen(projectId, status)
    └─► BlocProvider creates ProjectDetailsBloc
    └─► _ProjectDetailsParamListener.initState → add(LoadProjectDetails)
            └─► emit(ProjectDetailsLoading(placeholderData))
            └─► GetProjectDetailsUseCase(projectId, status)
                    └─► Success: emit(ProjectDetailsLoaded(data))
```

---

## 7. Widget Tree

### ProjectsScreen

```
ProjectsScreen
└── ScrollNavListener
    └── Scaffold > SafeArea
        └── BlocBuilder<ProjectsListBloc>
            ├── [Failure] → BridgeXErrorWidget
            └── [Other] → BridgeXSkeletonizer
                └── BridgeXRefreshIndicator
                    └── SingleChildScrollView
                        └── Column
                            ├── ProjectsHeader
                            ├── _FilterTabsSelector (BlocSelector)
                            └── _ProjectsContentSelector (BlocSelector)
                                ├── ProjectsEmptyState (if empty)
                                └── ProjectsListContent
                                    ├── CompletedProjectCard(s)
                                    └── OngoingProjectCard(s)
```

### ProjectDetailsScreen

```
ProjectDetailsScreen
└── BlocProvider<ProjectDetailsBloc>
    └── Scaffold > SafeArea
        └── BlocBuilder
            ├── [Failure] → BridgeXErrorWidget
            └── BridgeXSkeletonizer > BridgeXRefreshIndicator
                └── SingleChildScrollView
                    └── Column
                        ├── ProjectDetailsBackHeader
                        └── ProjectDetailsContent
                            ├── ProjectHeaderCard
                            ├── MyRoleCard
                            ├── GithubLinkSection
                            ├── TeamMembersSection
                            └── ProjectDetailsActionButtons
```

### CompletedProjectDetailsScreen

```
Same as ProjectDetailsScreen but with CompletedProjectDetailsContent:
    ├── ProjectHeaderCard
    ├── MyRoleCard
    ├── GithubLinkSection
    ├── TeamMembersSection
    ├── RatingFeedbackCard
    ├── DurationCompletionCards
    ├── YourImpactSection
    └── ProjectDetailsActionButtons
```

---

## 8. Edge Cases & Logic Rules

### Projects Screen Initial Load
- `ProjectsListInitial` is treated as loading → skeleton shows immediately (no flash of empty state)
- Empty state only shown after data loads and is actually empty

### Filter Tabs
- Filter 0 = All, Filter 1 = Ongoing only, Filter 2 = Completed only
- `isTabEmpty` checks if filtered list is empty (excluding loading states)

### Pagination Guard
- Only triggers if `state is ProjectsListLoaded && data.hasMore`
- Prevents duplicate requests if already in `ProjectsListLoadingMore`

### Refresh Flow (All Screens)
- RefreshIndicator color set to transparent during refreshing (skeleton handles visual feedback)
- Prevents visual conflict between spinner and skeleton

### Completed Project — Empty Data
- Empty feedbacks/impacts handled gracefully (sections hidden)
- `myRating = 0` still renders the rating card

### Project Details — Status-Aware
- `ProjectDetailsScreen` accepts `status` param, passes to API
- Same screen handles both ongoing and completed via query param
- `CompletedProjectDetailsScreen` is a separate dedicated screen for the extended view

---

## 9. Dependency Injection

All registrations in `projects_management_injection.dart`:

| Type | Registration | Scope |
|---|---|---|
| `ProjectsManagementLocalData` | `registerLazySingleton` | Shared |
| `ProjectsManagementRemoteDataSource` | `registerLazySingleton` | Shared |
| `ProjectsManagementRepository` | `registerLazySingleton` | Shared |
| `GetAllProjectsUseCase` | `registerLazySingleton` | Shared |
| `GetProjectDashboardUseCase` | `registerLazySingleton` | Shared |
| `GetTeamSettingsUseCase` | `registerLazySingleton` | Shared |
| `SubmitProjectAsCompleteUseCase` | `registerLazySingleton` | Shared |
| `GetProjectDetailsUseCase` | `registerLazySingleton` | Shared |
| `GetCompletedProjectDetailsUseCase` | `registerLazySingleton` | Shared |
| `ProjectsListBloc` | `registerFactory` | Per screen |
| `ProjectDashboardBloc` | `registerFactory` | Per screen |
| `ProjectDetailsBloc` | `registerFactory` | Per screen |
| `CompletedProjectDetailsCubit` | `registerFactory` | Per screen |
| `TeamSettingsBloc` | `registerFactory` | Per screen |
| `SubmitProjectCubit` | `registerFactory` | Per screen |

---

## 10. File Map

```
lib/feature/projects_management/
│
├── di/
│   └── projects_management_injection.dart
│
├── domain/
│   ├── entities/
│   │   ├── all_projects_entity.dart
│   │   ├── ongoing_project_entity.dart
│   │   ├── completed_project_entity.dart
│   │   ├── details/
│   │   │   ├── project_details_entity.dart
│   │   │   ├── completed_project_details_entity.dart
│   │   │   ├── team_member_entity.dart
│   │   │   ├── feedback_entity.dart
│   │   │   └── impact_entity.dart
│   │   └── dashboard/
│   │       ├── project_dashboard_entity.dart
│   │       ├── project_member_entity.dart
│   │       ├── team_settings_entity.dart
│   │       ├── team_member_entity.dart
│   │       └── submit_project_entity.dart
│   ├── repositories/
│   │   └── projects_management_repository.dart
│   └── usecases/
│       ├── get_all_projects_usecase.dart
│       ├── get_project_details_usecase.dart
│       ├── get_completed_project_details_usecase.dart
│       ├── get_project_dashboard_usecase.dart
│       ├── get_team_settings_usecase.dart
│       └── submit_project_as_complete_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── all_projects_response_model.dart
│   │   ├── ongoing_project_model.dart
│   │   ├── completed_project_model.dart
│   │   ├── details/
│   │   │   ├── project_details_response_model.dart
│   │   │   ├── completed_project_details_response_model.dart
│   │   │   ├── team_member_model.dart
│   │   │   ├── feedback_model.dart
│   │   │   └── impact_model.dart
│   │   └── dashboard/
│   │       ├── project_dashboard_response_model.dart
│   │       ├── project_member_model.dart
│   │       ├── team_settings_model.dart
│   │       ├── team_member_model.dart
│   │       └── submit_project_response_model.dart
│   ├── datasources/
│   │   ├── remote/projects_management_remote_data_source.dart
│   │   └── local/projects_management_local_data.dart
│   └── repositories/
│       └── projects_management_repository_impl.dart
│
└── presentation/
    ├── bloc/
    │   ├── projects_list/ (Bloc: events + states + bloc)
    │   ├── project_details/ (Bloc: events + states + bloc)
    │   ├── project_dashboard/ (Bloc: events + states + bloc)
    │   ├── team_settings/ (Bloc: events + states + bloc)
    │   ├── completed_project_details/ (Cubit + states)
    │   └── submit_project/ (Cubit + states)
    ├── screens/
    │   ├── projects_screen.dart
    │   ├── project_details_screen.dart
    │   ├── completed_project_details_screen.dart
    │   ├── project_dashboard_screen.dart
    │   └── team_settings_screen.dart
    └── widgets/
        ├── projects_header_widgets/
        │   └── projects_header.dart
        ├── projects_filter_widgets/
        │   └── project_filter_tabs.dart
        ├── projects_list_widgets/
        │   ├── projects_list_content.dart
        │   ├── ongoing_project_card.dart
        │   ├── completed_project_card.dart
        │   ├── project_status_badge.dart
        │   ├── project_progress_bar.dart
        │   └── avatar_stack.dart
        ├── projects_empty_state_widgets/
        │   ├── projects_empty_state.dart
        │   ├── empty_state_illustration.dart
        │   ├── empty_state_content.dart
        │   ├── empty_state_actions.dart
        │   └── social_proof_footer.dart
        ├── details_screen_widgets/
        │   ├── project_details_content.dart
        │   ├── completed_project_details_content.dart
        │   ├── project_header_card.dart
        │   ├── project_details_back_header.dart
        │   ├── project_details_action_buttons.dart
        │   ├── my_role_card.dart
        │   ├── github_link_section.dart
        │   ├── team_members_section.dart
        │   ├── team_member_avatar.dart
        │   ├── rating_feedback_card.dart
        │   ├── duration_completion_cards.dart
        │   └── your_impact_section.dart
        ├── dashboard_screen_widgets/
        │   ├── project_dashboard_content.dart
        │   ├── project_dashboard_header.dart
        │   ├── stats_cards_row.dart
        │   ├── completion_card.dart
        │   ├── team_members_section.dart
        │   ├── action_buttons_section.dart
        │   └── submit_button.dart
        └── team_setting_widget/
            ├── team_settings_content.dart
            ├── team_settings_header.dart
            ├── team_info_card.dart
            ├── team_members_section.dart
            ├── team_member_card.dart
            ├── team_project_control.dart
            ├── team_danger_zone.dart
            ├── section_header.dart
            ├── info_field.dart
            └── avatar_utils.dart
```
