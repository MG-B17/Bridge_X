# Implementation Plan: Packages Setup (Phase 0)

**Branch**: `001-packages-setup` | **Date**: 2026-04-22 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/001-packages-setup/spec.md`

## Summary

Add all 27 production packages and 3 dev packages defined in the TeamUP implementation
plan to `pubspec.yaml`, verify asset directories exist and are registered, and confirm
the project builds cleanly with `flutter pub get` and `flutter analyze` reporting zero
errors. This phase gates all 28 subsequent implementation phases.

## Technical Context

**Language/Version**: Dart 3.x (bundled with Flutter SDK ^3.9.2)
**Primary Dependencies**: `pubspec.yaml` (Flutter package manager — pub.dev)
**Storage**: N/A — no runtime storage in this phase
**Testing**: No automated tests in this phase (configuration-only); verification via
`flutter pub get` + `flutter analyze` CLI commands
**Target Platform**: Flutter cross-platform (Android, iOS, Web, Desktop)
**Project Type**: Mobile app (Flutter)
**Performance Goals**: `flutter pub get` completes in < 60 seconds on standard hardware
**Constraints**: All packages must resolve to a single compatible version set; no breaking
changes to existing `pubspec.yaml` structure
**Scale/Scope**: 27 production packages + 3 dev packages; 2 asset directories

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Gate | Status |
|---|---|---|
| **I. Clean Architecture** | Phase 0 declares packages enabling Clean Architecture (`dartz`, `get_it`, `flutter_bloc`, `go_router`). No architectural code is written here — no violation possible. | ✅ PASS |
| **II. Figma Fidelity** | Declares `flutter_screenutil`, `google_fonts`, `flutter_svg`, `cached_network_image`, `lottie`, `shimmer` — all required for pixel-accurate Figma implementation. No UI is built here. | ✅ PASS |
| **III. State Management** | Declares `flutter_bloc ^8.1.6` + `equatable ^2.0.5`. No Bloc code written — no violation possible. | ✅ PASS |
| **IV. Context-First Design** | Declares `google_fonts` for Inter font. No design system code written here. | ✅ PASS |
| **V. Test-First Quality Gates** | Phase 0 introduces zero production logic — test coverage gates do not apply. Dev dependencies (`bloc_test`, `mocktail`) declared here for all future phases. | ✅ PASS |
| **Stack Constraints** | Every locked technology in the constitution has its corresponding package declared in this phase. | ✅ PASS |

No violations. No complexity justification required.

## Project Structure

### Documentation (this feature)

```text
specs/001-packages-setup/
├── plan.md              ← This file
├── research.md          ← Phase 0 output (package compatibility research)
├── data-model.md        ← Phase 1 output (pubspec.yaml structure model)
├── quickstart.md        ← Phase 1 output (verification commands)
└── checklists/
    └── requirements.md  ← Spec quality checklist (already created)
```

### Source Code (repository root)

```text
pubspec.yaml             ← Primary artifact — all package declarations added here
assets/
├── images/              ← Already exists and registered ✅
└── svg/                 ← Already exists and registered ✅
```

**Structure Decision**: Single-file modification (pubspec.yaml) + asset directory
verification. No source code changes in this phase.

## Complexity Tracking

> No constitution violations — this section is intentionally empty.
