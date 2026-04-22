# Research: Packages Setup

**Feature**: 001-packages-setup
**Date**: 2026-04-22
**Status**: Complete — all unknowns resolved

## Pre-Research Findings from Project Inspection

Before researching compatibility, the current project state was inspected:

| Item | Finding |
|---|---|
| `pubspec.yaml` SDK constraint | `^3.9.2` — very recent Dart SDK, no downgrade conflicts expected |
| Asset directories | `assets/images/` and `assets/svg/` already exist ✅ |
| Asset registration | Both paths already declared in `pubspec.yaml` flutter assets section ✅ |
| `flutter_lints ^5.0.0` | Already declared in dev_dependencies ✅ |
| Existing deps | Only `cupertino_icons ^1.0.8` — no conflict risk with new packages |

## Decision 1: Package Version Strategy

**Decision**: Use the version constraints specified exactly in `implementation_plan.md`
(caret `^` ranges). Do not pin to exact versions unless a conflict is detected after
running `flutter pub get`.

**Rationale**: Caret ranges (`^x.y.z`) allow patch and minor updates within the same
major version, keeping the project secure without breaking API compatibility. Pinning
to exact versions prematurely creates maintenance overhead for no benefit.

**Alternatives considered**:
- Exact pinning (`x.y.z`): Rejected — too rigid, blocks security patches automatically.
- Wide ranges (`>=x.y.z`): Rejected — risks pulling in breaking major versions.

## Decision 2: `flutter_lints` — Already Present

**Decision**: Keep `flutter_lints ^5.0.0` as-is. It is already in `dev_dependencies`
and matches the version specified in the plan exactly.

**Rationale**: No change needed; removing and re-adding would be redundant.

## Decision 3: `cupertino_icons` — Retain

**Decision**: Retain `cupertino_icons ^1.0.8`. It is a Flutter standard dependency
and does not conflict with any package in the plan.

**Rationale**: Some Cupertino-style widgets may be used for iOS platform conventions.
Removing it would require a separate decision and is out of scope.

## Decision 4: `pretty_dio_logger` Scope

**Decision**: Declare `pretty_dio_logger ^1.4.0` under `dependencies` (not `dev_dependencies`).

**Rationale**: The implementation plan specifies it is enabled only in debug mode via
`kDebugMode` guard in `api_client.dart`. Flutter's tree-shaking removes unused code in
release builds — it does not need to be a dev dependency for this to work correctly.

**Alternatives considered**:
- Moving to `dev_dependencies`: Would require conditional imports, which adds complexity.
  The runtime guard approach is simpler and idiomatic for Flutter.

## Decision 5: `rxdart` Placement

**Decision**: Declare `rxdart ^0.28.0` under `dependencies`.

**Rationale**: Used at runtime in `ChatWebSocketDataSource` for WebSocket stream
transformations (Phase 22). It is a runtime dependency, not a build-time one.

## Compatibility Risk Assessment

| Risk | Likelihood | Mitigation |
|---|---|---|
| `dio` vs `web_socket_channel` conflict | Low | Both are standalone; no shared transitive deps |
| `sqflite` vs `path` conflict | None | `path` is a direct dep of `sqflite` — same version required |
| `connectivity_plus` vs `internet_connection_checker_plus` conflict | Low | Independent packages; no shared core |
| `flutter_screenutil` vs `flutter_bloc` conflict | None | No shared dependencies |
| `fl_chart` vs `lottie` conflict | None | Unrelated rendering packages |
| `image_picker` vs `file_picker` conflict | Low | Both use `path_provider` — pin if conflict detected |

**Overall risk**: Low. All packages are popular, well-maintained pub.dev packages with
no known cross-compatibility issues at the specified versions.

## Asset Directory Status

| Directory | Exists | Registered in pubspec.yaml |
|---|---|---|
| `assets/images/` | ✅ Yes | ✅ Yes |
| `assets/svg/` | ✅ Yes | ✅ Yes |

No action required for asset directories — both conditions are already met.

## SDK Constraint Validation

- Declared: `sdk: ^3.9.2`
- Required by plan: Flutter SDK ≥ 3.x
- Status: ✅ Compatible — `^3.9.2` accepts `3.9.2` through `<4.0.0`

No SDK constraint change needed.
