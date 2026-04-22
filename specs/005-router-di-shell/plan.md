# Implementation Plan: Core Router & DI Shell

**Branch**: `005-router-di-shell` | **Date**: 2026-04-22 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/005-router-di-shell/spec.md`

## Summary

Initialize the `go_router` navigation shell with route guarding and placeholders, and register all core singleton dependencies in `get_it`.

## Technical Context

**Language/Version**: Dart 3.x, Flutter
**Primary Dependencies**: `go_router`, `get_it`, `shared_preferences`, `dio`
**Storage**: `shared_preferences`
**Testing**: `flutter test`
**Target Platform**: Android, iOS
**Project Type**: mobile-app
**Performance Goals**: N/A
**Constraints**: Router must redirect 100% of unauthorized access. DI must initialize before first frame.
**Scale/Scope**: Core application entry and navigation.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **Clean Architecture**: Core setup only; no cross-layer violations.
- [x] **Figma Fidelity**: N/A.
- [x] **State Management Contract**: N/A.
- [x] **Context-First Design System Access**: N/A.
- [x] **Test-First Quality Gates**: Network config testing.

## Project Structure

### Documentation (this feature)

```text
specs/005-router-di-shell/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── main.dart
├── core/
│   ├── di/
│   │   └── di.dart
│   ├── navigation/
│   │   ├── app_route.dart
│   │   └── app_route_constant.dart
```

**Structure Decision**: Uses the designated shared `core/` folder structure required by the constitution.
