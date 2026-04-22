# Data Model: Core Network Client

**Feature**: 004-core-network-client
**Date**: 2026-04-22

## 1. ApiClient (`core/network/api_client.dart`)

**Type**: Wrapper class around `Dio`.

**Responsibilities**:
- Holds the singleton `Dio` instance.
- Configures base URL from `ApiEndpoints`.
- Sets 30s timeouts.
- Injects `AuthInterceptor` and `ErrorInterceptor`.

## 2. Interceptors

### AuthInterceptor
**Type**: `Interceptor` (from `dio`).
**Behavior**:
- On Request: Reads token from `CacheHelper`. If non-null, appends `Authorization: Bearer <token>`.
- On Response: If HTTP status is 401, calls `CacheHelper.deleteToken()` and triggers navigation event.

### ErrorInterceptor
**Type**: `Interceptor` (from `dio`).
**Behavior**:
- On Error: Maps `DioException` to domain `Exception`s.
  - `connectionTimeout` / `receiveTimeout` → `NetworkException`
  - `badResponse` (5xx) → `ServerException`
  - `badResponse` (401) → `UnauthorizedException`
  - Other → `ServerException(unexpectedErrorMessage)`

## 3. CacheHelper (`core/helper/cache/cache_helper.dart`)

**Type**: Wrapper around `SharedPreferences`.

**Interface**:
```dart
abstract class CacheHelper {
  Future<bool> saveToken(String token);
  String? getToken();
  Future<bool> deleteToken();
  
  Future<bool> saveUserRole(String role);
  String? getUserRole();
  
  Future<bool> setFirstLaunch(bool isFirst);
  bool isFirstLaunch();
}
```

## 4. NetworkInfo (`core/network/network_info.dart`)

**Type**: Interface and Implementation.

**Interface**:
```dart
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
```

**Implementation**:
Uses `internet_connection_checker_plus` to resolve `isConnected`.

## 5. ApiEndpoints (`core/network/api_endpoints.dart`)

**Type**: Abstract class with static constant strings.

| Constant | Description |
|---|---|
| `baseUrl` | The root URL for the backend API. |
| `login` | Endpoint for user authentication. |
| `register` | Endpoint for user registration. |
