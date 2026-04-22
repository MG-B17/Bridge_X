# Quickstart: Core: Error Handling & UseCase Base

**Feature**: 003-error-handling-usecase
**Date**: 2026-04-22

## 1. Prerequisites
- Phase 0 (Packages Setup) complete. `dartz` and `equatable` must be present in `pubspec.yaml`.

## 2. Verification Guide

Once implementation is complete, run the following to verify the base contracts:

### Step 1: Run Static Analysis
Ensure there are no compile-time errors in the newly created base classes.
```powershell
flutter analyze
```

### Step 2: Verify `Failure` Equatable Equality
Manually run a snippet or test to verify `Failure` equality checking:
```dart
final failure1 = ServerFailure(message: 'Internal Error');
final failure2 = ServerFailure(message: 'Internal Error');
assert(failure1 == failure2); // Should pass
```

### Step 3: Verify `Either` Return Mapping
Ensure that standard `Left` and `Right` mappings compile when returned from a mock `UseCase`:
```dart
class MockUseCase extends UseCase<String, NoParams> {
  @override
  Future<Either<Failure, String>> call({required NoParams params}) async {
    return Right('Success');
  }
}
```

## 3. Deliverable Checklist
- [ ] `lib/core/error/exception.dart` created with 4 exception types.
- [ ] `lib/core/error/failure.dart` created with `Failure` base and 5 subclasses.
- [ ] `lib/core/error/error_strings.dart` created with standard messages.
- [ ] `lib/core/usecases/usecase.dart` created with `UseCase` and `NoParams`.
- [ ] `flutter analyze` passes.
