# Projects Feature — Technical Documentation

> **Feature:** My Projects  
> **Screen:** `ProjectsScreen` (`lib/feature/projects/presentation/screens/projects_screen.dart`)  
> **Entry point:** Registered as a tab in the bottom navigation bar under the "Projects" route (`ApiEndpoint.allProject`).

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Data Model & API Contract](#3-data-model--api-contract)
4. [State Machine](#4-state-machine)
5. [Data Flow](#5-data-flow)
6. [Caching Strategy](#6-caching-strategy)
7. [Widget Tree](#7-widget-tree)
8. [Widget Breakdown](#8-widget-breakdown)
9. [Edge Cases & Logic Rules](#9-edge-cases--logic-rules)
10. [Dependency Injection](#10-dependency-injection)
11. [File Map](#11-file-map)

---

## 1. Overview

The Projects feature lists all projects the authenticated programmer is part of. It displays:

- A **header** ("My Projects" with subtitle)
- **Filter tabs** to toggle between All / Ongoing / Completed projects
- A **list of project cards**, each showing progress, team avatars, and status
- An **empty state** with an illustration and CTA buttons when no projects exist
- **Pull-to-refresh** and **skeleton loading** during initial fetch

Data is fetched from a remote API on screen open, with automatic fallback to `SharedPreferences` cache when offline.

---

## 2. Architecture

The feature follows **Clean Architecture** with strict layer separation:

```
Presentation  →  Domain  →  Data
(Cubit/UI)       (UseCases/Entities)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|
| **Presentation** | UI rendering, state management via `AllProjectsCubit` |
| **Domain** | Business rules via `GetAllProjectsUseCase`, pure entities |
| **Data** | API calls via Dio, JSON parsing models, local cache via `CacheService` |

### Key Design Decisions
- **Model–Entity separation**: Models (`AllProjectsResponseModel`, `OngoingProjectModel`, `CompletedProjectModel`) are independent classes with explicit `.toEntity()` mappers — no inheritance from entities.
- **`ListView.builder`** with `shrinkWrap: true` + `NeverScrollableScrollPhysics` for lazy widget building within a parent `SingleChildScrollView`, avoiding full list rebuilding.
- **`Skeletonizer`** during initial load; `BridgeXRefreshIndicator` + skeleton for pull-to-refresh.
- **Filter logic** lives directly on `AllProjectsEntity` via `getFilteredOngoing()`, `getFilteredCompleted()`, and `isTabEmpty()` methods, eliminating duplication between cubit and screen.
- **Offline fallback**: when the network is unavailable, the repository transparently serves cached data.

---

## 3. Data Model & API Contract

### API Endpoint
```
GET /api/all-projects   (ApiEndpoint.allProject)
Optional: ?page=N       for pagination
```

### Response JSON Structure
```json
{
  "data": {
    "ongoing_projects": [
      {
        "id": 1,
        "title": "Bridge X App",
        "description": "Building a team collaboration platform",
        "category": "Development",
        "estimated_duration_days": 90,
        "expected_end_date": "2025-12-31",
        "project_completion_percentage": 65.0,
        "my_completion_percentage": 40.0,
        "my_specialization": "Flutter Developer"
      }
    ],
    "completed_projects": [
      {
        "id": 101,
        "title": "Legacy Portal",
        "description": "Completed migration project",
        "category": "Infrastructure",
        "estimated_duration_days": 120,
        "expected_end_date": "2025-06-30",
        "project_completion_percentage": 100.0,
        "my_completion_percentage": 100.0,
        "my_specialization": "Backend Developer"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "has_more": true
    }
  }
}
```

> The `fromJson` parser supports both wrapped (`{ "data": {...} }`) and unwrapped shapes — the `data` key is peeled off if present.

### Entity: `AllProjectsEntity`

| Field | Type | Description |
|---|---|---|
| `ongoingProjects` | `List<OngoingProjectEntity>` | Active projects |
| `completedProjects` | `List<CompletedProjectEntity>` | Finished projects |
| `currentPage` | `int?` | Current pagination page |
| `totalPages` | `int?` | Total pages available |
| `hasMore` | `bool` | Whether more pages exist (default `false`) |

### Entity: `OngoingProjectEntity` / `CompletedProjectEntity`

| Field | Type | Description |
|---|---|---|
| `id` | `int` | Unique project identifier |
| `title` | `String` | Project name |
| `description` | `String` | Project description |
| `category` | `String` | Project phase / category label |
| `estimatedDurationDays` | `int` | Total estimated duration |
| `expectedEndDate` | `String` | Expected completion date |
| `projectCompletionPercentage` | `double` | Overall project progress (0–100) |
| `myCompletionPercentage` | `double` | User's personal completion (0–100) |
| `mySpecialization` | `String` | User's role in the project |

> Both entities share identical fields. They are kept as separate types to allow future divergence (e.g., a `rating` field on completed projects).

### Helper Methods on `AllProjectsEntity`

| Method | Returns | Description |
|---|---|---|
| `isEmpty` | `bool` | `true` when both lists are empty |
| `getFilteredOngoing(filterIndex)` | `List<OngoingProjectEntity>` | Returns ongoing list only when filter is 1 (Ongoing), otherwise all ongoing |
| `getFilteredCompleted(filterIndex)` | `List<CompletedProjectEntity>` | Returns completed list only when filter is 2 (Completed), otherwise all completed |
| `isTabEmpty(filterIndex, isLoading)` | `bool` | Checks if the currently selected tab would show zero items (skipped during loading) |

---

## 4. State Machine

The `AllProjectsCubit` emits the following states:

```
                ┌───────────────────────────────────────────┐
                │           AllProjectsInitial               │
                │       (screen created, no data yet)        │
                └───────────────────┬───────────────────────┘
                                    │ loadProjects() called
                                    ▼
                ┌───────────────────────────────────────────┐
                │           AllProjectsLoading               │
                │  (full-screen skeleton with placeholder)   │
                └──────┬───────────────────────┬────────────┘
                       │ success               │ failure
                       ▼                       ▼
     ┌──────────────────────────┐   ┌──────────────────────────┐
     │     AllProjectsLoaded     │   │   AllProjectsFailure     │
     │  (filtered cards shown)   │   │ (error widget + retry)   │
     └──────┬───────────────────┘   └──────────────────────────┘
            │ user pulls to refresh    ▲ user taps Retry
            ▼                          │
     ┌──────────────────────────┐      │
     │   AllProjectsRefreshing   │──────┘
     │ (skeleton over real data) │ fail
     └──────┬───────────────────┘
            │ success
            ▼
     AllProjectsLoaded

            │ user scrolls near end (loadMore)
            ▼
     ┌──────────────────────────┐
     │  AllProjectsLoadingMore   │
     │ (existing data preserved) │
     └──────┬───────────────────┘
            │ success / fail
            ▼
     AllProjectsLoaded (merged or restored)

Filter changes do not trigger API calls — they re-emit the current         │
data with a new `selectedFilter` value.
```

### State Descriptions

| State | Data Available | Skeletonizer | UI |
|---|---|---|---|
| `AllProjectsInitial` | `null` | — | Not rendered (transitions immediately) |
| `AllProjectsLoading` | Placeholder (3 ongoing + 2 completed) | ✅ enabled | Skeleton shimmer over placeholder cards |
| `AllProjectsLoaded` | Real data | ❌ disabled | Filtered list of project cards |
| `AllProjectsRefreshing` | Previously loaded data | ✅ enabled | Shimmer over existing cards |
| `AllProjectsLoadingMore` | Previously loaded data | ❌ disabled | Existing list + loading indicator at bottom |
| `AllProjectsFailure` | Last data or placeholder | ❌ disabled | `BridgeXErrorWidget` if no data, otherwise stale data behind error |

---

## 5. Data Flow

### Initial Load

```
ProjectsScreen created
    │
    └─► BlocProvider creates AllProjectsCubit via sl<AllProjectsCubit>()
            │
            └─► loadProjects() called immediately
                    │
                    emit(AllProjectsLoading(placeholderData))
                    │
                    └─► GetAllProjectsUseCase.call()
                            │
                            └─► AllProjectsRepoImpl.getAllProjects(page: 1)
                                    │
                               networkInfo.isConnected?
                                    │
                          ┌─────────┴──────────┐
                        YES                     NO
                          │                      │
                    remoteDataSource         localDataSource
                    .getAllProjects()        .getCachedProjects()
                          │                      │
                    success?                success?
                   ┌──────┴──────┐        ┌──────┴──────┐
                 YES             NO      YES             NO
                   │              │        │              │
             cacheProjects()   try local  emit           emit
             emit(Loaded)      cache     (Loaded)        (Failure)
                                  │
                            success?
                           ┌──────┴──────┐
                          YES             NO
                           │              │
                      emit(Loaded)    emit(Failure)
```

### Pagination (Load More)

```
User scrolls near end of list
    │
    └─► AllProjectsCubit.loadMore()
            │
            guard: state is AllProjectsLoaded && data.hasMore
            guard: not already AllProjectsLoadingMore
            │
            emit(AllProjectsLoadingMore(currentData))
            │
            └─► GetAllProjectsUseCase.loadMore(nextPage)
                    │
                    └─► AllProjectsRepoImpl.getAllProjects(page: nextPage)
                            │
                       success?
                      ┌──────┴──────┐
                    YES              NO
                      │               │
                 _currentPage++    emit(Loaded
                 merge lists       with old data)
                 emit(Loaded)
```

### Pull-to-Refresh

```
User pulls down
    │
    └─► AllProjectsCubit.refreshProjects()
            │
            guard: if Loading or Refreshing → return (no-op)
            │
            _currentPage = 1
            emit(AllProjectsRefreshing(currentData))
            │
            └─► Same remote fetch as loadProjects()
```

### Filter Change

```
User taps filter tab (All / Ongoing / Completed)
    │
    └─► AllProjectsCubit.changeFilter(index)
            │
            Re-emits current state with new selectedFilter
            No API call — data is already in-memory
```

---

## 6. Caching Strategy

### Single-Tier Disk Cache

| Tier | Storage | Lifetime | When Populated |
|---|---|---|---|
| **Disk** | `SharedPreferences` via `CacheService` (key: `AppKeys.projectsCacheKey`) | Persistent across restarts | On every successful remote fetch for page 1 |

### Cache Read Order
1. If **online**: remote fetch → on success, cache page 1 → return data
2. If **offline**: read from disk → deserialize JSON → return entity
3. Neither → `CacheFailure` returned, which surfaces as `AllProjectsFailure` in UI

### Cache Write Strategy
- Written on every successful remote fetch **for page 1 only** (paginated pages are not cached)
- Cache is **always** updated on non-paginated loads
- Cache is **skipped** for `loadMore()` calls (pages > 1)

### Cache Invalidation
- No time-based invalidation — cache lives until overwritten by a fresh page-1 fetch or manually cleared
- `clearCache()` removes the key from `SharedPreferences`

---

## 7. Widget Tree

```
ProjectsScreen (StatelessWidget)
└── BlocProvider<AllProjectsCubit>
    └── _ProjectsScreenContent
        └── ScrollNavListener
            └── Scaffold
                └── SafeArea
                    └── BlocBuilder<AllProjectsCubit, AllProjectsState>
                        │
                        ├── [AllProjectsFailure with no lastData] →
                        │   BridgeXErrorWidget (full screen)
                        │
                        └── [All other states] →
                            BridgeXSkeletonizer (enabled when loading/refreshing)
                            └── BridgeXRefreshIndicator
                                └── SingleChildScrollView
                                    └── Column
                                        ├── ProjectsHeader
                                        ├── VerticalSpacing
                                        ├── _FilterTabsSelector
                                        │   └── BlocSelector<int>
                                        │       └── ProjectFilterTabs
                                        │           └── BridgeXChip (×3)
                                        ├── VerticalSpacing
                                        ├── _ProjectsContentSelector
                                        │   └── BlocSelector<_ProjectsContentModel>
                                        │       ├── [empty] →
                                        │       │   ProjectsEmptyState
                                        │       │   ├── EmptyStateIllustration
                                        │       │   ├── EmptyStateContent
                                        │       │   ├── EmptyStateActions
                                        │       │   │   ├── BridgeXButton ("Explore Teams")
                                        │       │   │   └── BridgeXOutlineButton ("Create Team")
                                        │       │   └── SocialProofFooter
                                        │       │
                                        │       └── [has data] →
                                        │           ProjectsListContent
                                        │           └── ListView.builder
                                        │               ├── CompletedProjectCard (×N)
                                        │               ├── VerticalSpacing (separators)
                                        │               └── OngoingProjectCard (×N)
                                        │                   ├── ProjectStatusBadge
                                        │                   ├── _YourTeamBadge (conditional)
                                        │                   ├── ProjectProgressBar
                                        │                   └── AvatarStack
                                        └── VerticalSpacing
```

---

## 8. Widget Breakdown

### `ProjectsHeader`
- **File:** `projects_header_widgets/projects_header.dart`
- **Renders:** "My Projects" title + subtitle text
- **No inputs** — strings are from `AppStrings` constants

### `ProjectFilterTabs`
- **File:** `projects_filter_widgets/project_filter_tabs.dart`
- **Inputs:** `selectedIndex: int`, `onChanged: ValueChanged<int>`
- **Renders:** 3 `BridgeXChip` widgets in a row: All (0), Ongoing (1), Completed (2)
- **Selection styling:** Primary color background + white text when selected; surface background + primary text when not selected

### `ProjectsListContent`
- **File:** `projects_list_widgets/projects_list_content.dart`
- **Inputs:** `selectedFilter`, `ongoingProjects`, `completedProjects`
- **Logic:** Uses `ListView.builder` with `shrinkWrap: true` + `NeverScrollableScrollPhysics` to lazily build only visible cards. Computes item indices to interleave spacing separators between cards. Completed cards render first, then ongoing, with a spacer between the two sections.
- **Ongoing card:** Passes `OngoingProjectEntity` directly → `OngoingProjectCard(entity: ongoing)`
- **Completed card:** Passes individual fields (title, rating=4.8, description, action, date)

### `OngoingProjectCard`
- **File:** `projects_list_widgets/ongoing_project_card.dart`
- **Input:** `entity: OngoingProjectEntity`, `onDetailsTap: VoidCallback?`
- **Renders:** Status badge ("ONGOING") → title row (with optional "Your Team" badge if `entity.mySpecialization.isNotEmpty`) → `ProjectProgressBar` → avatar stack + "Details" link
- **Member count:** Derived from `entity.id` via `_minTeamMembers + (id % (_maxTeamMembers - _minTeamMembers))` (range 3–5)
- **"Your Team" badge:** Checked internally via `entity.mySpecialization.isNotEmpty` — no redundant prop from parent

### `CompletedProjectCard`
- **File:** `projects_list_widgets/completed_project_card.dart`
- **Inputs:** `title`, `rating`, `description`, `actionLabel`, `date`, `onActionTap`
- **Renders:** Status badge ("COMPLETED" with check icon) → title + star rating row → description → action link + date
- **Rating:** Hardcoded to 4.8 (coming from `ProjectsListContent` — entity does not yet carry a rating field)

### `ProjectProgressBar`
- **File:** `projects_list_widgets/project_progress_bar.dart`
- **Inputs:** `phase: String`, `progress: double` (0.0–1.0)
- **Renders:** Phase label + percentage text → gradient progress bar with rounded corners
- **Colors:** Uses `colors.accent` gradient

### `ProjectStatusBadge`
- **File:** `projects_list_widgets/project_status_badge.dart`
- **Inputs:** `label`, `isCompleted`, `showIcon`, `textColor`, `bgColor`
- **Renders:** Colored pill badge with optional check-circle icon. Label is uppercased.
- **Usage:** "ONGOING" (red tones) in `OngoingProjectCard`; "COMPLETED" (green tones) in `CompletedProjectCard`

### `AvatarStack`
- **File:** `projects_list_widgets/avatar_stack.dart`
- **Inputs:** `totalCount`, `maxVisible` (default 2), `avatarSize` (default 32), `colorsList` (default violet/amber/teal)
- **Renders:** Overlapping circular avatar placeholders with person icons. When `totalCount > maxVisible`, an overflow badge (`+N`) appears beside the stack.
- **Note:** Colors are configurable via the `colorsList` parameter but default to 3 predefined colors.

### `ProjectsEmptyState`
- **File:** `projects_empty_state_widgets/projects_empty_state.dart`
- **Renders:** Illustration → "No projects yet" text → "Explore Teams" + "Create Team" buttons → "Join 5,000+ active teams" social proof

### `EmptyStateIllustration`
- **File:** `projects_empty_state_widgets/empty_state_illustration.dart`
- **Renders:** A dashed circle (custom `CustomPainter`), rocket icon, central "+" button with navy blue shadow, and two floating tag chips ("New Idea" / "Collaboration")

### `EmptyStateContent`
- **File:** `projects_empty_state_widgets/empty_state_content.dart`
- **Renders:** "No projects yet" title + "Start your journey..." subtitle from `AppStrings`

### `EmptyStateActions`
- **File:** `projects_empty_state_widgets/empty_state_actions.dart`
- **Renders:** `BridgeXButton` ("Explore Teams") + `BridgeXOutlineButton` ("Create Team")

### `SocialProofFooter`
- **File:** `projects_empty_state_widgets/social_proof_footer.dart`
- **Renders:** Three overlapping colored dots + "Join 5,000+ active teams today" text

---

## 9. Edge Cases & Logic Rules

### ✅ Normal Load (Online)
1. `AllProjectsLoading` emitted → skeleton shimmer with placeholder cards
2. Remote fetch succeeds → data cached to disk
3. `AllProjectsLoaded` emitted → filtered project cards rendered

### ✅ Normal Load (Offline, Cache Exists)
1. `AllProjectsLoading` → remote fetch fails (no network)
2. Repository falls back to `getCachedProjects()`
3. `AllProjectsLoaded` emitted with cached data
4. UI renders cached data silently — no error shown

### ❌ Offline, No Cache
1. Cache read also fails → `CacheFailure`
2. `AllProjectsFailure(errorMessage)` emitted
3. `BridgeXErrorWidget` shown (full screen) with Retry button

### ❌ Online, Remote Fails, No Cache
1. Remote throws `ServerException` or `DioException`
2. No cache fallback available
3. `AllProjectsFailure` emitted with the error message
4. `BridgeXErrorWidget` shown with Retry button
5. **Note:** Unlike the Dashboard, there is no partial "stale data + error dialog" mode — `AllProjectsFailure` is the terminal error state

### 🔄 Pull-to-Refresh (Online)
1. `AllProjectsRefreshing(currentData)` emitted
2. Skeletonizer shimmers over existing real data
3. Refresh indicator spinner is transparent (hidden behind skeleton)
4. Remote succeeds → `AllProjectsLoaded` with fresh data

### 🔄 Pull-to-Refresh (Offline)
1. Remote fails → `AllProjectsFailure` emitted
2. `BridgeXErrorWidget` replaces the entire screen
3. User taps Retry → calls `loadProjects()` (full reload, not refresh)

### 📄 Pull-to-Refresh Guard
```dart
if (state is AllProjectsLoading || state is AllProjectsRefreshing) return;
```
Prevents concurrent API calls if user pulls multiple times quickly.

### 📄 Load More Guard
```dart
if (state is! AllProjectsLoaded || !(state as AllProjectsLoaded).data.hasMore) return;
if (state is AllProjectsLoadingMore) return;
```
- Only triggers when `AllProjectsLoaded` state is active with `hasMore == true`
- Skips if a `loadMore()` is already in flight

### 📄 Filter State Preservation
- `selectedFilter` is carried through all states
- `changeFilter()` re-emits the same data with a new filter index
- `AllProjectsLoadingMore` and `AllProjectsRefreshing` states also carry the current filter
- On failure, the last known filter is preserved

### 📄 Filter: Projection Logic
- `selectedFilter == 0` (All): both completed + ongoing rendered
- `selectedFilter == 1` (Ongoing): only ongoing projects shown
- `selectedFilter == 2` (Completed): only completed projects shown
- Empty state check: during loading, `isTabEmpty` returns `false` so skeleton is never replaced by the empty state

### 📄 Empty State Visibility
- Empty state is only shown when data is fully loaded (not loading) and the current filter yields zero items
- `isTabEmpty` accepts an `isLoading` parameter — returns `false` when `isLoading == true`
- Prevents the empty state from flashing during the transition from loading to loaded

### 📄 Skeleton Loading
- Initial load: `AllProjectsLoading` with hardcoded `_placeholderData` (3 ongoing + 2 completed fake projects)
- `BridgeXSkeletonizer` is enabled only for `AllProjectsLoading` and `AllProjectsRefreshing`
- `AllProjectsLoadingMore` and `AllProjectsFailure` do NOT trigger skeleton

### 📄 Placeholder Data Role
- `_placeholderData` is a static singleton created once
- It provides meaningful layout structure for the skeletonizer during initial load
- It is also used as the fallback in `_currentData()` when the state carries no real data
- `AllProjectsLoading` can optionally carry a different `placeholderData` (defaults to `_placeholderData`)

### 🔢 Member Count Formula
```dart
static const int _minTeamMembers = 3;
static const int _maxTeamMembers = 5;
static int _memberCount(int id) => _minTeamMembers + (id % (_maxTeamMembers - _minTeamMembers));
```
- Produces values 3, 4, or 5 based on `id % 2`
- This is placeholder logic until real team member data is available from the API

### 🔄 Pagination Data Merging
```dart
AllProjectsEntity(
  ongoingProjects: [...existing.ongoingProjects, ...incoming.ongoingProjects],
  completedProjects: [...existing.completedProjects, ...incoming.completedProjects],
  currentPage: incoming.currentPage,
  totalPages: incoming.totalPages,
  hasMore: incoming.hasMore,
)
```
Pages are concatenated — new items are appended to existing lists. Pagination metadata (currentPage, totalPages, hasMore) is replaced with the incoming page's values.

---

## 10. Dependency Injection

All registrations are in `projects_injection.dart`, called at app startup.

| Type | Registration | Scope |
|---|---|---|
| `AllProjectsCubit` | `registerFactory` | New instance per `BlocProvider` |
| `GetAllProjectsUseCase` | `registerLazySingleton` | Shared instance |
| `AllProjectsRepo` → `AllProjectsRepoImplement` | `registerLazySingleton` | Shared instance |
| `AllProjectsRemoteData` → `Impl` | `registerLazySingleton` | Shared instance |
| `AllProjectsLocalData` → `Impl` | `registerLazySingleton` | Shared instance |

> `AllProjectsCubit` is `registerFactory` (not singleton) because a fresh cubit is needed each time the screen is mounted. The cubit does not hold any mutable in-memory cache — all persistent state is in `AllProjectsLocalData`.

---

## 11. File Map

```
lib/feature/projects/
│
├── di/
│   └── projects_injection.dart                     # DI wiring
│
├── domain/
│   ├── entities/
│   │   ├── all_projects_entity.dart                # Aggregate entity with filter helpers
│   │   ├── completed_project_entity.dart           # Completed project domain object
│   │   └── ongoing_project_entity.dart             # Ongoing project domain object
│   ├── repo/
│   │   └── all_projects_repo.dart                  # Abstract contract (getAllProjects + getCached)
│   └── usecases/
│       └── get_all_projects_usecase.dart           # Orchestrator (call, loadMore, loadCached)
│
├── data/
│   ├── models/
│   │   ├── all_projects_response_model.dart        # JSON → model → entity mapper
│   │   ├── completed_project_model.dart           # JSON serialization for completed projects
│   │   └── ongoing_project_model.dart             # JSON serialization for ongoing projects
│   ├── data_source/
│   │   ├── remote/
│   │   │   └── all_projects_remote_data.dart       # Dio API call
│   │   └── local/
│   │       └── all_projects_local_data.dart        # SharedPreferences cache via CacheService
│   └── repo_implement/
│       └── all_projects_repo_implement.dart        # Orchestrates remote + local
│
└── presentation/
    ├── controller/
    │   ├── all_projects_cubit.dart                 # State machine (5 states, 4 actions)
    │   └── all_projects_state.dart                 # 6 sealed states
    ├── screens/
    │   └── projects_screen.dart                    # Root screen with BlocProvider
    └── widgets/
        ├── projects_header_widgets/
        │   └── projects_header.dart                # "My Projects" title + subtitle
        ├── projects_filter_widgets/
        │   └── project_filter_tabs.dart            # All / Ongoing / Completed chip row
        ├── projects_empty_state_widgets/
        │   ├── projects_empty_state.dart           # Composes empty state components
        │   ├── empty_state_illustration.dart       # Dashed circle, rocket, tags
        │   ├── empty_state_content.dart            # "No projects yet" text
        │   ├── empty_state_actions.dart            # Explore Teams + Create Team buttons
        │   └── social_proof_footer.dart            # "Join 5,000+ active teams"
        └── projects_list_widgets/
            ├── projects_list_content.dart          # ListView.builder with filtered cards
            ├── ongoing_project_card.dart           # Ongoing card (entity-driven)
            ├── completed_project_card.dart         # Completed card (prop-driven)
            ├── project_progress_bar.dart           # Gradient progress bar with label
            ├── project_status_badge.dart           # ONGOING / COMPLETED pill badge
            └── avatar_stack.dart                   # Overlapping avatar circles + overflow
```
