# Quickstart: Core Network Client

**Feature**: 004-core-network-client
**Date**: 2026-04-22

## 1. Prerequisites
- `shared_preferences`, `dio`, `pretty_dio_logger`, and `internet_connection_checker_plus` must be installed in `pubspec.yaml` (Phase 0 complete).

## 2. Verification Guide

Once implementation is complete, run the following to verify the network components:

### Step 1: Run Static Analysis
Ensure there are no compile-time errors in the newly created network and cache classes.
```powershell
flutter analyze
```

### Step 2: Verify `CacheHelper`
Run unit tests to ensure tokens can be saved, read, and deleted correctly.
```powershell
flutter test test/core/helper/cache/cache_helper_test.dart
```

### Step 3: Verify `ApiClient` and Interceptors
Run unit tests to verify that `ApiClient` properly sets headers and maps errors.
```powershell
flutter test test/core/network/api_client_test.dart
```

## 3. Deliverable Checklist
- [ ] `lib/core/helper/cache/cache_helper.dart` implemented.
- [ ] `lib/core/network/network_info.dart` implemented.
- [ ] `lib/core/network/api_endpoints.dart` created.
- [ ] `lib/core/network/api_client.dart` created with `AuthInterceptor` and `ErrorInterceptor`.
- [ ] `flutter analyze` passes.
- [ ] Tests for cache and api client pass.
