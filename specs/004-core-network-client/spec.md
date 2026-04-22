# Feature Specification: Core Network Client

**Feature Branch**: `004-core-network-client`  
**Created**: 2026-04-22  
**Status**: Draft  
**Input**: Phase 3 — Core: Network Client (Dio) from implementation_plan.md

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Centralized Network Connectivity & API Client (Priority: P1)

As a mobile application, I need a centralized, configured HTTP client to handle all outbound API requests so that connection timeouts, base URLs, and logging are consistent across all feature modules.

**Why this priority**: Without a functional API client, no remote data sources can communicate with the backend. This is a foundational infrastructure requirement.

**Independent Test**: The Dio client can be instantiated and a simple GET request to a public API placeholder (or backend stub) succeeds with logs visible in debug mode.

**Acceptance Scenarios**:

1. **Given** the app is running in debug mode, **When** an API request is made, **Then** the request and response details are logged to the console in a readable format.
2. **Given** the app has no internet connection, **When** a repository attempts to check connection status, **Then** the system accurately reports `false`.

---

### User Story 2 - Automatic Authentication & Session Management (Priority: P1)

As a secure application, I need the network client to automatically inject authentication tokens into requests and handle session expirations seamlessly so that users remain authenticated or are gracefully logged out.

**Why this priority**: Security and session management are critical for user data protection. Handling 401s globally prevents unauthorized access loops.

**Independent Test**: Simulating an expired token response triggers the global logout/redirect sequence.

**Acceptance Scenarios**:

1. **Given** a valid authentication token exists in local storage, **When** an API request is made, **Then** the `Authorization: Bearer <token>` header is automatically appended.
2. **Given** an API request is made, **When** the server responds with a 401 Unauthorized status, **Then** the local token is cleared and a signal is emitted to redirect the user to the login screen.

---

### User Story 3 - Global Error Mapping & Local Storage (Priority: P2)

As a robust application, I need all HTTP errors mapped to domain-specific Exceptions and a reliable local storage mechanism for caching basic preferences (tokens, roles).

**Why this priority**: Ensures the presentation layer receives consistent error states rather than raw HTTP stack traces.

**Independent Test**: Simulating a 500 response from the server correctly throws a `ServerException`.

**Acceptance Scenarios**:

1. **Given** an API request fails with a 500 Internal Server Error, **When** the response is intercepted, **Then** it is mapped to a `ServerException`.
2. **Given** the app needs to save user preferences, **When** a token or first-launch flag is saved to `CacheHelper`, **Then** it persists across app restarts.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST provide a singleton `ApiClient` configured with base URL, and 30-second connect/receive timeouts.
- **FR-002**: The system MUST intercept all outgoing requests to append the `Authorization` header if a token exists in `CacheHelper`.
- **FR-003**: The system MUST intercept all incoming responses to map 401 status codes to a global unauthenticated state, clearing the cache and redirecting to login.
- **FR-004**: The system MUST intercept 5xx server errors and network timeouts, throwing corresponding typed Exceptions (`ServerException`, `NetworkException`).
- **FR-005**: The system MUST provide a `NetworkInfo` interface to check active internet connectivity.
- **FR-006**: The system MUST provide a `CacheHelper` utility wrapping local storage to persist strings (tokens, roles) and booleans (first launch flags).

### Key Entities

- **ApiClient**: The wrapper around the HTTP client (Dio).
- **AuthInterceptor**: Middleware handling token injection and 401 token expiration.
- **ErrorInterceptor**: Middleware handling HTTP status code to Exception mapping.
- **CacheHelper**: Key-value persistent storage wrapper.
- **NetworkInfo**: Connectivity status checker.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All remote data source requests utilize the unified `ApiClient` without configuring timeouts or headers individually.
- **SC-002**: A 401 Unauthorized response from any endpoint automatically triggers the cache clearing mechanism within 100 milliseconds.
- **SC-003**: Request/Response logging is entirely disabled in production builds.

## Assumptions

- The backend APIs will use standard HTTP status codes (200 for success, 401 for unauthorized, 5xx for server errors).
- Tokens are standard string-based Bearer tokens.
- `SharedPreferences` is sufficient for local key-value storage (no encrypted database needed for tokens at this stage, unless specified later).
