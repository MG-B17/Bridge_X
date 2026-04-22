---

description: "Task list template for feature implementation"
---

# Tasks: Packages Setup (Phase 0)

**Input**: Design documents from `specs/001-packages-setup/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, quickstart.md ✅

**Tests**: No test tasks — Phase 0 introduces zero production logic. Verification is done
via CLI commands (`flutter pub get`, `flutter analyze`, `flutter build`).

**Organization**: Tasks are grouped by phase. All implementation tasks belong to US1
(the single user story). Package addition tasks are sequential (same file). Verification
tasks are sequential (each depends on prior success).

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1)
- Exact file paths included in all descriptions

---

## Phase 1: Setup (Baseline Verification)

**Purpose**: Confirm the starting state so no work is duplicated and no already-present
items are accidentally removed or overwritten.

- [x] T001 Open `pubspec.yaml` and confirm the following are already present and correct:
  `assets/images/` and `assets/svg/` under `flutter: assets:`, `flutter_lints: ^5.0.0`
  under `dev_dependencies:`, `sdk: ^3.9.2` under `environment:`, and `cupertino_icons:
  ^1.0.8` under `dependencies:`. Document any discrepancies before proceeding.

**Checkpoint**: Baseline state confirmed — proceed knowing exactly what already exists.

---

## Phase 2: Foundational (Pre-conditions Check)

**Purpose**: Verify the physical asset directories exist on disk before adding package
declarations that depend on them. This blocks nothing from Phase 3 for packages, but
must be complete before the final build smoke test.

- [x] T002 Verify `assets/images/` directory exists at project root. If missing, create
  it with `New-Item -ItemType Directory -Path assets\images` (PowerShell) or
  `mkdir -p assets/images` (bash).

- [x] T003 Verify `assets/svg/` directory exists at project root. If missing, create
  it with `New-Item -ItemType Directory -Path assets\svg` (PowerShell) or
  `mkdir -p assets/svg` (bash).

**Checkpoint**: Asset directories confirmed present — all pre-conditions met for US1.

---

## Phase 3: User Story 1 — Declare All Dependencies and Verify Build (Priority: P1) 🎯 MVP

**Goal**: Add all 25 new production packages and 2 new dev packages to `pubspec.yaml`,
resolve any conflicts, and confirm the project builds cleanly.

**Independent Test**: `flutter pub get` exits with code 0 and `flutter analyze` reports
`No issues found!` — the project is ready for Phase 1 (Design System & Theme).

### Implementation for User Story 1

- [x] T004 [US1] In `pubspec.yaml` under `dependencies:`, add the **State Management &
  DI** packages on new lines after `cupertino_icons`:
  ```yaml
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  get_it: ^8.0.2
  dartz: ^0.10.1
  ```

- [x] T005 [US1] In `pubspec.yaml` under `dependencies:`, add the **Navigation &
  Network** packages:
  ```yaml
  go_router: ^14.2.0
  dio: ^5.6.0
  pretty_dio_logger: ^1.4.0
  web_socket_channel: ^3.0.1
  ```

- [x] T006 [US1] In `pubspec.yaml` under `dependencies:`, add the **Responsive UI &
  Design** packages:
  ```yaml
  flutter_screenutil: ^5.9.3
  cached_network_image: ^3.4.1
  flutter_svg: ^2.0.10+1
  shimmer: ^3.0.0
  lottie: ^3.1.2
  fl_chart: ^0.69.0
  google_fonts: ^6.2.1
  ```

- [x] T007 [US1] In `pubspec.yaml` under `dependencies:`, add the **Local Storage**
  packages:
  ```yaml
  shared_preferences: ^2.3.2
  sqflite: ^2.3.3+1
  path: ^1.9.0
  ```

- [x] T008 [US1] In `pubspec.yaml` under `dependencies:`, add the **Media & File**
  packages:
  ```yaml
  image_picker: ^1.1.2
  file_picker: ^8.1.2
  path_provider: ^2.1.4
  ```

- [x] T009 [US1] In `pubspec.yaml` under `dependencies:`, add the **Utility** packages:
  ```yaml
  intl: ^0.19.0
  connectivity_plus: ^6.0.5
  internet_connection_checker_plus: ^2.5.1
  rxdart: ^0.28.0
  ```

- [x] T010 [US1] In `pubspec.yaml` under `dev_dependencies:`, add the **Testing**
  packages (below the existing `flutter_lints` entry):
  ```yaml
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
  ```

- [x] T011 [US1] Save `pubspec.yaml` and run `flutter pub get` from the project root.
  Confirm exit code 0 and zero error lines in output. If conflicts appear, run
  `flutter pub deps` to inspect the dependency tree and pin the conflicting package
  to the nearest compatible version, then re-run `flutter pub get`.

- [x] T012 [US1] Run `flutter analyze` from the project root. Confirm the output
  contains `No issues found!` (or only hints/infos — zero errors and zero warnings).
  If errors appear, fix them before proceeding; they indicate a package that introduced
  an incompatible API with existing code.

**Checkpoint**: All 25 production packages and 2 dev packages declared. `flutter pub get`
and `flutter analyze` both pass. Phase 0 deliverable met — Phase 1 can begin.

---

## Phase 4: Polish & Verification

**Purpose**: Final smoke test confirming the app boots without a crash from a missing
package or unregistered asset.

- [x] T013 Run a build smoke test to confirm the app compiles end-to-end:
  ```powershell
  # Option A — no device needed:
  flutter build apk --debug --no-tree-shake-icons
  # Option B — with connected device:
  flutter run --debug
  ```
  Confirm no startup crash. The default Flutter counter screen is the expected UI at
  this stage.

- [x] T014 [P] Review the final `pubspec.yaml` to confirm: (a) no package appears in
  both `dependencies:` and `dev_dependencies:`, (b) no duplicate entries exist,
  (c) asset sections are intact (`assets/images/` and `assets/svg/`), and (d) the
  `sdk: ^3.9.2` constraint is unchanged.

- [x] T015 [P] Verify `pubspec.lock` was updated by `flutter pub get` and commit both
  `pubspec.yaml` and `pubspec.lock` to version control so all team members get
  identical dependency resolution.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **Foundational (Phase 2)**: No dependency on Phase 1, but run first for safety
- **User Story (Phase 3)**: Can begin after Phase 1 confirms the baseline; T004–T010
  are all writes to the same file and MUST run sequentially; T011–T012 depend on
  T004–T010 completion
- **Polish (Phase 4)**: Depends on all Phase 3 tasks completing successfully

### Within User Story 1

```
T004 → T005 → T006 → T007 → T008 → T009 → T010
                                              ↓
                                            T011 (flutter pub get)
                                              ↓
                                            T012 (flutter analyze)
```

T013, T014, T015 can start after T012 passes. T014 and T015 are [P] — independent files.

### Parallel Opportunities

- T002 and T003 (Phase 2) can run in parallel — different directories
- T013, T014, T015 (Phase 4) can run in parallel after T012 passes

---

## Parallel Example: User Story 1

```powershell
# Phase 2 — run in parallel (different directories):
# Terminal A:
Test-Path assets\images   # Verify / create if missing

# Terminal B:
Test-Path assets\svg      # Verify / create if missing

# Phase 3 — sequential (same file):
# Edit pubspec.yaml adding T004 through T010 groups in order, then:
flutter pub get           # T011
flutter analyze           # T012

# Phase 4 — parallel after T012:
# Terminal A: flutter build apk --debug       (T013)
# Terminal B: Manual review of pubspec.yaml  (T014)
# Terminal C: git add pubspec.yaml pubspec.lock && git commit  (T015)
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Baseline verification (T001)
2. Complete Phase 2: Asset directory check (T002–T003)
3. Complete Phase 3: Add all packages + verify (T004–T012)
4. **STOP and VALIDATE**: `flutter pub get` ✅ + `flutter analyze` ✅
5. Proceed to Phase 4 smoke test

### Key Rule

Do NOT start Phase 1 (Design System & Theme) implementation until T012 (`flutter analyze`)
passes with zero errors. A broken dependency graph will cascade into every subsequent phase.

---

## Notes

- [P] tasks = different files or independent commands, no shared state dependencies
- [US1] label maps every task to the single user story for traceability
- T004–T010 are intentionally sequential — all write to the same `pubspec.yaml` file
- If `flutter pub get` fails at T011, fix conflicts before touching any other file
- Avoid: running `flutter pub get` before all package groups (T004–T010) are complete —
  partial resolution may cache an incompatible lockfile
- Commit `pubspec.lock` alongside `pubspec.yaml` (T015) — never gitignore it for app projects
