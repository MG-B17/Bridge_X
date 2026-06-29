# Dashboard Feature — Technical Documentation

> **Feature:** Home / Dashboard  
> **Screen:** `HomeScreen` (`lib/feature/dashboard/presentation/screens/home_screen.dart`)  
> **Entry point:** Registered as the `home` tab in the bottom navigation bar.

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

The Dashboard is the home screen of Bridge X. It displays a personalized summary for the authenticated programmer, including:

- A **personalized greeting** with the programmer's name
- A **tip banner** (only shown if the user has no projects yet)
- **Team action buttons** (Join Team / Create Team)
- **Stats row**: total tasks, completed tasks, and project count
- **Project bars card**: visual bar chart of up to 3 project progress indicators
- A **productivity chart** showing the overall task completion rate

All data is fetched from a remote API on screen open, with an automatic fallback to locally cached data if the network is unavailable.

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
| **Presentation** | UI rendering, state management via `DashboardCubit` |
| **Domain** | Business rules via use cases, pure `DashboardEntity` |
| **Data** | API calls, JSON parsing, local cache (SharedPreferences) |

### Key Design Decisions
- **No mock data** anywhere in the feature — all widgets accept nullable data and display neutral `'0'`/blank placeholders during loading.
- **`Skeletonizer`** is used to shimmer the entire screen layout while data loads, preserving the visual layout without fake values.
- **Offline-first**: cached data is served when the network is unavailable, with a non-blocking error dialog.

---

## 3. Data Model & API Contract

### API Endpoint
```
GET /api/dashboard   (ApiEndpoint.dashboard)
```

### Response JSON Structure
```json
{
  "data": {
    "programmer_id": 1,
    "programmer_name": "Mostafa",
    "total_tasks_all_projects": 24,
    "completed_tasks_all_projects": 18,
    "overall_completion_rate": 75.0,
    "total_projects_participated": 4,
    "projects_details": [
      {
        "project_id": 101,
        "project_title": "Bridge X",
        "completion_percentage": 80.0
      }
    ]
  }
}
```

> The `fromJson` parser supports both wrapped (`{ "data": {...} }`) and unwrapped (`{ "programmer_id": ... }`) response shapes — the `data` key is peeled off if present.

### Entity: `DashboardEntity`

| Field | Type | Description |
|---|---|---|
| `programmerId` | `int` | Authenticated user's ID |
| `programmerName` | `String` | Used in the greeting header |
| `totalTasksAllProjects` | `int` | Shown in StatsRow |
| `completedTasksAllProjects` | `int` | Shown in StatsRow |
| `overallCompletionRate` | `double` | 0–100 value used by ProductivityChart |
| `totalProjectsParticipated` | `int` | Shown in StatsRow |
| `projectsDetails` | `List<ProjectDetailEntity>` | Drives ProjectBarsCard (capped at 3) |

### Entity: `ProjectDetailEntity`

| Field | Type | Description |
|---|---|---|
| `projectId` | `int` | Unique project identifier |
| `projectTitle` | `String` | Displayed under each bar |
| `completionPercentage` | `double` | 0–100, divided by 100 for bar fill ratio |

### Local Model: `DashboardLocalModel`

Extends `DashboardResponseModel` and adds:

| Field | Type | Description |
|---|---|---|
| `cachedAt` | `DateTime` | Timestamp of when data was cached, stored in ISO 8601 |

---

## 4. State Machine

The `DashboardCubit` emits the following states:

```
            ┌──────────────────────────────────────────────────────┐
            │                  DashboardInitial                    │
            │         (screen created, no data yet)                │
            └───────────────────────┬──────────────────────────────┘
                                    │ loadDashboard() called
                                    ▼
            ┌──────────────────────────────────────────────────────┐
            │                  DashboardLoading                    │
            │        (full-screen skeleton shimmer shown)          │
            └──────┬──────────────────────────────────┬───────────┘
                   │ remote success                    │ remote + local fail
                   ▼                                   ▼
  ┌───────────────────────────┐         ┌───────────────────────────┐
  │      DashboardLoaded      │         │      DashboardError        │
  │  (data rendered, no msg)  │         │  (full-screen error view)  │
  └──────────┬────────────────┘         └───────────────────────────┘
             │ remote fail + local hit    ▲ user taps Retry
             ▼                           │
  ┌──────────────────────────────────────┘
  │  DashboardLoaded(errorMessage: '...')
  │  (cached data shown + ErrorDialog popup)
  └──────────────────────────────────────
             │ user pulls to refresh
             ▼
  ┌──────────────────────────────────────┐
  │         DashboardRefreshing          │
  │ (skeleton shimmer over existing data)│
  └──────┬───────────────────────────────┘
         │ success                    │ fail
         ▼                            ▼
  DashboardLoaded             DashboardLoaded(errorMessage)
```

### State Descriptions

| State | `dashboard` Data | Skeletonizer | UI |
|---|---|---|---|
| `DashboardInitial` | `null` | ✅ enabled | Shimmers over neutral placeholders |
| `DashboardLoading` | `null` | ✅ enabled | Shimmers over neutral placeholders |
| `DashboardLoaded` | real data | ❌ disabled | Full dashboard rendered |
| `DashboardLoaded(errorMessage)` | cached data | ❌ disabled | Cached dashboard + ErrorDialog |
| `DashboardRefreshing` | last loaded data | ✅ enabled | Shimmer over real data (refresh feel) |
| `DashboardError` | none | ❌ | `BridgeXErrorWidget` (full screen) |

---

## 5. Data Flow

### Initial Load

```
HomeScreen created
    │
    └─► BlocProvider creates DashboardCubit via sl<DashboardCubit>()
            │
            └─► loadDashboard() called immediately
                    │
                    emit(DashboardLoading)
                    │
                    └─► GetRemoteDashboardUseCase.call()
                                │
                                └─► DashboardRepositoryImpl.getRemoteDashboard()
                                        │
                                   networkInfo.isConnected?
                                        │
                          ┌─────────────┴──────────────┐
                        YES                             NO
                          │                             │
                    remoteDataSource                    │
                    .getDashboard()              getLocalDashboard()
                          │                             │
                    success?                      success?
                   ┌──────┴──────┐             ┌───────┴────────┐
                 YES             NO            YES               NO
                   │             │              │                │
            cacheDashboard()  try local      emit              emit
            emit(Loaded)       cache        (Loaded)          (NetworkFailure
                                │                              → Error)
                          success?
                         ┌──────┴──────┐
                        YES             NO
                         │              │
                    emit(Loaded      emit(Error)
                    +errorMessage)
```

### Pull-to-Refresh Flow

```
User pulls down
    │
    └─► loadDashboard(isRefresh: true)
            │
            guard: if state is already Loading/Refreshing → return (no-op)
            │
            emit(DashboardRefreshing(dashboard: currentData))
            │
            └─► Same remote fetch as above
                    Note: On refresh success, local cache is NOT updated
                          (isRefresh: true skips cacheDashboard())
```

---

## 6. Caching Strategy

### Two-Tier Cache

| Tier | Storage | Lifetime | When Populated |
|---|---|---|---|
| **In-memory** | `_inMemoryDashboard` field in `DashboardLocalDataSourceImpl` | App session | On every successful remote fetch (non-refresh) |
| **Disk** | `SharedPreferences` via `CacheService` (key: `AppKeys.dashboardCacheKey`) | Persistent across restarts | Flushed to disk on app shutdown via `AppLifecycleService` |

### Cache Read Order
1. Check in-memory (`_inMemoryDashboard != null`) → serve immediately
2. Check disk (`cacheService.getData(key)`) → deserialize and serve
3. Neither → throw `CacheException('No cached dashboard found')`

### Cache Write Strategy
- Written **in-memory only** during the session (`cacheDashboard()`)
- Flushed to disk only when the app is **shutting down** (`_persistCache()` via `AppLifecycleService`)
- Cache is **skipped** on pull-to-refresh (`isRefresh: true`)

### Cache Invalidation
- Cache is **never automatically invalidated** by time — `cachedAt` is stored but not currently used to expire data
- Cache can be manually cleared via `clearCache()` (removes both memory and disk)

---

## 7. Widget Tree

```
HomeScreen (StatefulWidget)
└── BlocProvider<DashboardCubit>
    └── Scaffold
        └── SafeArea
            └── BlocConsumer<DashboardCubit, DashboardState>
                │
                ├── [DashboardError] → BridgeXErrorWidget (full screen)
                │
                └── [All other states] →
                    BridgeXRefreshIndicator
                    └── ScrollNavListener
                        └── BridgeXSkeletonizer (enabled when loading/refreshing)
                            └── SingleChildScrollView
                                └── Column
                                    ├── GreetingHeader
                                    ├── VerticalSpacing
                                    ├── BridgeXTipBanner (conditional)
                                    ├── VerticalSpacing
                                    ├── TeamActionButtons
                                    ├── VerticalSpacing
                                    ├── StatsRow
                                    ├── VerticalSpacing
                                    ├── ProductivitySection
                                    │   └── ProductivityChart
                                    ├── VerticalSpacing
                                    └── ProjectBarsCard
                                        └── ProjectBarColumn (×1–3)
```

---

## 8. Widget Breakdown

### `GreetingHeader`
- **File:** `home_header_widgets/greeting_header.dart`
- **Input:** `programmerName: String?`
- **Logic:** If `programmerName` is non-null and non-empty → `"Hi, {name} 👋"`. Otherwise → `"Hi,           👋"` (spaced blank for Skeletonizer shimmer)
- **Also renders:** `NotificationBellButton` (navigates to `/notifications`)

### `BridgeXTipBanner`
- **Condition:** Only shown when `dashboard != null && dashboard.projectsDetails.isEmpty`
- **During loading:** Hidden (evaluates to `false` since `dashboard` is `null`)
- **Message:** `"Tip: Join a team to start building real projects"`

### `TeamActionButtons`
- **Always visible** — not data-dependent
- **Join Team** → navigates to `BridegeXRouteNames.selectCategory`
- **Create Team** → navigates to `BridegeXRouteNames.createTeam`

### `StatsRow`
- **Inputs:** `totalTasks: int?`, `completedTasks: int?`, `projectsCount: int?`
- **Null fallbacks:** `'0'`, `'0'`, `'00'` (Skeletonizer shimmers these)
- **Project count formatting:** Single-digit counts are zero-padded → `'04'`
- **Three segments:** Total Tasks | Completed | Projects (separated by vertical dividers)

### `ProductivitySection` / `ProductivityChart`
- **Input:** `completionRate: double?`
- **Null fallback:** `0.0` (renders 0% in donut)
- **Renders:** Custom `_DonutPainter` (Canvas-based) showing filled arc proportional to `completionRate / 100`
- **Legend:** "Completed Tasks" (primary color) and "Active Tasks" (divider color)

### `ProjectBarsCard`
- **Input:** `projects: List<ProjectDetailEntity>?`
- **Cap:** Only the **first 3 projects** are displayed (`.take(3)`)
- **Null state (loading):** 3 blank placeholder `ProjectBarColumn` widgets at 50% fill for Skeletonizer
- **Animated bars:** Each `ProjectBarColumn` uses `AnimatedContainer` with `easeOutCubic` curve
- **"View All" button:** Always visible, `onPressed` is currently a no-op (pending navigation)
- **Decorative glow particles:** 10 cyan dot `Positioned` widgets layered behind bars

### `ProjectBarColumn`
- **Inputs:** `name: String`, `percentage: double` (0.0–1.0)
- **Renders:** percentage label → animated fill bar → project title
- **Bar fill:** `AppGradient.barFill` with `AppShadow.barGlow` for neon glow effect

---

## 9. Edge Cases & Logic Rules

### ✅ Normal Load (Online, First Visit)
1. `DashboardLoading` emitted → skeleton shimmer over entire screen
2. Remote fetch succeeds → data cached in memory
3. `DashboardLoaded` emitted → full UI rendered

### ✅ Normal Load (Online, Return Visit)
1. Same as above — in-memory cache may exist but cubit always fetches remote first

### ✅ Offline, Cache Exists
1. `DashboardLoading` → remote fetch fails (no network)
2. Repository falls back to `getLocalDashboard()`
3. `DashboardLoaded(dashboard: cachedData)` — no error message
4. UI renders cached data silently

### ⚠️ Online, Remote Fails, Cache Exists
1. `DashboardLoading` → remote fetch throws `ServerException` or `DioException`
2. Repository tries local cache → succeeds
3. `DashboardLoaded(dashboard: cachedData, errorMessage: 'No internet connection')` emitted
4. **BlocConsumer listener** detects `errorMessage != null` → shows `ErrorDialog`
5. Cached data remains visible behind the dialog

### ❌ Offline, No Cache (Full Error)
1. `DashboardLoading` → remote fails → local fails → `CacheException`
2. `DashboardError(message: 'No internet connection')` emitted
3. Full screen replaced by `BridgeXErrorWidget`
4. User can tap **Retry** → calls `loadDashboard()` again

### 🔄 Pull-to-Refresh (Online)
1. `DashboardRefreshing(dashboard: currentData)` emitted
2. `BridgeXRefreshIndicator` shows transparent spinner (not the native pull indicator)
3. `Skeletonizer` shimmers over the existing real data
4. Remote fetch succeeds → `DashboardLoaded` with fresh data
5. **Cache is NOT updated** on refresh (by design: isRefresh = true skips cacheDashboard)

### 🔄 Pull-to-Refresh (Offline)
1. `DashboardRefreshing` emitted
2. Remote fails → falls back to local → finds cache
3. `DashboardLoaded(errorMessage: 'No internet connection')` shown over current data
4. `ErrorDialog` pops up informing the user

### 🔒 Double-Tap Guard
- `loadDashboard()` has a guard at the top:
  ```dart
  if (state is DashboardLoading || state is DashboardRefreshing) return;
  ```
- Prevents concurrent API calls if the user taps the refresh button multiple times quickly

### 📋 Empty Projects List
- When `projectsDetails` is an **empty list** (user has no projects):
  - `ProjectBarsCard` is **still rendered** but has 0 bars — shows only the "View All" button and decorative particles
  - `BridgeXTipBanner` is **shown** to encourage joining a team

### 📋 Projects List with >3 Items
- Only the **first 3** projects are rendered via `.take(3)`
- The "View All" button is always shown to navigate to the full list

### 🔢 Zero-Stat Edge Case
- If `totalTasks == 0` and `completedTasks == 0`, the stats row shows `'0'`, `'0'`, `'00'`
- This is also what Skeletonizer shimmers over during loading — so loading and empty-data states look identical

### 📱 Refresh Indicator Color Logic
```dart
color: isRefreshing ? context.appColors.transparent : context.appColors.primary,
backgroundColor: isRefreshing ? context.appColors.transparent : null,
```
- During **refresh**: the native spinner is hidden (transparent) because `Skeletonizer` visually communicates loading
- During **initial load**: not applicable (refresh indicator is not shown, only skeleton is)

---

## 10. Dependency Injection

All registrations are in `dashboard_injection.dart`, called at app startup.

| Type | Registration | Scope |
|---|---|---|
| `DashboardCubit` | `registerFactory` | New instance per `BlocProvider` |
| `GetRemoteDashboardUseCase` | `registerLazySingleton` | Shared instance |
| `GetLocalDashboardUseCase` | `registerLazySingleton` | Shared instance |
| `DashboardRepository` → `DashboardRepositoryImpl` | `registerLazySingleton` | Shared instance |
| `DashboardRemoteDataSource` → `Impl` | `registerLazySingleton` | Shared instance |
| `DashboardLocalDataSource` → `Impl` | `registerLazySingleton` | Shared instance, holds in-memory cache |

> `DashboardCubit` is `registerFactory` (not singleton) because a fresh cubit is needed each time the screen is mounted.

---

## 11. File Map

```
lib/feature/dashboard/
│
├── di/
│   └── dashboard_injection.dart          # DI wiring
│
├── domain/
│   ├── entities/
│   │   ├── dashboard_entity.dart         # Pure domain entity
│   │   └── project_detail_entity.dart   # Per-project entity
│   ├── repositories/
│   │   └── dashboard_repository.dart    # Abstract contract
│   └── usecases/
│       ├── get_remote_dashboard_usecase.dart
│       └── get_local_dashboard_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── dashboard_response_model.dart # JSON → DashboardEntity
│   │   ├── dashboard_local_model.dart    # Adds cachedAt field
│   │   └── project_detail_model.dart    # JSON → ProjectDetailEntity
│   ├── datasource/
│   │   ├── remote/
│   │   │   └── dashboard_remote_data_source.dart  # Dio API call
│   │   └── local/
│   │       └── dashboard_local_data_source.dart   # In-memory + disk cache
│   └── repositories/
│       └── dashboard_repository_impl.dart  # Orchestrates remote + local
│
└── presentation/
    ├── cubit/
    │   ├── dashboard_cubit.dart          # State machine controller
    │   └── dashboard_state.dart          # 5 states
    ├── screens/
    │   └── home_screen.dart             # Root screen widget
    └── widgets/
        ├── home_header_widgets/
        │   ├── greeting_header.dart      # "Hi, {name} 👋" + bell button
        │   └── notification_bell_button.dart
        ├── home_stats_widgets/
        │   ├── stats_row.dart            # 3-segment stat bar
        │   ├── project_bars_card.dart    # Bar chart card (max 3 projects)
        │   ├── project_bar_column.dart   # Single animated bar
        │   ├── productivity_section.dart # Section header + chart
        │   ├── productivity_chart.dart   # Donut chart (CustomPainter)
        │   └── legend_item.dart          # Color dot + label
        └── home_insight_widgets/
            └── team_action_buttons.dart  # Join Team / Create Team
```
