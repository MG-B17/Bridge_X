# Research: Core: Error Handling & UseCase Base

**Feature**: 003-error-handling-usecase
**Date**: 2026-04-22

## Decisions & Findings

**Decision**: Map Exception types 1:1 with Failure types.
**Rationale**: In Clean Architecture, the `data` layer throws `Exception`s (which carry raw message context) and the `domain`/`presentation` layers handle `Failure`s. Mapping `ServerException` to `ServerFailure` (and similarly for Cache, Network, etc.) ensures that the specific root cause is preserved when passing the error boundary via the `Either` monad.

**Decision**: Use `dartz` package for `Either` monad.
**Rationale**: `dartz` is the locked architectural decision in the constitution for error handling, enforcing a functional programming paradigm where errors are values, not control flow interruptions.

**Decision**: Use `equatable` for all `Failure` subclasses.
**Rationale**: The constitution strictly requires tests using `bloc_test`. To properly assert state changes like `expect(state, ErrorState(Failure(...)))`, `Failure` subclasses must override `props`. Otherwise, Dart will perform reference equality and tests will fail.

*All clarifications have been resolved.*
