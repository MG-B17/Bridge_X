# Task Management Feature — Technical Documentation

> **Feature:** Task Management (Create Task + View Tasks)  
> **Screens:** `CreateTaskScreen`, `ViewTaskScreen`  
> **Entry points:** "Create & Assign Task" button in Team Settings, "View Tasks" button in Project Details

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

The Task Management feature handles all task-related operations within a project team:

- **Create Task** — A modal bottom-sheet form for creating and assigning tasks to team members
- **View Tasks** — A full-screen view showing all project tasks grouped by status (In Progress, To Do, Completed)

---

## 2. Architecture

```
Presentation  →  Domain  →  Data
(Cubit/UI)       (UseCases/Entities)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|
| **Presentation** | UI rendering, state management via Cubit |
| **Domain** | Business rules via use cases, pure entities |
| **Data** | API calls via `ApiClient`, JSON parsing |

### Key Design Decisions
- **Cubit** (not Bloc) for both flows — simpler state management without events
- **No setState** — all form state (selected member, priority, date, tags) managed in Cubit
- **Cross-feature dependency** — `CreateTaskCubit` uses `ProjectsManagementRepository.getTeamSettings()` to fetch team members
- **`isClosed` guards** on all async methods to prevent emit-after-close errors
- **Double-submit prevention** — guards in `submitTask()` check current state before emitting

---

## 3. Screens & Navigation

Both screens are registered under `project_route` in `lib/core/navigation/routes/project_route.dart`.

| Screen | Route Name | Transition | Entry Point |
|---|---|---|---|
| `CreateTaskScreen` | `create-task` | BottomSheetTransitionPage (slide up) | "Create & Assign Task" in TeamSettingsContent |
| `ViewTaskScreen` | `view-task` | SlideRightTransitionPage | "View Tasks" in ProjectDetailsActionButtons |

### Navigation Args

| Screen | Args Class | Fields |
|---|---|---|
| `CreateTaskScreen` | `CreateTaskArgs` | `projectId` |
| `ViewTaskScreen` | `ViewTaskArgs` | `projectId` |

---

## 4. Data Model & API Contracts

### 4.1 Create Task

**Endpoint:** `POST /api/tasks/team/:projectId` (`ApiEndpoint.createTask`)

**Request:**
```json
{
  "title": "إعداد قاعدة البيانات",
  "description": "تصميم وإنشاء قاعدة البيانات",
  "programmer_id": 5,
  "deadline": "2026-05-30",
  "priority": 1,
  "git_link": "https://github.com/your-org/your-repo",
  "tags": ["database", "backend"]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "programmer_id": 5,
    "title": "إعداد قاعدة البيانات",
    "description": "...",
    "status": "todo",
    "deadline": "2026-05-30T00:00:00.000000Z",
    "priority": 1,
    "git_link": "https://github.com/...",
    "tags": ["database", "backend"],
    "team_id": 6,
    "programmer": { "id": 5, "user": { "full_name": "Mostafa Galal" } }
  }
}
```

**Entity:** `CreateTaskEntity`

| Field | Type |
|---|---|
| `id` | `int` |
| `title` | `String` |
| `description` | `String` |
| `status` | `String` |
| `programmerId` | `int` |
| `programmerName` | `String` |
| `deadline` | `String` |
| `priority` | `int` |
| `gitLink` | `String?` |
| `tags` | `List<String>` |
| `teamId` | `int` |

---

### 4.2 View Tasks

**Endpoint:** `GET /api/team/:projectId/full-details` (`ApiEndpoint.viewTask`)  
**Query Parameters:** `tasks_view=my`

**Response:**
```json
{
  "success": true,
  "data": {
    "team_id": 4,
    "team_name": "Micro Masr Team",
    "project_description": "...",
    "github_link": "https://github.com/...",
    "my_track": "general",
    "members": [{ "id": 5, "name": "Mostafa Galal", "avatar_url": null, "track": "general", "role": "leader" }],
    "tasks_view": "my",
    "tasks": [{ "id": 2, "title": "...", "description": "...", "status": "todo", "due_date": "2026-05-28", "priority": 1, "created_at": "2026-05-25 23:31:02" }]
  }
}
```

**Entity:** `ViewTaskEntity`

| Field | Type |
|---|---|
| `teamId` | `int` |
| `teamName` | `String` |
| `projectDescription` | `String` |
| `githubLink` | `String?` |
| `myTrack` | `String` |
| `members` | `List<ViewTaskMemberEntity>` |
| `tasksView` | `String` |
| `tasks` | `List<TaskEntity>` |

**Computed getters:**
- `inProgressTasks` → tasks where `status == 'in_progress'`
- `todoTasks` → tasks where `status == 'todo'`
- `completedTasks` → tasks where `status == 'completed'`

**Entity:** `TaskEntity`

| Field | Type |
|---|---|
| `id` | `int` |
| `title` | `String` |
| `description` | `String` |
| `status` | `String` (`todo`, `in_progress`, `completed`) |
| `dueDate` | `String` |
| `priority` | `int` (1=High, 2=Medium, 3=Low) |
| `createdAt` | `String` |

**Entity:** `ViewTaskMemberEntity`

| Field | Type |
|---|---|
| `id` | `int` |
| `name` | `String` |
| `avatarUrl` | `String?` |
| `track` | `String` |
| `role` | `String` |

---

## 5. State Machines

### 5.1 CreateTaskCubit

```
CreateTaskInitial
    │ loadMembers(projectId)
    ▼
CreateTaskMembersLoading
    │
    ├─ success → CreateTaskReady(members, priority=2, tags=[], date=null, selectedMember=null)
    │                │
    │                ├─ selectMember() → CreateTaskReady(selectedMemberId updated)
    │                ├─ setPriority() → CreateTaskReady(priority updated)
    │                ├─ setDate() → CreateTaskReady(selectedDate updated)
    │                ├─ addTag() → CreateTaskReady(tags updated)
    │                ├─ removeTag() → CreateTaskReady(tags updated)
    │                │
    │                └─ submitTask() → CreateTaskLoading
    │                                      │
    │                                      ├─ success → CreateTaskSuccess(task)
    │                                      └─ failure → CreateTaskError(message)
    │
    └─ failure → CreateTaskError(message)
```

### 5.2 ViewTaskCubit

```
ViewTaskInitial
    │ loadTasks(projectId)
    ▼
ViewTaskLoading
    │
    ├─ success → ViewTaskLoaded(data)
    │                │ refresh()
    │                ▼
    │            ViewTaskRefreshing(data)
    │                │
    │                ├─ success → ViewTaskLoaded(newData)
    │                └─ failure → ViewTaskError(message)
    │
    └─ failure → ViewTaskError(message)
                     │ retry()
                     └─► loadTasks(projectId)
```

---

## 6. Data Flow

### Create Task — Submission Flow

```
User fills form → taps "Create Task"
    │
    └─► _submit() validates form
            │ guard: form valid + date selected + member selected
            ▼
        cubit.submitTask(projectId, title, description, deadline, gitLink)
            │
            emit(CreateTaskLoading)
            │ → UI shows LoadingDialog
            │
            └─► CreateTaskUseCase → TaskRepository → TaskRemoteDataSource
                    │ POST /api/tasks/team/:projectId
                    │
                    ├─ success → emit(CreateTaskSuccess)
                    │             → UI: hide LoadingDialog, show SuccessDialog, pop screen
                    │
                    └─ failure → emit(CreateTaskError)
                                  → UI: hide LoadingDialog, show ErrorDialog
```

### Create Task — Members Loading

```
CreateTaskScreen mounted (via BlocProvider in route)
    └─► cubit.loadMembers(projectId)
            └─► ProjectsManagementRepository.getTeamSettings(projectId)
                    └─► GET /api/teams/:projectId/details
                            └─► members extracted → emit(CreateTaskReady)
```

### View Tasks — Load Flow

```
ViewTaskScreen mounted (via BlocProvider in route)
    └─► cubit.loadTasks(projectId)
            └─► emit(ViewTaskLoading)
                    └─► GetViewTaskUseCase → TaskRepository → TaskRemoteDataSource
                            │ GET /api/team/:projectId/full-details?tasks_view=my
                            │
                            ├─ success → emit(ViewTaskLoaded(data))
                            └─ failure → emit(ViewTaskError(message))
```

### View Tasks — Refresh Flow

```
User pulls down
    └─► cubit.refresh()
            │ guard: not already loading/refreshing
            ▼
        emit(ViewTaskRefreshing(currentData))
            │ → BridgeXSkeletonizer enabled, RefreshIndicator hidden (transparent)
            │
            └─► Same fetch as above
                    ├─ success → emit(ViewTaskLoaded(freshData))
                    └─ failure → emit(ViewTaskError(message))
```

---

## 7. Widget Tree

### CreateTaskScreen

```
CreateTaskScreen (StatefulWidget — for TextEditingControllers only)
└── BlocListener<CreateTaskCubit> (handles dialogs)
    └── Scaffold
        └── SafeArea > Column
            ├── CreateTaskHeader (X button + "Create Task" title)
            └── Expanded > SingleChildScrollView > Form
                └── Column
                    ├── TaskTitleField
                    ├── GitLinkField
                    ├── AssignToSection
                    │   ├── Search field
                    │   └── Horizontal ListView (member avatars + Add button)
                    ├── TaskDescriptionField
                    ├── BlocSelector<DateTime?> → DueDatePriorityRow
                    │   ├── Date picker container
                    │   └── PrioritySelector (Wrap: LOW / MED / HIGH chips)
                    ├── TagsSection
                    │   ├── Tag chips (with delete)
                    │   └── "+ Tag" button → dialog
                    └── BridgeXButton ("Create Task")
```

### ViewTaskScreen

```
ViewTaskScreen
└── BlocProvider<ViewTaskCubit>..loadTasks(projectId)
    └── Scaffold > SafeArea
        └── BlocBuilder<ViewTaskCubit>
            ├── [Error] → BridgeXErrorWidget (retry)
            └── BridgeXSkeletonizer
                └── BridgeXRefreshIndicator
                    └── SingleChildScrollView
                        └── Column
                            ├── Header (← back + "Project Tasks" + subtitle)
                            ├── ViewTaskProjectCard (Ongoing badge + name + track)
                            └── Task Sections:
                                ├── TaskSectionHeader("In Progress", count)
                                │   └── InProgressTaskCard(s)
                                ├── TaskSectionHeader("To Do", count)
                                │   └── TodoTaskCard(s)
                                └── TaskSectionHeader("Completed", count)
                                    └── CompletedTaskCard(s)
```

---

## 8. Edge Cases & Logic Rules

### Create Task

| Case | Handling |
|---|---|
| Screen closed during API call | `isClosed` guard prevents emit-after-close |
| Double submit | Guard: `if (state is CreateTaskLoading) return` |
| No member selected | `_submit()` returns early if `selectedMemberId == null` |
| No date selected | `_submit()` returns early if `selectedDate == null` |
| Empty tags | Allowed — tags array sent as `[]` |
| Git link empty | Sent as `null` (not included in request) |
| Git link invalid | `AppValidator.url` shows validation error |
| Date picker dismissed | `mounted` check before calling `cubit.setDate()` |

### View Tasks

| Case | Handling |
|---|---|
| Empty tasks list | No section headers rendered (all `if (list.isNotEmpty)` guarded) |
| Empty members list | `firstMember` defaults to `null`, "Assigned by" shows blank |
| Null avatar | Fallback `Icon(Icons.person)` in avatar widget |
| Long task title/description | `maxLines: 2` + `TextOverflow.ellipsis` |
| Screen reopen | Always fetches fresh data (no cache) |
| Refresh after error | `retry()` calls `loadTasks(projectId)` again |
| Concurrent refresh | Guard: `if (state is ViewTaskLoading || state is ViewTaskRefreshing) return` |

### Priority Badge Colors

| Priority | Label | Color |
|---|---|---|
| 1 | High | `colors.error` (red) |
| 2 | Medium | `colors.gold` (amber) |
| 3 | Low | `colors.success` (green) |

### Task Status Styling

| Status | Card Style |
|---|---|
| `in_progress` | White card with border + shadow, progress bar |
| `todo` | Light green-tinted background |
| `completed` | Light green background + green checkmark icon |

---

## 9. Dependency Injection

All registrations in `task_management_injection.dart`:

| Type | Registration | Scope |
|---|---|---|
| `TaskRemoteDataSource` | `registerLazySingleton` | Shared |
| `TaskRepository` | `registerLazySingleton` | Shared |
| `CreateTaskUseCase` | `registerLazySingleton` | Shared |
| `GetViewTaskUseCase` | `registerLazySingleton` | Shared |
| `CreateTaskCubit` | `registerFactory` | Per screen |
| `ViewTaskCubit` | `registerFactory` | Per screen |

> **Cross-feature dependency:** `CreateTaskCubit` receives `ProjectsManagementRepository` (from projects_management DI) to fetch team members via `getTeamSettings()`.

---

## 10. File Map

```
lib/feature/task_management/
│
├── di/
│   └── task_management_injection.dart
│
├── domain/
│   ├── entities/
│   │   ├── create_task_entity.dart
│   │   ├── task_entity.dart
│   │   ├── view_task_entity.dart
│   │   └── view_task_member_entity.dart
│   ├── repositories/
│   │   └── task_repository.dart
│   └── usecases/
│       ├── create_task_usecase.dart
│       └── get_view_task_usecase.dart
│
├── data/
│   ├── models/
│   │   ├── create_task_request_model.dart
│   │   ├── create_task_response_model.dart
│   │   └── view_task_response_model.dart
│   ├── datasources/
│   │   └── task_remote_data_source.dart
│   └── repositories/
│       └── task_repository_impl.dart
│
└── presentation/
    ├── bloc/
    │   ├── create_task/
    │   │   ├── create_task_cubit.dart
    │   │   └── create_task_state.dart
    │   └── view_task/
    │       ├── view_task_cubit.dart
    │       └── view_task_state.dart
    ├── screens/
    │   ├── create_task_screen.dart
    │   └── view_task_screen.dart
    └── widgets/
        ├── create_task_widgets/
        │   ├── create_task_header.dart
        │   ├── create_task_form_fields.dart (TaskTitleField, GitLinkField, TaskDescriptionField, DueDatePriorityRow, CreateTaskLabel)
        │   ├── assign_to_section.dart
        │   ├── priority_selector.dart
        │   └── tags_section.dart
        └── view_task_widgets/
            ├── view_task_project_card.dart
            ├── task_section_header.dart
            ├── in_progress_task_card.dart
            ├── todo_task_card.dart
            └── completed_task_card.dart
```
