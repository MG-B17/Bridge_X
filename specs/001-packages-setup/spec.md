# Feature Specification: Packages Setup

**Feature Branch**: `001-packages-setup`
**Created**: 2026-04-22
**Status**: Draft
**Input**: Phase 0 from `implementation_plan.md` — Add all packages to `pubspec.yaml`, verify the project builds.

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Developer Adds All Dependencies and Verifies the Build (Priority: P1)

As a developer starting implementation on TeamUP, I need all required packages declared
in `pubspec.yaml` so that every subsequent phase can import them immediately without
revisiting dependency setup.

**Why this priority**: All 29 implementation phases depend on this foundation. A missing or
conflicting package discovered later causes cascading delays across multiple features.

**Independent Test**: After completing this story, a fresh `flutter pub get` completes with
zero errors and zero conflicts. The project runs on a connected device or emulator without
crashing at startup.

**Acceptance Scenarios**:

1. **Given** a clean Flutter project with an empty `pubspec.yaml` dependencies section,
   **When** all production and dev packages from the implementation plan are added and
   `flutter pub get` is run,
   **Then** the command completes with zero errors, the `.dart_tool/` lockfile is updated,
   and `flutter analyze` reports zero issues on `main.dart`.

2. **Given** all packages are declared,
   **When** there is a version conflict between two packages,
   **Then** the conflict is identified via `flutter pub deps`, resolved by pinning the
   affected package to a compatible version, and `flutter pub get` succeeds.

3. **Given** all packages are installed,
   **When** the `assets/images/` or `assets/svg/` folder is missing from the filesystem,
   **Then** the folders are created and registered in `pubspec.yaml` under the `flutter:
   assets:` section so the app builds without asset-not-found errors.

4. **Given** a version constraint mismatch between the declared Dart SDK and the
   installed Flutter SDK,
   **When** `flutter pub get` is run,
   **Then** the `environment.sdk` field in `pubspec.yaml` is updated to the correct
   range and the command succeeds.

---

### Edge Cases

- What happens when two packages declare incompatible versions of a shared transitive dependency?
  → Run `flutter pub deps` to inspect the full dependency tree; pin the lowest common compatible version.
- What happens when the installed Flutter SDK version is older than the `sdk:` constraint in `pubspec.yaml`?
  → Update the SDK range to match the installed version, or upgrade Flutter SDK.
- What happens when an asset directory listed in `pubspec.yaml` does not exist?
  → The app fails to build with an asset-not-found error; the directory must be created before running `flutter pub get`.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The project MUST declare all production dependencies listed in the
  implementation plan (27 packages including `flutter_bloc`, `go_router`, `get_it`,
  `dio`, `dartz`, `flutter_screenutil`, `sqflite`, `shared_preferences`, `web_socket_channel`,
  `equatable`, `cached_network_image`, `flutter_svg`, `shimmer`, `lottie`, `fl_chart`,
  `google_fonts`, `image_picker`, `file_picker`, `path_provider`, `path`, `intl`,
  `connectivity_plus`, `internet_connection_checker_plus`, `rxdart`, `pretty_dio_logger`).
- **FR-002**: The project MUST declare all dev dependencies (`bloc_test`, `mocktail`,
  `flutter_lints`) with the exact version constraints specified in the implementation plan.
- **FR-003**: The `pubspec.yaml` MUST register the `assets/images/` and `assets/svg/`
  directories under the `flutter: assets:` section.
- **FR-004**: The `assets/images/` and `assets/svg/` directories MUST exist on the
  filesystem at the project root.
- **FR-005**: `flutter pub get` MUST complete with zero errors and zero dependency
  conflicts after all packages are declared.
- **FR-006**: `flutter analyze` MUST report zero errors on the existing source files
  after packages are installed (warnings from generated code are acceptable).
- **FR-007**: The `environment.sdk` constraint in `pubspec.yaml` MUST be compatible
  with the installed Flutter SDK version on the development machine.

### Key Entities

- **`pubspec.yaml`**: The single source of truth for all project dependencies, asset
  registrations, and SDK constraints. Any modification here affects the entire build.
- **Asset directories (`assets/images/`, `assets/svg/`)**: Physical folders whose
  existence is required by the asset registration in `pubspec.yaml`.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `flutter pub get` completes successfully in under 60 seconds on a standard
  development machine with an internet connection — zero errors, zero conflicts.
- **SC-002**: All 27 production packages and 3 dev packages are resolvable to a single
  compatible version set — no version conflict messages in the output.
- **SC-003**: `flutter analyze` reports zero errors across all existing Dart files
  immediately after package installation.
- **SC-004**: The project launches on a connected device or emulator without a startup
  crash caused by a missing package or unregistered asset.
- **SC-005**: A developer on a fresh machine can clone the repo, run `flutter pub get`,
  and proceed to Phase 1 implementation without any manual dependency resolution steps.

## Assumptions

- The development machine has Flutter SDK ≥ 3.x installed and `flutter` is on the system `PATH`.
- An internet connection is available during setup to download packages from `pub.dev`.
- The exact package versions specified in the implementation plan (`flutter_bloc ^8.1.6`,
  `go_router ^14.2.0`, etc.) are compatible with each other — if not, the nearest
  compatible pinned version is acceptable.
- Asset images and SVG files themselves are not required to exist in this phase —
  only the directories need to be created and registered.
- No platform-specific native plugin setup (Android Gradle, iOS Podfile) is in scope for
  this phase; those are resolved automatically by `flutter pub get` for standard plugins.
