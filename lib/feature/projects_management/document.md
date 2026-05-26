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

- **Projects List** — Tabbed view (All / Ongoing / Completed) with swipeable navigation, per-tab pagination, and independent refresh
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
- **Bloc** used for complex event-driven flows (projects tab, project details, project dashboard, team settings)
- **Cubit** used for simpler flows (completed project details, submit project)
- **Per-tab BLoC architecture** — Each tab (All/Ongoing/Completed) has its own `ProjectsTabBloc` instance with independent state, pagination, and refresh
- **TabController + chip-style tabs** — Swipeable `TabBarView` synced with chip filter UI via `ListenableBuilder` (scoped rebuild)
- **BridgeXSkeletonizer** for loading states with placeholder data
- **BridgeXRefreshIndicator** for pull-to-refresh with skeleton (not both visible simultaneously)
- **BridgeXErrorWidget** for full-screen error states with retry
- **CachedNetworkImageProvider** for disk-level avatar caching
- **AutomaticKeepAliveClientMixin** on tab pages to preserve scroll position and state across tab switches

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

### 4.1 Projects List (Paginated)

**Endpoint:** `GET /api/my-projects` (`ApiEndpoint.allProject`)  
**Query Parameters:**
- `?page=N` — Pagination (default: 1)
- `?status=ongoing` — Filter ongoing projects only
- `?status=completed` — Filter completed projects only
- No status param — Returns all projects (mixed ongoing + completed)

**Response (Laravel Paginated):**
```json
{
  "success": true,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 14,
        "title": "bridge X",
        "description": "Bridge x is a mobile app...",
        "category": "Development",
        "estimated_duration_days": 30,
        "expected_end_date": "2026-06-25",
        "project_completion_percentage": 0,
        "my_completion_percentage": 0,
        "my_specialization": "Flutter Developer",
        "completion_date": "2026-05-26"  // only present for completed projects
      }
    ],
    "last_page": 1,
    "next_page_url": null,
    "per_page": 10,
    "total": 2
  }
}
```

**Model:** `PaginatedProjectsResponseModel` → `PaginatedProjectsEntity`

| Field | Type |
|---|---|
| `projects` | `List<ProjectItemEntity>` |
| `currentPage` | `int` |
| `lastPage` | `int` |
| `hasMore` | `bool` (derived from `nextPageUrl != null`) |

**ProjectItemEntity:**

| Field | Type | Notes |
|---|---|---|
| `id` | `int` | |
| `title` | `String` | |
| `description` | `String` | |
| `category` | `String` | |
| `estimatedDurationDays` | `int` | |
| `expectedEndDate` | `String` | |
| `projectCompletionPercentage` | `double` | |
| `myCompletionPercentage` | `double` | |
| `mySpecialization` | `String` | |
| `completionDate` | `String?` | Present only for completed projects |

`isCompleted` getter: `completionDate != null`

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

| Field | Type |
|---|---|
| `success` | `bool` |
| `message` | `String` |
| `projectStatus` | `String` |

---

## 5. State Machines

### 5.1 ProjectsTabBloc (per-tab, 3 instances)

```
ProjectsTabInitial → LoadProjectsTab → ProjectsTabLoading(placeholder) → ProjectsTabLoaded(projects, hasMore)
                                                                        → ProjectsTabFailure(message)
ProjectsTabLoaded → RefreshProjectsTab → ProjectsTabRefreshing(projects) → ProjectsTabLoaded
                                                                          → ProjectsTabFailure(message, lastData)
ProjectsTabLoaded → LoadMoreProjectsTab → ProjectsTabLoadingMore(projects) → ProjectsTabLoaded(merged)
```

**Guards:**
- `LoadProjectsTab`: Ignored if already Loading or Refreshing
- `RefreshProjectsTab`: Ignored if already Loading or Refreshing
- `LoadMoreProjectsTab`: Only fires if state is `ProjectsTabLoaded` and `hasMore == true`

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

### Projects Screen — Initial Load (All 3 Tabs)

```
ProjectsScreen.initState()
    ├─► _allBloc = ProjectsTabBloc(status: null)..add(LoadProjectsTab())
    ├─► _ongoingBloc = ProjectsTabBloc(status: 'ongoing')..add(LoadProjectsTab())
    └─► _completedBloc = ProjectsTabBloc(status: 'completed')..add(LoadProjectsTab())

Each bloc independently:
    └─► emit(ProjectsTabLoading(placeholderData))
            └─► GetProjectsUseCase(page: 1, status: ...) → Repository → RemoteDataSource
                    └─► GET /api/my-projects?status=...
                    └─► Success: emit(ProjectsTabLoaded(projects, hasMore))
                    └─► Failure: emit(ProjectsTabFailure(message))
```

### Projects Tab — Pagination

```
ScrollController reaches maxScrollExtent - 200
    └─► add(LoadMoreProjectsTab())
            └─► Guard: only if state is ProjectsTabLoaded && hasMore
            └─► emit(ProjectsTabLoadingMore(projects))
            └─► Fetch page N+1 → merge with existing projects list
            └─► emit(ProjectsTabLoaded([...old, ...new], hasMore))
```

### Projects Tab — Refresh

```
Pull-to-refresh on active tab
    └─► add(RefreshProjectsTab())
            └─► emit(ProjectsTabRefreshing(currentProjects))  // skeleton shows
            └─► Fetch page 1 → replace data
            └─► emit(ProjectsTabLoaded(freshData, hasMore))
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
ProjectsScreen (StatefulWidget + SingleTickerProviderStateMixin)
└── Scaffold > SafeArea
    └── Column
        ├── ProjectsHeader
        ├── ListenableBuilder(listenable: _tabController)  // scoped rebuild
        │   └── Row of BridgeXChip (All / Ongoing / Completed)
        └── Expanded > TabBarView(controller: _tabController)
            ├── BlocProvider.value(_allBloc) → ProjectsTabPage
            ├── BlocProvider.value(_ongoingBloc) → ProjectsTabPage
            └── BlocProvider.value(_completedBloc) → ProjectsTabPage

ProjectsTabPage (AutomaticKeepAliveClientMixin)
└── BlocBuilder<ProjectsTabBloc>(buildWhen: ...)
    ├── [Failure, no lastData] → BridgeXErrorWidget
    └── BridgeXSkeletonizer
        └── BridgeXRefreshIndicator
            ├── [Empty] → ProjectsEmptyState
            └── ListView.separated
                ├── OngoingProjectCard (if !isCompleted)
                ├── CompletedProjectCard (if isCompleted)
                └── CircularProgressIndicator (if LoadingMore)
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

### Projects Screen — Tab Behavior
- All 3 endpoints fetched on screen open (parallel requests)
- Refresh only affects the active tab — skeleton shows on that tab only
- Tab switching via swipe (TabBarView) or tap (chip) — both synced via TabController
- `ListenableBuilder` scopes chip rebuild — TabBarView does NOT rebuild on tab change
- `AutomaticKeepAliveClientMixin` preserves tab state (scroll position, loaded data) across switches

### Projects Tab — Loading States
- `ProjectsTabInitial` treated as loading → skeleton shows immediately
- Empty state only shown when NOT loading AND NOT failure AND projects list is empty
- Failure with `lastData == null` → full-screen error widget
- Failure with `lastData != null` → shows last data (user can still see content)

### Projects Tab — Pagination
- Scroll listener triggers at `maxScrollExtent - 200px`
- Guard: only fires if `state is ProjectsTabLoaded && hasMore`
- `LoadingMore` state appends a `CircularProgressIndicator` at list bottom
- Page counter is per-bloc (independent per tab)

### Projects Tab — Project Card Type
- `ProjectItemEntity.isCompleted` (derived from `completionDate != null`) determines card type
- Ongoing → `OngoingProjectCard` with "Your Team" and "Details" actions
- Completed → `CompletedProjectCard` with "View Report" action

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
| `GetProjectsUseCase` | `registerLazySingleton` | Shared |
| `GetProjectDashboardUseCase` | `registerLazySingleton` | Shared |
| `GetTeamSettingsUseCase` | `registerLazySingleton` | Shared |
| `SubmitProjectAsCompleteUseCase` | `registerLazySingleton` | Shared |
| `GetProjectDetailsUseCase` | `registerLazySingleton` | Shared |
| `GetCompletedProjectDetailsUseCase` | `registerLazySingleton` | Shared |
| `ProjectDashboardBloc` | `registerFactory` | Per screen |
| `ProjectDetailsBloc` | `registerFactory` | Per screen |
| `CompletedProjectDetailsCubit` | `registerFactory` | Per screen |
| `TeamSettingsBloc` | `registerFactory` | Per screen |
| `SubmitProjectCubit` | `registerFactory` | Per screen |

**Note:** `ProjectsTabBloc` is NOT registered in DI — it's created directly in `ProjectsScreen.initState()` (3 instances with different `status` params) and disposed in `dispose()`.

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
│   │   ├── all_projects_entity.dart          (legacy, used by cache layer)
│   │   ├── ongoing_project_entity.dart       (legacy, used by OngoingProjectCard)
│   │   ├── completed_project_entity.dart     (legacy, used by cache layer)
│   │   ├── project_item_entity.dart          ★ unified project entity
│   │   ├── paginated_projects_entity.dart    ★ pagination wrapper
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
│       ├── get_projects_usecase.dart          ★ paginated, status-filtered
│       ├── get_project_details_usecase.dart
│       ├── get_completed_project_details_usecase.dart
│       ├── get_project_dashboard_usecase.dart
│       ├── get_team_settings_usecase.dart
│       └── submit_project_as_complete_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── all_projects_response_model.dart   (legacy, used by cache)
│   │   ├── ongoing_project_model.dart         (legacy, used by cache)
│   │   ├── completed_project_model.dart       (legacy, used by cache)
│   │   ├── project_item_model.dart            ★ unified project model
│   │   ├── paginated_projects_response_model.dart  ★ Laravel pagination parser
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
    │   ├── projects_tab/                      ★ per-tab state management
    │   │   ├── projects_tab_bloc.dart
    │   │   ├── projects_tab_event.dart
    │   │   └── projects_tab_state.dart
    │   ├── project_details/ (Bloc)
    │   ├── project_dashboard/ (Bloc)
    │   ├── team_settings/ (Bloc)
    │   ├── completed_project_details/ (Cubit)
    │   └── submit_project/ (Cubit)
    ├── screens/
    │   ├── projects_screen.dart               ★ TabController + 3 tab blocs
    │   ├── project_details_screen.dart
    │   ├── completed_project_details_screen.dart
    │   ├── project_dashboard_screen.dart
    │   └── team_settings_screen.dart
    └── widgets/
        ├── projects_header_widgets/
        │   └── projects_header.dart
        ├── projects_tab_page.dart             ★ reusable per-tab page widget
        ├── projects_list_widgets/
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
