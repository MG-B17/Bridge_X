---
description: "Task list for Core Router & DI Shell implementation"
---

# Tasks: Core Router & DI Shell

**Input**: Design documents from `/specs/005-router-di-shell/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create required directories for navigation and DI in lib/core/
- [x] T002 [P] Create initial lib/core/navigation/app_route_constant.dart
- [x] T003 [P] Create initial lib/core/navigation/app_route.dart
- [x] T004 [P] Create initial lib/core/di/di.dart

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 Update lib/main.dart to make main() async and ensure WidgetsFlutterBinding is initialized

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 2 - System Stability on Startup (Priority: P1) 🎯 MVP

**Goal**: The application reliably initializes core services (storage, network) prior to displaying any interface.

**Independent Test**: Can be tested by launching the application and verifying that background services are registered successfully before the initial screen renders.

### Implementation for User Story 2

- [x] T006 [US2] Implement get_it service locator instance initialization in lib/core/di/di.dart
- [x] T007 [US2] Register SharedPreferences and CacheHelper singletons in lib/core/di/di.dart
- [x] T008 [US2] Register ApiClient and NetworkInfo singletons in lib/core/di/di.dart
- [x] T009 [US2] Update lib/main.dart to await initDi() before executing runApp()

**Checkpoint**: At this point, User Story 2 is fully functional. The app initializes its DI shell successfully without crashing.

---

## Phase 4: User Story 1 - Secure App Entry and Navigation Guarding (Priority: P1)

**Goal**: Users launching the app are automatically directed to the correct screen based on authentication and role.

**Independent Test**: Can be tested by altering local auth state in CacheHelper and verifying the landing page is correct upon launch.

### Implementation for User Story 1

- [x] T010 [P] [US1] Define static constant route paths (e.g., /, /login, /onboarding, /home) in lib/core/navigation/app_route_constant.dart
- [x] T011 [US1] Implement GoRouter instance definition in lib/core/navigation/app_route.dart
- [x] T012 [US1] Add redirect guard logic to GoRouter in lib/core/navigation/app_route.dart checking token and role via CacheHelper
- [x] T013 [US1] Create basic stub Scaffold widgets for all unbuilt routes inside lib/core/navigation/app_route.dart

**Checkpoint**: At this point, User Stories 1 AND 2 should both work. The app routes users securely.

---

## Phase 5: User Story 3 - Graceful Handling of Unknown Links (Priority: P2)

**Goal**: Users who click on a broken deep link or navigate to an unbuilt section see a friendly error screen.

**Independent Test**: Can be tested by forcing navigation to a non-existent route URL and verifying the error screen shows.

### Implementation for User Story 3

- [x] T014 [US3] Implement GoRouter errorBuilder in lib/core/navigation/app_route.dart to display a branded "Page not found" screen

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T015 Run quickstart.md validation for DI and Router guidelines
- [x] T016 Verify no core layer rules (Clean Architecture) were violated

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion
- **User Stories (Phase 3+)**: US2 must be completed before US1, as US1's navigation guard depends on CacheHelper being registered in DI. US3 can be done after US1.

### User Story Dependencies

- **User Story 2 (P1)**: Can start after Foundational. Handles DI setup.
- **User Story 1 (P1)**: Depends on User Story 2 (DI must be ready).
- **User Story 3 (P2)**: Depends on User Story 1 (GoRouter must be initialized).

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- T010 can run in parallel with US2 implementation

---

## Parallel Example: User Story 2

```bash
# Launch file creations in parallel:
Task: "Create initial lib/core/navigation/app_route_constant.dart"
Task: "Create initial lib/core/navigation/app_route.dart"
Task: "Create initial lib/core/di/di.dart"
```

## Implementation Strategy

### MVP First (User Story 2 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 2
4. **STOP and VALIDATE**: Verify that DI registers successfully on startup without crashing.

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 2 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 1 → Test independently → Secure routing ready
4. Add User Story 3 → Test independently → Full routing system complete
