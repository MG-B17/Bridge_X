---
description: "Task list for Core: Error Handling & UseCase Base"
---

# Tasks: Core: Error Handling & UseCase Base

**Input**: Design documents from `/specs/003-error-handling-usecase/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: No explicit tests requested, but equatable overrides will be manually checked in polish phase.
**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic dependencies

- [x] T001 Verify or add `dartz` (^0.10.1) and `equatable` (^2.0.5) to `pubspec.yaml` and run `flutter pub get`.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

*(No blocking prerequisites beyond Phase 1. The entire feature is foundational.)*

**Checkpoint**: Foundation ready - user story implementation can now begin.

---

## Phase 3: User Story 1 - Error Hierarchy & Representation (Priority: P1) 🎯 MVP

**Goal**: Establish standardized exception and failure types for cross-layer error mapping.

**Independent Test**: Static analysis passes, and manually testing `ServerFailure` equatable comparison works.

### Implementation for User Story 1

- [x] T002 [P] [US1] Create `lib/core/error/exception.dart`. Define `ServerException`, `CacheException`, `NetworkException`, `UnauthorizedException`, all with a `required String message`.
- [x] T003 [P] [US1] Create `lib/core/error/error_strings.dart`. Define standard error string constants: `serverFailureMessage`, `cacheFailureMessage`, `networkFailureMessage`, `unauthorizedMessage`, `unexpectedErrorMessage`.
- [x] T004 [US1] Create `lib/core/error/failure.dart`. Define abstract `Failure extends Equatable` with `message` and `props`. Implement subclasses: `ServerFailure`, `CacheFailure`, `NetworkFailure`, `UnauthorizedFailure`, `UnknownFailure`.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - UseCase Base Contract (Priority: P1)

**Goal**: Enforce functional error handling boundaries using the `Either` monad.

**Independent Test**: Mock `UseCase` compiles and successfully returns `Right('Success')` and `Left(ServerFailure(...))`.

### Implementation for User Story 2

- [x] T005 [P] [US2] Create `lib/core/usecases/usecase.dart`. Define abstract `UseCase<T, Params>` interface with `call({required Params params})` returning `Future<Either<Failure, T>>`. Define `NoParams extends Equatable` auxiliary class.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories and validation.

- [x] T006 Run `flutter analyze` and resolve any issues.
- [x] T007 Run `dart` file or test script locally to verify `Failure` equality checking and `Either` compilation (as outlined in quickstart.md).

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Setup.
- **User Story 2 (P1)**: Can start after Setup, but depends on `Failure` type defined in US1.

### Parallel Opportunities

- T002 and T003 can be implemented in parallel.

---

## Implementation Strategy

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently
3. Add User Story 2 → Test independently 
