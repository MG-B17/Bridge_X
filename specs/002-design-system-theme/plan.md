# Implementation Plan: Design System & Theme (Phase 1)

**Branch**: `002-design-system-theme` | **Date**: 2026-04-22 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/002-design-system-theme/spec.md`

## Summary

Implement the complete design system for the TeamUP application by filling 6 source files
with exact Figma tokens: colors (light + dark), typography (Inter, 6-level scale),
spacing/radius/shadow constants, app strings, and root widget configuration. This phase
has no UI screens — it produces only the shared infrastructure that every subsequent
phase depends on for pixel-accurate rendering and dark-mode readiness.

## Technical Context

**Language/Version**: Dart 3.x (Flutter `^3.9.2`)
**Primary Dependencies**: `flutter_screenutil ^5.9.3`, `google_fonts ^6.2.1`
**Storage**: N/A — no runtime storage in this phase
**Testing**: Widget-level verification — wrap test widgets in the theme and assert token
resolution. No bloc tests needed (no state management in this phase).
**Target Platform**: Flutter cross-platform (Android, iOS, Web, Desktop — all rendered
via the same theme system)
**Project Type**: Mobile app (Flutter)
**Performance Goals**: Theme initialization must complete before the first frame renders
(synchronous — no async loading)
**Constraints**:
- Design size locked to `390×844` (constitution, immutable)
- All colors from `AppColorScheme` only — no hardcoded hex in feature files
- All sizes via `flutter_screenutil` units — no magic numbers
- Inter font must work offline — local asset fallback required
**Scale/Scope**: 6 source files + local font asset registration

## Constitution Check

*GATE: Must pass before Phase 1 research. Re-checked after design.*

| Principle | Gate | Status |
|---|---|---|
| **I. Clean Architecture** | Design system lives in `core/theme/` and `core/constant/` — no feature layer import. `AppColorScheme extends ThemeExtension` is pure Dart with Flutter only (no data/domain imports). No layer violation possible. | ✅ PASS |
| **II. Figma Fidelity** | This phase IS the Figma fidelity foundation. Tokens extracted directly from the Figma document. All 11 light + 5 dark colors, 6 typography styles, 6 spacing + 3 radius + 1 shadow constants must match Figma exactly — zero deviation policy enforced here. | ✅ PASS |
| **III. State Management** | No Bloc or Cubit in this phase. `ThemeMode.system` is managed by Flutter's built-in MaterialApp — no state management code needed. | ✅ PASS |
| **IV. Context-First Design** | This phase implements the extension mechanism itself (`context.colors.*`, `context.headlineMedium`, etc. via `core/utils/extensions.dart`). After this phase, all downstream code MUST use context extensions — not direct class imports. | ✅ PASS |
| **V. Test-First Quality Gates** | No `UseCases`, `Cubits`, or `RepositoryImpls` in this phase — coverage gates do not apply. Widget-level verification of token resolution is sufficient and will be done in `quickstart.md` verification steps. | ✅ PASS |
| **Stack Constraints** | `flutter_screenutil ^5.9.3` and `google_fonts ^6.2.1` used here — both locked in constitution and already installed (Phase 0). No new packages introduced. | ✅ PASS |

No violations. No complexity justification required.

## Project Structure

### Source Files Modified / Created

```text
lib/
├── app.dart                              ← MODIFY: wrap in ScreenUtilInit + apply themes
│
└── core/
    ├── theme/
    │   ├── app_color_scheme.dart         ← CREATE: ThemeExtension<AppColorScheme> light + dark
    │   ├── text_style.dart               ← MODIFY: fill Inter hierarchy with .sp sizes
    │   └── app_them.dart                 ← MODIFY: wire ThemeData + extensions + ThemeMode.system
    └── constant/
        ├── app_spacing.dart              ← CREATE: spacing, radius, shadow constants
        └── app_strings.dart             ← MODIFY: fill all string literals
```

### Asset Registration (Inter Font Fallback)

```text
assets/
└── fonts/
    └── Inter-Regular.ttf               ← ADD: local font file for offline fallback
    └── Inter-SemiBold.ttf              ← ADD
    └── Inter-Bold.ttf                  ← ADD
pubspec.yaml                            ← MODIFY: register fonts/ asset dir
```

### Documentation (this feature)

```text
specs/002-design-system-theme/
├── plan.md              ← This file
├── research.md          ← Phase 0 output (font strategy + ThemeExtension pattern)
├── data-model.md        ← Phase 1 output (token catalog + file structure)
├── quickstart.md        ← Phase 1 output (verification steps)
└── checklists/
    └── requirements.md  ← Already created ✅
```

## Complexity Tracking

> No constitution violations — this section is intentionally empty.
