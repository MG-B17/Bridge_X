# Data Model: Core: Error Handling & UseCase Base

**Feature**: 003-error-handling-usecase
**Date**: 2026-04-22

This phase produces foundational configuration and base contracts, rather than standard data entities. The "Data Model" here details the class structures and contracts for the Error and UseCase layers.

## 1. Exception Hierarchy (`core/error/exception.dart`)

**Type**: Standard Dart classes implementing `Exception`.

| Exception Class | Purpose | Parameters |
|---|---|---|
| `ServerException` | Thrown by API errors (e.g., 500, timeouts) | `required String message` |
| `CacheException` | Thrown by local storage errors | `required String message` |
| `NetworkException` | Thrown when offline | `required String message` |
| `UnauthorizedException` | Thrown on 401/403 responses | `required String message` |

## 2. Failure Hierarchy (`core/error/failure.dart`)

**Type**: Classes extending `Equatable` to allow value comparison in Bloc states.

**Base Class**: 
```dart
abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}
```

| Failure Class | Maps From | Parameters |
|---|---|---|
| `ServerFailure` | `ServerException` | `String message` |
| `CacheFailure` | `CacheException` | `String message` |
| `NetworkFailure` | `NetworkException` | `String message` |
| `UnauthorizedFailure`| `UnauthorizedException`| `String message` |
| `UnknownFailure` | Catch-all for unexpected errors | `String message` |

## 3. UseCase Base Contract (`core/usecases/usecase.dart`)

**Type**: Abstract class utilizing `dartz` types.

**Signature**:
```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
```

**Auxiliary Entity**:
```dart
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
```

## 4. Error Strings (`core/error/error_strings.dart`)

**Type**: Abstract class with static constant strings.

| Constant | Description |
|---|---|
| `serverFailureMessage` | Generic server error message. |
| `cacheFailureMessage` | Generic cache error message. |
| `networkFailureMessage` | Offline error message. |
| `unauthorizedMessage` | Session expired message. |
| `unexpectedErrorMessage`| Catch-all error message. |
