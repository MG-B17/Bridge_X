# Create Team Feature — Technical Documentation

> **Feature:** Create Team  
> **Screen:** `CreateTeamScreen` (`lib/feature/create_team/presentation/screens/create_team_screen.dart`)  
> **Entry point:** Navigated to from `TeamActionButtons` on the Dashboard via `BridegeXRouteNames.createTeam`.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Data Model & API Contract](#3-data-model--api-contract)
4. [State Machine](#4-state-machine)
5. [Data Flow](#5-data-flow)
6. [Validation Rules](#6-validation-rules)
7. [Widget Tree](#7-widget-tree)
8. [Widget Breakdown](#8-widget-breakdown)
9. [Edge Cases & Logic Rules](#9-edge-cases--logic-rules)
10. [Dependency Injection](#10-dependency-injection)
11. [File Map](#11-file-map)

---

## 1. Overview

The Create Team screen allows an authenticated programmer to create a new project team. The user fills in:

- **Team Type** — Private or Public. Public teams show an additional "Invite Members" section.
- **Team Name** — Required, plain text.
- **GitHub URL** — Optional URL, validated with regex if provided.
- **Project Description** — Required, minimum 10 characters.
- **Category** — Single selection from: Development, Design, Marketing, Research.
- **Required Roles** — Multi-entry chip input. At least one role is required.
- **Team Members** *(Public teams only)* — Visible only when "Public" team type is selected.

On successful submission:
- A loading dialog is shown while the API call is in progress.
- A success dialog is shown and the user is popped back to the previous screen.
- On failure, an error dialog is shown with a "Try Again" button that resets the Cubit status.

---

## 2. Architecture

The feature follows **Clean Architecture** with strict layer separation:

```
Presentation  →  Domain  →  Data
(Cubit/UI)       (UseCases/Entities/Params)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|
| **Presentation** | UI rendering, state management via `CreateTeamCubit`, form controllers |
| **Domain** | Business rules via `CreateTeamUseCase`, pure `CreateTeamEntity`, `CreateTeamParams` |
| **Data** | API call via `CreateTeamRemoteDataImpl`, JSON parsing via `CreateTeamResponseModel` |

### Key Design Decisions

- **`CreateTeamParams`** lives in the domain layer — the usecase and repo contract are fully isolated from data-layer models (`CreateTeamRequestModel`). Mapping happens only in `CreateTeamRepoImplement`.
- **`CreateTeamMapper`** is a presentation-layer utility class responsible for converting UI state values (index → category string, display label → API track string) — this logic is NOT in the Cubit.
- **No `setState` in the screen** — `showRolesError` is managed entirely in `CreateTeamState` and emitted via the Cubit. The screen itself (`CreateTeamScreen`) is a `StatefulWidget` only to hold the `_isLoadingDialogShowing` bool, which prevents overlapping loading dialogs without triggering rebuilds.
- **Scoped `BlocBuilder` widgets** — only the interactive sections (`TeamTypeSelector`, `CategorySelectionSection`, `RequiredRolesSection`, and `TeamMembersSection`) rebuild on state changes. Text fields are not wrapped in builders, ensuring no keyboard flickering.
- **`TeamMembersSection` is conditionally shown** — it only renders when `selectedTeamType == 1` (Public).

---

## 3. Data Model & API Contract

### API Endpoint
```
POST /api/teams   (ApiEndpoint.createTeam)
```

### Request JSON Body
```json
{
  "name": "Team Alpha",
  "description": "A team for building real-world Flutter projects with clean arch.",
  "is_public": true,
  "github_url": "https://github.com/org/repo",
  "categories": ["Development"],
  "required_tracks": ["frontend", "backend"]
}
```

> `categories` and `required_tracks` are always sent as arrays. `categories` always contains exactly one string (the selected category). `required_tracks` are the normalized role names mapped from display labels by `CreateTeamMapper.mapSelectedRoles`.

### Response JSON Structure
```json
{
  "data": {
    "project": {
      "id": 42,
      "title": "Team Alpha",
      "description": "...",
      "category_name": "Development",
      "categories": ["Development"],
      "required_tracks": ["frontend", "backend"],
      "github_url": "https://github.com/org/repo",
      "status": "active",
      "estimated_duration_days": 0,
      "user_id": 1,
      "created_by": null,
      "created_at": "2026-05-23T00:00:00.000Z",
      "updated_at": "2026-05-23T00:00:00.000Z"
    },
    "team": {
      "id": 7,
      "name": "Team Alpha",
      "project_id": 42,
      "is_public": true,
      "status": "forming",
      "formation_type": "open",
      "join_code": null,
      "created_at": "2026-05-23T00:00:00.000Z",
      "updated_at": "2026-05-23T00:00:00.000Z"
    },
    "invitations_sent": []
  }
}
```

### Domain Params: `CreateTeamParams`

| Field | Type | Description |
|---|---|---|
| `name` | `String` | Trimmed team name |
| `description` | `String` | Trimmed project description (min 10 chars) |
| `isPublic` | `bool` | `selectedTeamType == 1` |
| `githubUrl` | `String` | Trimmed GitHub URL |
| `categories` | `List<String>` | Single-item list with the selected category |
| `requiredTracks` | `List<String>` | Normalized role strings from `CreateTeamMapper` |

### Entity: `CreateTeamEntity`

| Field | Type | Description |
|---|---|---|
| `project` | `ProjectEntity` | The newly created project |
| `team` | `TeamEntity` | The newly created team |
| `invitationsSent` | `List<String>` | List of invitation recipients (usually empty) |

### Entity: `ProjectEntity`

| Field | Type | Description |
|---|---|---|
| `id` | `int` | Project ID |
| `title` | `String` | Project title (same as team name) |
| `description` | `String` | Project description |
| `categoryName` | `String` | Human-readable category |
| `categories` | `List<String>` | Array of category strings |
| `requiredTracks` | `List<String>` | Required role tracks |
| `githubUrl` | `String` | GitHub repository URL |
| `status` | `String` | Project status (e.g., `"active"`) |
| `estimatedDurationDays` | `int` | Duration estimate |
| `userId` | `int` | Owner user ID |
| `createdBy` | `String?` | Creator display name (nullable) |
| `createdAt` | `String` | ISO 8601 timestamp |
| `updatedAt` | `String` | ISO 8601 timestamp |

### Entity: `TeamEntity`

| Field | Type | Description |
|---|---|---|
| `id` | `int` | Team ID |
| `name` | `String` | Team name |
| `projectId` | `int` | Associated project ID |
| `isPublic` | `bool` | Visibility flag |
| `status` | `String` | Team status (e.g., `"forming"`) |
| `formationType` | `String` | Formation mode (e.g., `"open"`) |
| `joinCode` | `String?` | Invite code for private teams (nullable) |
| `createdAt` | `String` | ISO 8601 timestamp |
| `updatedAt` | `String` | ISO 8601 timestamp |

---

## 4. State Machine

The `CreateTeamCubit` manages state via a single `CreateTeamState` object (not sealed classes). All fields are immutable and emitted via `copyWith`.

```
                    ┌─────────────────────────────────┐
                    │         CreateTeamStatus         │
                    │             .initial             │
                    │   (screen ready, no action yet)  │
                    └──────────────┬──────────────────┘
                                   │ createTeam() called
                                   ▼
                    ┌─────────────────────────────────┐
                    │         CreateTeamStatus         │
                    │             .loading             │
                    │       (loading dialog shown)     │
                    └────────┬────────────────┬────────┘
                             │ API success     │ API failure
                             ▼                ▼
              ┌──────────────────┐   ┌──────────────────────┐
              │  .success        │   │  .failure             │
              │ (success dialog) │   │ (error dialog shown)  │
              └──────────────────┘   └──────────┬───────────┘
                                                │ user taps "Try Again"
                                                ▼
                                   resetStatus() called
                                   → back to .initial
```

### State Fields

| Field | Type | Default | Description |
|---|---|---|---|
| `status` | `CreateTeamStatus` | `.initial` | Current submission state |
| `selectedTeamType` | `int` | `0` | 0 = Private, 1 = Public |
| `selectedCategory` | `int` | `0` | Index into the category list |
| `selectedRoles` | `List<String>` | `['Frontend', 'UX Designer']` | Pre-seeded required roles |
| `showRolesError` | `bool` | `false` | Drives red border on `RequiredRolesSection` |
| `entity` | `CreateTeamEntity?` | `null` | Populated on success |
| `errorMessage` | `String?` | `null` | Populated on failure |

---

## 5. Data Flow

### Form Submission Flow

```
User taps "Create Team"
    │
    ├─► Form.validate() → validates name, GitHub URL, description
    │
    ├─► cubit.setShowRolesError(!isRolesValid)
    │       └─► emits state with showRolesError flag
    │           └─► RequiredRolesSection rebuilds with red border if empty
    │
    └─► (both valid) → cubit.createTeam(name, description, githubUrl)
            │
            emit(state.copyWith(status: .loading))
            │   └─► BlocListener triggers LoadingDialog.show()
            │
            CreateTeamMapper.mapCategoryIndexToString(selectedCategory)
            CreateTeamMapper.mapSelectedRoles(selectedRoles)
            │
            CreateTeamParams constructed (domain object)
            │
            CreateTeamUseCase.call(params)
            │
            CreateTeamRepoImplement.createTeam(request: params)
            │
            ├─► networkInfo.isConnected?
            │       NO → emit NetworkFailure → .failure state
            │
            └─► YES → map params → CreateTeamRequestModel
                        │
                        CreateTeamRemoteDataImpl.createTeam(request: model)
                        │
                        apiClient.post(ApiEndpoint.createTeam, data: model.toJson())
                        │
                        ├─► success → CreateTeamResponseModel.fromJson(response.data)
                        │               └─► Right(entity) → emit .success
                        │                   └─► BlocListener shows SuccessDialog
                        │
                        └─► failure → ServerException / DioException
                                        └─► Left(failure) → emit .failure
                                            └─► BlocListener shows ErrorDialog
```

### Role Normalization (via `CreateTeamMapper.mapSelectedRoles`)

| Display Label | Sent to API |
|---|---|
| Contains `"frontend"` | `"frontend"` |
| Contains `"backend"` | `"backend"` |
| Contains `"ux"`, `"ui"`, or `"design"` | `"ui/ux"` |
| Anything else | lowercased + trimmed as-is |

---

## 6. Validation Rules

All validation is centralized in `AppValidator` (`lib/core/utils/validator.dart`).

| Field | Validator | Rule |
|---|---|---|
| Team Name | `AppValidator.required(value, fieldName)` | Non-empty |
| GitHub URL | `AppValidator.url(value)` | Optional; if non-empty must match `https?://` pattern |
| Project Description | `AppValidator.projectDescription(value, fieldName)` | Non-empty + minimum 10 characters |
| Required Roles | Cubit state (`showRolesError`) | `selectedRoles.isNotEmpty` — NOT a `FormField`, checked manually on submit |

> **Error messages** are defined in `AppValidationMessages` (`lib/core/constant/app_validation_messages.dart`).  
> The `requiredRoles` field is not a `FormField` — its error state is driven entirely through `CreateTeamState.showRolesError`, which controls the red border on `RequiredRolesSection`.

---

## 7. Widget Tree

```
CreateTeamScreen (StatefulWidget)        ← holds _isLoadingDialogShowing
└── BlocProvider<CreateTeamCubit>
    └── BlocListener<CreateTeamCubit, CreateTeamState>
        │   listenWhen: previous.status != current.status
        │   → loading   : LoadingDialog.show()
        │   → failure   : dismissDialog + ErrorDialog.show()
        │   → success   : dismissDialog + SuccessDialog.show()
        │
        └── Scaffold
            └── SafeArea
                └── SingleChildScrollView
                    └── CreateTeamFormContent (StatefulWidget)
                        │   holds _formKey, _teamNameController,
                        │         _githubUrlController, _descriptionController
                        └── Form
                            └── Column
                                ├── BridgeXBackButton
                                ├── BridgeXTipBanner
                                ├── BlocBuilder (buildWhen: selectedTeamType)
                                │   └── TeamTypeSelector
                                │       ├── TeamTypeCard (Private)
                                │       └── TeamTypeCard (Public)
                                ├── BridgeXTextFormField (Team Name)
                                ├── BridgeXTextFormField (GitHub URL)
                                ├── ProjectDescriptionField
                                ├── BlocBuilder (buildWhen: selectedCategory)
                                │   └── CategorySelectionSection
                                │       └── BridgeXChip (×4)
                                ├── BlocBuilder (no buildWhen — needs showRolesError)
                                │   └── RequiredRolesSection
                                │       ├── BridgeXChip (×N, removable)
                                │       └── BridgeXTextFormField (inline add input)
                                ├── BlocBuilder (buildWhen: showRolesError)
                                │   └── roles error Text (conditional)
                                ├── BlocBuilder (buildWhen: selectedTeamType)
                                │   └── TeamMembersSection (only if Public)
                                └── BridgeXButton (Create Team)
```

---

## 8. Widget Breakdown

### `CreateTeamScreen`
- **File:** `presentation/screens/create_team_screen.dart`
- **Type:** `StatefulWidget` — holds `_isLoadingDialogShowing` to prevent duplicate loading dialogs without triggering rebuilds.
- **BlocListener** responds only when `status` changes (`listenWhen`). Automatically dismisses the loading dialog before showing error/success dialogs.

### `CreateTeamFormContent`
- **File:** `presentation/widgets/create_team_widgets/create_team_form_content.dart`
- **Type:** `StatefulWidget` — owns all three `TextEditingController` instances and the `GlobalKey<FormState>`.
- **Responsibility:** Renders the full form. Dispatches all Cubit events. Reads current Cubit state via `context.read` (not `context.watch`) in the button callback to avoid stale state.

### `TeamTypeSelector`
- **File:** `presentation/widgets/create_team_widgets/team_type_selector.dart`
- **Input:** `selectedIndex: int`, `onChanged: ValueChanged<int>`
- **Renders:** Two `TeamTypeCard` widgets (Private = 0, Public = 1).
- **Rebuild condition:** Only when `selectedTeamType` changes.

### `TeamTypeCard`
- **File:** `presentation/widgets/create_team_widgets/team_type_card.dart`
- **Input:** `icon`, `title`, `subtitle`, `isSelected`, `onTap`
- **Visual:** Highlighted border and background when selected.

### `CategorySelectionSection`
- **File:** `presentation/widgets/create_team_widgets/category_selection_section.dart`
- **Input:** `selectedIndex: int`, `onChanged: ValueChanged<int>`
- **Categories:** `['Development', 'Design', 'Marketing', 'Research']` (defined as `static const`)
- **Rebuild condition:** Only when `selectedCategory` changes.

### `RequiredRolesSection`
- **File:** `presentation/widgets/create_team_widgets/required_roles_section.dart`
- **Type:** `StatefulWidget` — owns the inline `TextEditingController` for role input.
- **Input:** `roles: List<String>`, `hasError: bool`, `onRoleAdded`, `onRoleRemoved`
- **Logic:** The inline text field triggers `onRoleAdded` on `TextInputAction.done`. Roles are shown as removable `BridgeXChip` widgets.
- **Error state:** `hasError = true` applies a red `1.5px` border on the container.
- **No `buildWhen`** — this builder must always respond to parent state so `hasError` updates are reflected immediately.

### `ProjectDescriptionField`
- **File:** `presentation/widgets/create_team_widgets/project_description_field.dart`
- **Input:** `controller: TextEditingController`, `validator: FormFieldValidator<String>?`
- **Renders:** A 5-line `BridgeXTextFormField` with multiline input.

### `TeamMembersSection`
- **File:** `presentation/widgets/create_team_widgets/team_members_section.dart`
- **Conditional:** Only shown when `selectedTeamType == 1` (Public).
- **Rebuild condition:** Only when `selectedTeamType` changes (shared `BlocBuilder` with `TeamTypeSelector` visibility logic).

---

## 9. Edge Cases & Logic Rules

### ✅ Successful Submission
1. Form validates → roles non-empty → `createTeam()` called.
2. `LoadingDialog` shown.
3. API responds with `201` → `SuccessDialog` shown.
4. User taps action → `ScrollCubit.show()` called (restores bottom nav bar) → screen popped.

### ❌ API Server Error (e.g., 422 Validation)
1. `ErrorDialog` shown with `state.errorMessage` from the server response.
2. User taps "Try Again" → `resetStatus()` called → `status` resets to `.initial`.
3. Dialog is dismissed, user can correct form and resubmit.

### ❌ Network Unavailable
1. `NetworkFailure` emitted by repository when `networkInfo.isConnected == false`.
2. Error dialog shown with a network error message.
3. No partial state corruption — `entity` remains `null`.

### 🛑 Roles Validation (Empty Roles)
1. User submits with no roles → `setShowRolesError(true)` emitted.
2. `RequiredRolesSection` rebuilds with `hasError: true` → red border appears.
3. Adding a role calls `addRole()` → Cubit automatically sets `showRolesError: false`.
4. Removing the last role calls `removeRole()` → Cubit automatically sets `showRolesError: true`.

### 🛑 Dialog Collision Prevention
- `_isLoadingDialogShowing` in `_CreateTeamScreenState` prevents `LoadingDialog.show()` from being called twice.
- `listenWhen: previous.status != current.status` ensures the listener only fires on actual status transitions, not when other state fields (like `selectedRoles`) change.

### 👁️ Public vs Private — `TeamMembersSection`
- `TeamMembersSection` is rendered inside a `BlocBuilder` with `buildWhen: selectedTeamType`.
- When `selectedTeamType == 0` (Private) → `SizedBox.shrink()` is returned (no render cost).
- When `selectedTeamType == 1` (Public) → `TeamMembersSection` + `VerticalSpacing` are rendered.

### 🔢 Role Deduplication
- `addRole()` in the Cubit checks `updatedRoles.contains(role)` before adding.
- Duplicate roles are silently ignored — no error is shown to the user.

### 📋 Pre-seeded Roles
- `selectedRoles` starts with `['Frontend', 'UX Designer']` by default (in `CreateTeamState`).
- This encourages the user to have at least some roles from the start and makes the form feel pre-filled.

---

## 10. Dependency Injection

All registrations are in `create_team_injection.dart`, called at app startup.

| Type | Registration | Scope |
|---|---|---|
| `CreateTeamCubit` | `registerFactory` | New instance per `BlocProvider` |
| `CreateTeamUseCase` | `registerLazySingleton` | Shared instance |
| `CreateTeamRepo` → `CreateTeamRepoImplement` | `registerLazySingleton` | Shared instance |
| `CreateTeamRemoteData` → `CreateTeamRemoteDataImpl` | `registerLazySingleton` | Shared instance |

> `CreateTeamCubit` is `registerFactory` (not singleton) because a fresh cubit with clean state is required each time the user navigates to the Create Team screen.

---

## 11. File Map

```
lib/feature/create_team/
│
├── di/
│   └── create_team_injection.dart          # DI wiring
│
├── domain/
│   ├── entity/
│   │   ├── create_team_entity.dart         # Root response entity
│   │   ├── create_team_params.dart         # Usecase input parameters (domain-only)
│   │   ├── project_entity.dart             # Nested project entity
│   │   └── team_entity.dart                # Nested team entity
│   ├── repo/
│   │   └── create_team_repo.dart           # Abstract repository contract
│   └── usecases/
│       └── create_team_usecase.dart        # Single usecase: create a team
│
├── data/
│   ├── models/
│   │   ├── create_team_request_model.dart  # Serializable API request body
│   │   ├── create_team_response_model.dart # JSON → CreateTeamEntity
│   │   ├── project_model.dart              # JSON → ProjectEntity
│   │   └── team_model.dart                 # JSON → TeamEntity
│   ├── remote_data/
│   │   └── create_team_remote_data.dart    # Abstract + Impl: Dio POST call
│   └── repo_implement/
│       └── create_team_repo_implement.dart # Maps params → model, handles errors
│
└── presentation/
    ├── controller/
    │   ├── create_team_cubit.dart          # State machine + business event handlers
    │   └── create_team_state.dart          # Single immutable state with copyWith
    ├── screens/
    │   └── create_team_screen.dart         # Root screen: BlocProvider + BlocListener + Scaffold
    ├── utils/
    │   └── create_team_mapper.dart         # Category index → string, role → API track mapping
    └── widgets/
        └── create_team_widgets/
            ├── create_team_form_content.dart   # Full form widget (owns controllers + formKey)
            ├── category_selection_section.dart # Chip-based category picker
            ├── project_description_field.dart  # Multiline text field wrapper
            ├── required_roles_section.dart     # Chip list + inline add input
            ├── team_members_section.dart       # Invite members UI (public teams only)
            ├── team_type_card.dart             # Single Private/Public card
            └── team_type_selector.dart         # Two-card team type picker
```
