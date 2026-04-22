---
description: "Task list for Extensions, Color Schema & Shared Widgets"
---

# Tasks: Extensions, Color Schema & Shared Widgets

**Input**: Design documents from `/specs/006-extensions-theme-widgets/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create required directories `theme/`, `constant/`, `utils/`, and `widgets/` in `lib/core/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T002 [P] Create `lib/core/constant/app_spacing.dart` with sizing constants (e.g., xs, sm, md, lg, xl, xxl, radiusCard, radiusPill)

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Developing a New Screen (Theme & Forms) 🎯 MVP

**Goal**: Developers can access the full design system (colors, typography) via `BuildContext` and use shared foundational form widgets.

**Independent Test**: Can be tested by creating a dummy screen that uses `context.colors.primary`, `context.headlineMedium`, `AppButton`, `AppTextField`, and `AppAvatar` without compilation errors or direct imports to design classes.

### Implementation for User Story 1

- [x] T003 [US1] Create `lib/core/theme/app_color_scheme.dart` defining the `ThemeExtension` with light and dark palettes
- [x] T004 [P] [US1] Create `lib/core/theme/text_style.dart` for the Inter typography hierarchy
- [x] T005 [US1] Create `lib/core/theme/app_them.dart` defining `lightTheme` and `darkTheme` utilizing the `AppColorScheme`
- [x] T006 [US1] Create `lib/core/utils/extensions.dart` providing `BuildContext` extensions for colors, typography, screen sizes, and `SnackBar`
- [x] T007 [P] [US1] Create `lib/core/utils/validators.dart` with email, password, and required field validation logic
- [x] T008 [P] [US1] Create `lib/core/utils/date_formatter.dart`
- [x] T009 [P] [US1] Implement `lib/core/widgets/bridge_app_button.dart` using context extensions
- [x] T010 [P] [US1] Implement `lib/core/widgets/app_text_field.dart` using context extensions
- [x] T011 [P] [US1] Implement `lib/core/widgets/app_avatar.dart` using `cached_network_image`

**Checkpoint**: The design system core is ready. Standard UI elements can be built without duplicating styles.

---

## Phase 4: User Story 2 - Handling Loading and Error States

**Goal**: The system provides branded, consistent indicators for loading and error states that can be dropped into any screen.

**Independent Test**: Can be tested by displaying `AppLoading` and `AppErrorWidget` on a test screen and verifying they match Figma specs.

### Implementation for User Story 2

- [x] T012 [P] [US2] Implement `lib/core/widgets/app_loading.dart` containing a branded `CircularProgressIndicator`
- [x] T013 [P] [US2] Implement `lib/core/widgets/app_error_widget.dart` containing an error icon, message text, and an optional retry `AppButton`

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T014 Review `lib/app.dart` to ensure `AppTheme.light` and `AppTheme.dark` are correctly assigned to `MaterialApp.router`
- [x] T015 Run quickstart.md validation to ensure developers can access colors correctly without direct imports

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion
- **User Stories (Phase 3+)**: US1 requires Foundational. US2 requires US1 because `AppErrorWidget` relies on `AppButton` from US1.

### Parallel Opportunities

- T004, T007, T008 can be built in parallel.
- All widgets (T009, T010, T011) can be implemented in parallel once T006 (extensions) is complete.
- T012 and T013 can be built in parallel after US1.

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Verify the theme extension and context getters function correctly before moving on to error states.

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Theming and forms ready (MVP)
3. Add User Story 2 → Test independently → Full core UI toolkit ready
