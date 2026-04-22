# Research: Core Network Client

**Feature**: 004-core-network-client
**Date**: 2026-04-22

## Decisions & Findings

**Decision**: Use `Dio` interceptors instead of overriding `HttpClient`.
**Rationale**: `dio` provides a robust interceptor model (`InterceptorsWrapper`) that allows for modular injection of headers (Auth) and centralized error mapping (Error) before the data reaches the repository layer. It cleanly supports adding the `pretty_dio_logger` exclusively in debug mode.

**Decision**: Global 401 handling via `CacheHelper` and routing signals.
**Rationale**: When a token expires (401), the interceptor must clear the cache immediately to prevent further authorized requests. Navigation to the login screen will be handled by emitting a state or letting the `GoRouter` redirect guard react to the missing token, ensuring the user is cleanly logged out.

**Decision**: Implement `NetworkInfo` using `internet_connection_checker_plus` and `connectivity_plus`.
**Rationale**: As specified in `pubspec.yaml`, `internet_connection_checker_plus` reliably verifies actual data transfer capabilities (pinging a host), which is superior to merely checking if Wi-Fi or Cellular is active.

*All clarifications have been resolved.*
