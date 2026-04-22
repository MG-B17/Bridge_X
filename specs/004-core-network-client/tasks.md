---
description: "Task list for Core Network Client implementation"
---

# Tasks: Core Network Client

**Input**: Design documents from `/specs/004-core-network-client/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic dependencies

- [x] T001 Verify `dio` (^5.6.0), `pretty_dio_logger` (^1.4.0), `shared_preferences` (^2.3.2), and `internet_connection_checker_plus` (^2.5.1) are in `pubspec.yaml` and run `flutter pub get`.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

- [x] T002 [P] Create `lib/core/network/api_endpoints.dart` with `static const String baseUrl` and placeholders.
- [x] T003 [P] Create `lib/core/helper/cache/cache_helper.dart` with abstract interface and SharedPreferences implementation.

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Centralized Network Connectivity & API Client (Priority: P1) 🎯 MVP

**Goal**: A centralized, configured HTTP client to handle all outbound API requests and connectivity checking.

**Independent Test**: The Dio client can be instantiated and `NetworkInfo` returns valid internet status.

### Tests for User Story 1

- [x] T004 [P] [US1] Create basic instantiation tests for `NetworkInfo` in `test/core/network/network_info_test.dart`.

### Implementation for User Story 1

- [x] T005 [P] [US1] Implement `NetworkInfo` interface and class using `internet_connection_checker_plus` in `lib/core/network/network_info.dart`.
- [x] T006 [US1] Create `lib/core/network/api_client.dart` with a singleton `Dio` instance configured with base URL, timeouts, and `pretty_dio_logger` in debug mode.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Automatic Authentication & Session Management (Priority: P1)

**Goal**: Automatically inject authentication tokens into requests and handle session expirations seamlessly.

**Independent Test**: Simulating an expired token response triggers the global logout/redirect sequence.

### Tests for User Story 2

- [x] T007 [P] [US2] Create tests for SharedPreferences cache handling in `test/core/helper/cache/cache_helper_test.dart`.

### Implementation for User Story 2

- [x] T008 [US2] Implement `AuthInterceptor` in `lib/core/network/api_client.dart` that reads token from `CacheHelper` and adds `Authorization: Bearer` header.
- [x] T009 [US2] Add 401 handling in `AuthInterceptor` within `lib/core/network/api_client.dart` to call `deleteToken()` on `CacheHelper`.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Global Error Mapping & Local Storage (Priority: P2)

**Goal**: All HTTP errors mapped to domain-specific Exceptions and a reliable local storage mechanism for caching basic preferences.

**Independent Test**: Simulating a 500 response correctly throws a `ServerException`.

### Tests for User Story 3

- [x] T010 [P] [US3] Create tests for `ErrorInterceptor` error mapping in `test/core/network/api_client_test.dart`.

### Implementation for User Story 3

- [x] T011 [US3] Implement `ErrorInterceptor` in `lib/core/network/api_client.dart` mapping `DioException` types to domain `Exception`s (`ServerException`, `NetworkException`, `UnauthorizedException`).

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories and validation.

- [x] T012 Run `flutter analyze` and resolve any issues.
- [x] T013 Run all tests in `test/core/network/` and `test/core/helper/cache/` to ensure coverage minimums.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Can start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion.
- **User Stories (Phase 3+)**: All depend on Foundational phase completion.
- **Polish (Final Phase)**: Depends on all user stories.

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational.
- **User Story 2 (P1)**: Depends on User Story 1 (requires `api_client.dart` to exist).
- **User Story 3 (P2)**: Depends on User Story 1 and 2 (requires `api_client.dart` to exist).

### Parallel Opportunities

- T002 and T003 can be executed in parallel.
- Test implementations (T004, T007, T010) can be created in parallel before/alongside their implementations.

---

## Implementation Strategy

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Instantiate ApiClient and check network
3. Add User Story 2 → Inject auth tokens
4. Add User Story 3 → Map errors robustly
