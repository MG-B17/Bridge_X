# Implementation Plan: Extensions, Color Schema & Shared Widgets

**Branch**: `006-extensions-theme-widgets` | **Date**: 2026-04-22 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/006-extensions-theme-widgets/spec.md`

## Summary

Build the foundational UI layer including `BuildContext` extensions for colors and typography, and create reusable components (AppButton, AppTextField, AppLoading, AppErrorWidget, AppAvatar) based strictly on Figma tokens.

## Technical Context

**Language/Version**: Dart 3.x, Flutter
**Primary Dependencies**: `flutter_screenutil`, `cached_network_image`, `google_fonts`
**Storage**: N/A
**Testing**: `flutter test`
**Target Platform**: Android, iOS
**Project Type**: mobile-app
**Performance Goals**: Fast rendering of shared widgets
**Constraints**: Feature files MUST NOT import design constants directly; they must use `context.colors.*` and `context.*TextStyle`.
**Scale/Scope**: Core UI infrastructure

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **Clean Architecture**: All extensions and widgets placed correctly in `lib/core/`.
- [x] **Figma Fidelity**: Components are strictly modeled after Figma design tokens.
- [x] **State Management Contract**: N/A for pure UI components.
- [x] **Context-First Design System Access**: Entirely satisfies this rule by building the `context` extensions.
- [x] **Test-First Quality Gates**: N/A for pure UI components, but robust error handling built in.

## Project Structure

### Documentation (this feature)

```text
specs/006-extensions-theme-widgets/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── theme/
│   │   ├── app_color_scheme.dart
│   │   ├── app_them.dart
│   │   └── text_style.dart
│   ├── constant/
│   │   └── app_spacing.dart
│   ├── utils/
│   │   ├── extensions.dart
│   │   ├── validators.dart
│   │   └── date_formatter.dart
│   └── widgets/
│       ├── bridge_app_button.dart
│       ├── app_text_field.dart
│       ├── app_loading.dart
│       ├── app_error_widget.dart
│       └── app_avatar.dart
```

**Structure Decision**: Standard feature-first with shared `core/` as required by the constitution.
