# Implementation Plan: Core Network Client

**Branch**: `004-core-network-client` | **Date**: 2026-04-22 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/004-core-network-client/spec.md`

## Summary

Implement a centralized, unified API client using `dio` and `shared_preferences`. This includes a `CacheHelper` for local storage, `NetworkInfo` for connectivity checking, and an `ApiClient` configured with global authentication and error interceptors that seamlessly map HTTP states to the previously established `Failure`/`Exception` hierarchy.

## Technical Context

**Language/Version**: Dart 3.x
**Primary Dependencies**: `dio ^5.6.0`, `pretty_dio_logger ^1.4.0`, `internet_connection_checker_plus ^2.5.1`, `shared_preferences ^2.3.2`
**Storage**: SharedPreferences (Local key-value)
**Testing**: `flutter_test`, `mocktail`
**Target Platform**: iOS, Android
**Project Type**: Mobile App (Flutter)
**Performance Goals**: N/A
**Constraints**: All raw HTTP exceptions must be caught and mapped in the ErrorInterceptor.
**Scale/Scope**: Core architecture networking layer.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **Clean Architecture (I)**: Interceptors and `ApiClient` belong in `core/network`. `CacheHelper` belongs in `core/helper/cache`.
- [x] **Figma Fidelity (II)**: N/A (No UI).
- [x] **State Management Contract (III)**: N/A (No Bloc/Cubit).
- [x] **Context-First Design System Access (IV)**: N/A.
- [x] **Test-First Quality Gates (V)**: Network layer requires **70% minimum coverage**, specifically testing error interceptor mapping.

**Gate Status: PASS**

## Project Structure

### Documentation (this feature)

```text
specs/004-core-network-client/
├── plan.md              
├── research.md          
├── data-model.md        
├── quickstart.md        
└── tasks.md             
```

### Source Code

```text
lib/
└── core/
    ├── helper/
    │   └── cache/
    │       └── cache_helper.dart
    └── network/
        ├── api_client.dart
        ├── api_endpoints.dart
        └── network_info.dart
test/
└── core/
    ├── helper/
    │   └── cache/
    │       └── cache_helper_test.dart
    └── network/
        └── api_client_test.dart
```

**Structure Decision**: Code lives in the `core/` directory as it provides infrastructure for all future data sources.

## Complexity Tracking

*No violations identified.*
