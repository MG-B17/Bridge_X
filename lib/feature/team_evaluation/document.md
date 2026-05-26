# Team Evaluation Feature — Technical Documentation

> **Feature:** Team Evaluation  
> **Screen:** `TeamEvaluationScreen` (`lib/feature/team_evaluation/presentation/screens/team_evaluation_screen.dart`)  
> **Entry point:** Triggered after successfully submitting a project as complete (from `SubmitButton` in Project Dashboard).

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Data Model & API Contracts](#3-data-model--api-contracts)
4. [State Machine](#4-state-machine)
5. [Data Flow](#5-data-flow)
6. [Widget Tree](#7-widget-tree)
7. [Edge Cases & Logic Rules](#8-edge-cases--logic-rules)
8. [Dependency Injection](#9-dependency-injection)
9. [File Map](#10-file-map)

---

## 1. Overview

The Team Evaluation feature allows users to rate and provide feedback for their team members after completing a project. It provides:

- **Team members list** — Fetched from the API, showing each member's avatar, name, and track/role
- **Star rating** — 1-5 star rating per member (optional — user can skip members)
- **Detailed feedback** — Free-text feedback field per member (optional)
- **Batch submission** — All evaluations submitted in a single API call
- **Post-submission navigation** — On success, navigates back to the Projects screen

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
| **Presentation** | UI rendering, local form state (ratings/feedback), state management via `TeamEvaluationCubit` |
| **Domain** | Business rules via use cases, pure entities |
| **Data** | API calls, JSON parsing, error handling |

### Key Design Decisions
- **Cubit** used for simplicity — two distinct actions (load members, submit evaluations) with no complex event chains
- **Local form state** managed in the widget (`Map<int, int>` for ratings, `Map<int, TextEditingController>` for feedback) — no need for BLoC for form state
- **Optional rating** — Only members with `rating > 0` are included in the submit request
- **Dialog-based feedback** — `LoadingDialog`, `SuccessDialog`, `ErrorDialog` for submission states (consistent with the rest of the app)
- **CachedNetworkImageProvider** for avatar disk caching
- **BridgeXSkeletonizer** for loading state while fetching members

---

## 3. Data Model & API Contracts

### 3.1 Get Team Members

**Endpoint:** `GET /api/teams/:teamId/basic-details` (`ApiEndpoint.teamBasicDetails`)

**Response:**
```json
{
  "success": true,
  "data": {
    "team_name": "bridge X",
    "project_description": "Bridge x is a mobile app help you to grow your career",
    "members": [
      {
        "programmer_id": 6,
        "name": "Mostafa Galal",
        "track": "Flutter Developer",
        "avatar_url": "/storage/avatars/avatar_1779765836.jpg"
      }
    ]
  }
}
```

**Entity:** `TeamBasicDetailsEntity`

| Field | Type | Description |
|---|---|---|
| `teamName` | `String` | Displayed in the info card header |
| `projectDescription` | `String` | Project description from API |
| `members` | `List<EvaluationMemberEntity>` | Team members to evaluate |

**Entity:** `EvaluationMemberEntity`

| Field | Type | Description |
|---|---|---|
| `programmerId` | `int` | Used as `evaluated_id` in submit request |
| `name` | `String` | Displayed on member card |
| `track` | `String` | Role/specialization displayed below name |
| `avatarUrl` | `String?` | Avatar image URL (nullable) |

---

### 3.2 Submit Evaluations

**Endpoint:** `POST /api/teams/:teamId/evaluate-all` (`ApiEndpoint.evaluateAll`)

**Request Body:**
```json
{
  "evaluations": [
    {
      "evaluated_id": 6,
      "rating": 4,
      "feedback": "Great work, delivered on time"
    }
  ]
}
```

| Field | Type | Required | Description |
|---|---|---|---|
| `evaluated_id` | `int` | Yes | The programmer ID being evaluated |
| `rating` | `int` | Yes | Star rating (1-5) |
| `feedback` | `String` | No | Optional text feedback |

**Response:**
```json
{
  "success": true,
  "message": "Successfully submitted 1 evaluation(s).",
  "errors": [],
  "total_submitted": 1,
  "total_requested": 1
}
```

**Response Model:** `EvaluateAllResponseModel`

| Field | Type | Description |
|---|---|---|
| `success` | `bool` | Whether the submission was successful |
| `message` | `String` | Success/failure message |
| `errors` | `List<String>` | Per-evaluation errors (e.g., invalid member ID) |
| `totalSubmitted` | `int` | Number of evaluations actually saved |
| `totalRequested` | `int` | Number of evaluations sent in request |

---

## 4. State Machine

### TeamEvaluationCubit

```
TeamEvaluationInitial → loadMembers(teamId) → TeamEvaluationMembersLoading → TeamEvaluationMembersLoaded
                                                                            → TeamEvaluationMembersFailure

TeamEvaluationMembersLoaded → submitEvaluations(teamId, evaluations) → TeamEvaluationSubmitting → TeamEvaluationSubmitSuccess
                                                                                                → TeamEvaluationSubmitFailure
```

**States:**

| State | Description | UI Behavior |
|---|---|---|
| `Initial` | Before any action | — |
| `MembersLoading` | Fetching team members | Skeleton shimmer |
| `MembersLoaded` | Members fetched successfully | Show member cards + submit button |
| `MembersFailure` | Failed to fetch members | Error widget with retry |
| `Submitting` | Posting evaluations | LoadingDialog shown |
| `SubmitSuccess` | Evaluations submitted | SuccessDialog → navigate to Projects |
| `SubmitFailure` | Submission failed | ErrorDialog shown |

---

## 5. Data Flow

### Load Members

```
TeamEvaluationScreen mounted (via route BlocProvider)
    └─► TeamEvaluationCubit.loadMembers(teamId)
            └─► emit(MembersLoading)
            └─► GetTeamMembersUseCase(teamId)
                    └─► Repository → RemoteDataSource
                            └─► GET /api/teams/:id/basic-details
                    └─► Success: emit(MembersLoaded(teamName, description, members))
                    └─► Failure: emit(MembersFailure(message))
```

### Submit Evaluations

```
User taps "Submit All Feedback"
    └─► Build evaluations list (only members with rating > 0)
    └─► TeamEvaluationCubit.submitEvaluations(teamId, evaluations)
            └─► emit(Submitting) → BlocListener shows LoadingDialog
            └─► SubmitEvaluationsUseCase(teamId, evaluations)
                    └─► Repository → RemoteDataSource
                            └─► POST /api/teams/:id/evaluate-all
                    └─► Success:
                            └─► emit(SubmitSuccess) → LoadingDialog.hide → SuccessDialog
                            └─► User taps OK → ScrollCubit.show() → goNamed(projects)
                    └─► Failure:
                            └─► emit(SubmitFailure) → LoadingDialog.hide → ErrorDialog
```

### Entry Point (from SubmitButton)

```
SubmitButton (Project Dashboard)
    └─► User taps "Submit Project"
    └─► SubmitProjectCubit.submitProject(projectId)
            └─► Success → SuccessDialog
                    └─► User taps OK → pushNamed(teamEvaluation, extra: TeamEvaluationArgs(teamId: projectId))
```

---

## 6. Widget Tree

```
TeamEvaluationScreen (StatefulWidget)
└── BlocListener<TeamEvaluationCubit> (handles Submitting/Success/Failure dialogs)
    └── Scaffold > SafeArea
        └── BlocBuilder<TeamEvaluationCubit> (buildWhen: only member states)
            ├── [MembersFailure] → BridgeXErrorWidget (with retry)
            └── BridgeXSkeletonizer
                └── Column
                    ├── EvaluationHeader (back arrow + title + subtitle)
                    └── Expanded > ListView
                        ├── EvaluationInfoCard (team name + motivational text)
                        └── EvaluationMemberCard (for each member):
                            ├── Row: CircleAvatar + Name + Track
                            ├── "PERFORMANCE RATING" label
                            ├── Row of 5 star icons (tappable)
                            ├── "DETAILED FEEDBACK" label
                            └── TextField (multiline)
                    └── EvaluationSubmitButton (only if members loaded & not empty)
```

---

## 7. Edge Cases & Logic Rules

### Rating Behavior
- Stars are tappable — tapping star N sets rating to N (1-indexed)
- Rating is optional per member — members with 0 rating are excluded from submission
- If no members are rated, an empty evaluations array is submitted (API handles gracefully)

### Empty Team
- If API returns 0 members, the submit button is hidden
- User can only go back via the header back button

### Avatar Handling
- If `avatar_url` is null or empty, initials are shown (first letter of first + last name)
- `CachedNetworkImageProvider` used for disk-level caching

### Dialog Lifecycle
- `LoadingDialog.show()` called on `Submitting` state
- `LoadingDialog.hide()` called BEFORE showing `SuccessDialog` or `ErrorDialog`
- Prevents dialog stacking

### Navigation After Success
- `context.goNamed(projects)` — uses `go` (not `push`) to clear the navigation stack back to projects tab
- `ScrollCubit.show()` — restores the bottom navigation bar visibility
- ProjectsScreen recreates on navigation → `initState` fires all 3 tab blocs → refetches all projects

### Back Button Navigation
- Back button also uses `goNamed(projects)` — navigates to ProjectsScreen and refetches all projects
- `ScrollCubit.show()` called before navigation to restore bottom nav bar

### Network Offline
- Repository checks `networkInfo.isConnected` before API calls
- Returns `NetworkFailure` with "Check your internet connection" message
- Shown in `BridgeXErrorWidget` (for member loading) or `ErrorDialog` (for submission)

### API Partial Errors
- If `success: true` but `errors` array is non-empty, the submission is still treated as successful (some evaluations may have been skipped)
- If `success: false`, the `errors` array is joined and shown in `ErrorDialog`

### TextEditingController Disposal
- All feedback controllers are stored in a `Map<int, TextEditingController>`
- All disposed in `State.dispose()` to prevent memory leaks

---

## 8. Dependency Injection

All registrations in `team_evaluation_injection.dart`:

| Type | Registration | Scope |
|---|---|---|
| `TeamEvaluationRemoteDataSource` | `registerLazySingleton` | Shared |
| `TeamEvaluationRepository` | `registerLazySingleton` | Shared |
| `GetTeamMembersUseCase` | `registerLazySingleton` | Shared |
| `SubmitEvaluationsUseCase` | `registerLazySingleton` | Shared |
| `TeamEvaluationCubit` | `registerFactory` | Per screen |

**Note:** `TeamEvaluationCubit` is created via `BlocProvider` in the route definition (`project_route.dart`), which calls `loadMembers(teamId)` immediately on creation.

---

## 9. File Map

```
lib/feature/team_evaluation/
│
├── di/
│   └── team_evaluation_injection.dart
│
├── domain/
│   ├── entities/
│   │   ├── evaluation_member_entity.dart
│   │   └── team_basic_details_entity.dart
│   ├── repositories/
│   │   └── team_evaluation_repository.dart
│   └── usecases/
│       ├── get_team_members_usecase.dart
│       └── submit_evaluations_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── evaluation_member_model.dart
│   │   ├── team_basic_details_response_model.dart
│   │   └── evaluate_all_response_model.dart
│   ├── datasources/
│   │   └── team_evaluation_remote_data_source.dart
│   └── repositories/
│       └── team_evaluation_repository_impl.dart
│
└── presentation/
    ├── cubit/
    │   ├── team_evaluation_cubit.dart
    │   └── team_evaluation_state.dart
    ├── screens/
    │   └── team_evaluation_screen.dart
    └── widgets/
        ├── evaluation_header.dart
        ├── evaluation_info_card.dart
        ├── evaluation_member_card.dart
        └── evaluation_submit_button.dart
```

---

## Related Files (Modified)

| File | Change |
|---|---|
| `core/network/api/api_endpoint.dart` | Added `teamBasicDetails`, `evaluateAll` endpoints |
| `core/navigation/route_constant/bridege_x_route_names.dart` | Added `teamEvaluation` |
| `core/navigation/route_constant/bridge_x_route_paths.dart` | Added `teamEvaluation` |
| `core/navigation/screens_args/team_evaluation_args.dart` | Created args class |
| `core/navigation/routes/project_route.dart` | Added evaluation route with BlocProvider |
| `core/di/di.dart` | Added `initTeamEvaluation()` call |
| `feature/projects_management/.../submit_button.dart` | Changed success action to navigate to evaluation |
