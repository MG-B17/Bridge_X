<!--
SYNC IMPACT REPORT
==================
Version change: [TEMPLATE] → 1.0.0
Added sections:
  - I. Clean Architecture (NON-NEGOTIABLE)
  - II. Figma Fidelity (NON-NEGOTIABLE)
  - III. State Management Contract
  - IV. Context-First Design System Access
  - V. Test-First Quality Gates
  - Technology Stack Constraints
  - Development Workflow
  - Governance
Templates requiring updates:
  - .specify/templates/plan-template.md      ✅ principles referenced — no structural change needed
  - .specify/templates/spec-template.md      ✅ Figma fidelity + architecture constraints aligned
  - .specify/templates/tasks-template.md     ✅ task types (domain/data/presentation) match layer rules
  - .specify/templates/commands/*.md         ✅ no agent-specific (CLAUDE-only) language found
Deferred TODOs:
  - RATIFICATION_DATE: set to today (2026-04-22) as initial adoption date
-->

# TeamUP Constitution

## Core Principles

### I. Clean Architecture (NON-NEGOTIABLE)

Every feature MUST be structured in exactly three layers: `data → domain → presentation`.
No layer may import from a layer above it — ever.

- **Entities**: Pure Dart only. No Flutter imports, no JSON annotations, no `fromJson`.
- **Models**: Extend their entity and add `fromJson` / `toJson`. Live in `data/`.
- **Repository interfaces**: Declared in `domain/` as abstract classes only.
- **Repository implementations**: Live in `data/` and implement the domain interface.
- **Use Cases**: One public action per class, always returning `Either<Failure, T>` via `dartz`.
  No use case may contain more than one responsibility.
- **Blocs / Cubits**: Live in `presentation/` only. No `data/` or `domain/` imports are
  permitted inside page files.
- **`get_it`**: The ONLY place the `new` keyword is used for injecting dependencies.
  All feature registrations live in `core/di/di.dart`.
- **`go_router`**: The ONLY navigation mechanism. `Navigator.push()` is strictly forbidden
  anywhere in the codebase.

Rationale: Enforcing strict layer separation makes every layer independently testable,
replaceable, and free of unintended coupling. Violations cause cascading regressions that
are expensive to untangle later.

### II. Figma Fidelity (NON-NEGOTIABLE)

Every UI screen and widget MUST match the Figma design exactly — pixel-level accuracy is
the standard.

- No UI element may be invented or approximated if a Figma spec exists.
- Colors MUST come from the `AppColorScheme` design tokens (not hardcoded hex values).
- Typography MUST come from the Inter font hierarchy defined in `AppTextStyles`
  (24sp / 20sp / 18sp / 16sp / 14sp / 12sp scale).
- All sizes MUST use `flutter_screenutil` units (`.w`, `.h`, `.sp`, `.r`) with the
  Figma design frame of `390×844`.
- No magic numbers: every constant MUST be named in `app_spacing.dart` or the color scheme.

Rationale: Design consistency across 29 phases requires a single source of truth.
Deviating from Figma introduces visual debt that accumulates faster than it is repaid.

### III. State Management Contract

Blocs and Cubits MUST follow a strict, predictable contract:

- Every state class MUST be `sealed` and extend `Equatable`.
- States: named as `[Feature]Initial`, `[Feature]Loading`, `[Feature]Success/Loaded`,
  `[Feature]Failure` — with `required named` parameters on failure states.
- Auth uses 5 independent Cubits (`LoginCubit`, `RegisterCubit`, `OtpCubit`,
  `ForgotPasswordCubit`, `ProfileSetupCubit`). A shared `AuthBloc` is forbidden.
- `buildWhen` MUST be used when a Bloc emits multiple states and only some require
  a UI rebuild.
- `context.read<Bloc>().add(...)` for event dispatch — never called inside `build()`.
- Every Cubit and Bloc MUST be closed in `tearDown` during tests.

Rationale: Predictable state shapes eliminate debugging ambiguity. Independent auth Cubits
prevent shared-state bugs between unrelated auth screens.

### IV. Context-First Design System Access

All design values MUST be accessed through `BuildContext` extensions. Direct imports of
`AppColorScheme` or `AppTextStyles` in feature files are strictly forbidden.

- Colors: `context.colors.primary` (via `ThemeExtension<AppColorScheme>`)
- Text styles: `context.headlineMedium`, `context.bodyMedium`, etc.
- Shared widgets: `AppButton`, `AppTextField`, `AppAvatar`, `AppLoading`, `AppErrorWidget`
  — use these everywhere; never re-implement common UI patterns inline.
- `BuildContext` extensions live exclusively in `core/utils/extensions.dart`.

Rationale: Centralizing design system access means a single edit propagates across every
feature. It also enforces dark-mode readiness — colors always resolve through the theme.

### V. Test-First Quality Gates

Tests are not optional. Minimum coverage targets are enforced before any phase is
considered "done":

| Layer | Minimum Coverage |
|---|---|
| `domain/usecases/` | **100%** — success + failure paths for every use case |
| `presentation/cubit/` | **90%** — every state transition verified |
| `data/repositories/` | **80%** — online/offline/exception paths |
| `core/utils/` | **80%** — validators, pagination, date formatter |
| `core/network/` | **70%** — error interceptor mapping |

- Use `bloc_test` + `mocktail` exclusively. No code generation for mocks.
- Every `UseCase` test MUST verify: success path, `ServerFailure`, and `NetworkFailure`.
- Every `RepositoryImpl` test MUST cover: online success, offline guard, and exception mapping.
- `flutter test --coverage` MUST run clean at ≥ 85% overall before a phase is merged.

Rationale: Tests written after the fact are rarely complete. Coverage gates prevent the
accumulation of untested edge cases that surface as production bugs.

## Technology Stack Constraints

The following technology choices are locked and MUST NOT be changed without a constitution
amendment:

| Concern | Locked Decision |
|---|---|
| Architecture | Clean Architecture — `data → domain → presentation` |
| State Management | Bloc / Cubit (`flutter_bloc ^8.1.6`) |
| File Structure | Feature-First + shared `core/` |
| Navigation | `go_router ^14.2.0` — `Navigator.push()` forbidden |
| Dependency Injection | `get_it ^8.0.2` — only DI mechanism |
| HTTP Client | `dio ^5.6.0` with auth + error interceptors |
| Real-time | `web_socket_channel ^3.0.1` — chat only |
| Responsive UI | `flutter_screenutil ^5.9.3` — every size |
| Local Storage (structured) | `sqflite ^2.3.3+1` — cache with TTL |
| Local Storage (lightweight) | `shared_preferences ^2.3.2` — token + flags only |
| Error Handling | `dartz ^0.10.1` — `Either<Failure, T>` everywhere |
| Font | Inter (via `google_fonts ^6.2.1` + local asset fallback) |
| Testing | `bloc_test ^9.1.7` + `mocktail ^1.0.4` |

Adding a new package requires documenting the rationale in the feature's `spec.md` and
confirming no existing package already covers the need.

## Development Workflow

### Phase Completion Criteria

A phase is only complete when ALL of the following are true:
1. All tasks in `tasks.md` for the phase are checked off.
2. Code compiles with zero errors and zero analyzer warnings (`flutter analyze`).
3. Coverage gates in Principle V are met for all new code introduced.
4. UI screens (where required) have been manually verified against the Figma frame.
5. All edge cases documented in `implementation_plan.md` for the phase are handled.

### Error Handling Convention

Every repository implementation MUST follow this pattern:
```
if (!networkInfo.isConnected) return Left(NetworkFailure());
try {
  final result = await remoteDataSource.call(...);
  return Right(result);
} on UnauthorizedException catch (e) {
  return Left(UnauthorizedFailure(message: e.message));
} on ServerException catch (e) {
  return Left(ServerFailure(message: e.message));
} on CacheException catch (e) {
  return Left(CacheFailure(message: e.message));
} catch (e) {
  return Left(UnknownFailure(message: e.toString()));
}
```

### Navigation Guard Rules

Protected routes enforce guards in `GoRouter.redirect`:
- No token → `/login`
- Role mismatch → role-appropriate home
- Expired token (401) → cleared via `AuthInterceptor` → `/login`
- Unknown path → branded 404 screen via `GoRouter.errorBuilder`

### Pagination Standard

All list screens MUST use `AppPaginatedList` from `core/widgets/`. Two events are
mandatory for every paginated Bloc: `LoadFirstPage` and `LoadNextPage`. The `isLoadingMore`
guard MUST prevent duplicate in-flight requests.

## Governance

- This constitution supersedes all other practices, conventions, and preferences documented
  elsewhere. In case of conflict, the constitution wins.
- **Amendment procedure**: Any change to the constitution requires (1) updating this file
  with a new version, (2) propagating changes to affected templates and command files,
  and (3) documenting the change in the Sync Impact Report comment at the top of this file.
- **Versioning policy** (semantic):
  - MAJOR: removal or redefinition of a non-negotiable principle.
  - MINOR: new principle or section added.
  - PATCH: clarification, wording fix, or non-semantic refinement.
- **Compliance review**: Every feature spec and plan MUST reference and confirm compliance
  with all five Core Principles before implementation begins.
- **Runtime guidance**: See `implementation_plan.md` at the project root for the phase-by-phase
  development roadmap and per-phase edge case handling.

**Version**: 1.0.0 | **Ratified**: 2026-04-22 | **Last Amended**: 2026-04-22
