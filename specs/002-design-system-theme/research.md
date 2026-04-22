# Research: Design System & Theme

**Feature**: 002-design-system-theme
**Date**: 2026-04-22
**Status**: Complete — all unknowns resolved

## Decision 1: ThemeExtension Pattern for Color System

**Decision**: Implement `AppColorScheme extends ThemeExtension<AppColorScheme>` with
`copyWith` and `lerp` methods. Register as `extensions: [AppColorScheme.light]` on
`ThemeData` and `extensions: [AppColorScheme.dark]` on the dark `ThemeData`. Access
via `Theme.of(context).extension<AppColorScheme>()!`.

**Rationale**: `ThemeExtension` is the Flutter-native way to extend `ThemeData` with
custom color sets. It provides built-in `lerp` support for smooth animated theme
transitions and is the only approach that keeps colors inside the theme system (enabling
`ThemeMode.system` to work automatically). It also prevents direct class imports in
feature files since the extension is only accessible via `BuildContext`.

**Alternatives considered**:
- **Singleton class with static constants**: Rejected — prevents dark mode auto-switch,
  requires manual conditional checks in every widget.
- **`ColorScheme` extension only**: Rejected — `ColorScheme` maps to specific Material
  roles; custom tokens like `ongoingBg` don't map cleanly to Material roles.
- **Provider for theme**: Rejected — overkill; Flutter's `MaterialApp.themeMode` handles
  system switching natively without state management.

---

## Decision 2: BuildContext Extensions for Token Access

**Decision**: Implement `extension AppColorSchemeExtension on BuildContext` and
`extension AppTextStyleExtension on BuildContext` in `core/utils/extensions.dart`.
This gives `context.colors.primary`, `context.headlineMedium`, etc. throughout the app.

**Rationale**: Constitution Principle IV mandates context-first design access. Extensions
on `BuildContext` are the idiomatic Dart way to achieve this. They eliminate the need to
import `AppColorScheme` or `AppTextStyles` directly in feature files — the context
extension is the only import needed (and it lives in `core/utils/extensions.dart`).

**Alternatives considered**:
- **Direct `Theme.of(context).extension<AppColorScheme>()!` at call sites**: Rejected —
  verbose, error-prone (forgetting `!` causes runtime crash), and leaks knowledge of
  the extension type into every feature file.
- **Inherited widget**: Rejected — Flutter's ThemeExtension achieves the same result
  with less boilerplate.

---

## Decision 3: Inter Font — Local Asset vs. google_fonts Package

**Decision**: Use `google_fonts` package as the primary font loader with **local Inter
font files** registered in `pubspec.yaml` as the mandatory offline fallback.

**Rationale**: The spec (FR-007) and constitution both require offline-first font
rendering. `google_fonts` caches fonts after the first download, but on first launch
with no network, it falls back to the system font — which would break Figma fidelity.
Local font assets guarantee pixel-accurate typography on launch 1 even without internet.
The `google_fonts` package supports specifying a `textStyle` with `GoogleFonts.inter()`
which respects the local asset if declared in `pubspec.yaml` fonts section.

**Implementation approach**:
1. Download Inter font files (Regular, SemiBold, Bold) and place in `assets/fonts/`
2. Register in `pubspec.yaml` under `flutter: fonts:` section
3. In `text_style.dart`, use `GoogleFonts.inter(textStyle: TextStyle(...))` — the
   package checks for a locally bundled asset before attempting a network download

**Alternatives considered**:
- **Network-only `google_fonts`**: Rejected — fails FR-007, breaks offline first launch.
- **Only local assets, no `google_fonts`**: Viable but adds maintenance overhead for
  future font variants. Hybrid approach is cleaner.

---

## Decision 4: ScreenUtilInit Placement

**Decision**: Wrap `MaterialApp.router` inside `ScreenUtilInit` in `app.dart`. The
`designSize` is set to `const Size(390, 844)` — immutable per constitution.

**Rationale**: `ScreenUtilInit` must be the ancestor of any widget that uses `.w`, `.h`,
or `.sp`. Placing it at the root in `app.dart` (wrapping `MaterialApp.router`) ensures
all descendant widgets can safely use screenutil units. Placing it elsewhere (e.g., on
a per-screen basis) would require repeated initialization and risks crashes if a widget
accesses a `.sp` value before initialization.

**Risk mitigation**: Edge case from plan — if `ScreenUtilInit` doesn't wrap
`MaterialApp`, the app crashes. Unit test in `app_test.dart` will verify the widget
tree includes `ScreenUtilInit` as an ancestor of `MaterialApp.router`.

---

## Decision 5: app_strings.dart Scope

**Decision**: Populate `app_strings.dart` with all string literals that are knowable at
this phase (app name, onboarding text, auth labels, error messages, nav labels, button
labels). Strings specific to features not yet implemented will be added as stubs with
clear naming conventions and filled when those phases are implemented.

**Rationale**: A partial strings file is better than an empty one. Known strings prevent
inline literals from appearing in Phase 2+ implementations. Stubs keep the file
structure consistent.

---

## Token Verification Table

The following tokens are confirmed from the Figma extraction in `implementation_plan.md`:

### Light Mode Colors (11 tokens)

| Token | Hex Value |
|---|---|
| `primary` | `#2D4B73` |
| `primaryLight` | `#4A6CF7` |
| `scaffoldBg` | `#F9FAFB` |
| `surface` | `#FFFFFF` |
| `textPrimary` | `#111827` |
| `textSecondary` | `#6B7280` |
| `textHint` | `#9CA3AF` |
| `ongoingBg` | `#E7F0FF` |
| `ongoingText` | `#2D4B73` |
| `completedBg` | `#E7F7F2` |
| `completedText` | `#0E9F6E` |

### Dark Mode Colors (5 tokens)

| Token | Hex Value |
|---|---|
| `primary` | `#4A6CF7` |
| `scaffoldBg` | `#111827` |
| `surface` | `#1F2937` |
| `textPrimary` | `#F9FAFB` |
| `textSecondary` | `#9CA3AF` |

### Typography (6 tokens)

| Token | Size | Weight |
|---|---|---|
| `displayLarge` | `24.sp` | Bold (700) |
| `headlineMedium` | `20.sp` | SemiBold (600) |
| `titleLarge` | `18.sp` | SemiBold (600) |
| `bodyLarge` | `16.sp` | Regular (400) |
| `bodyMedium` | `14.sp` | Regular (400) |
| `labelSmall` | `12.sp` | Regular (400) |

### Spacing (6 tokens + 3 radius + 1 shadow)

| Token | Value |
|---|---|
| `xs` | `4.w` |
| `sm` | `8.w` |
| `md` | `16.w` |
| `lg` | `20.w` |
| `xl` | `24.w` |
| `xxl` | `32.w` |
| `radiusCard` | `12.r` |
| `radiusCardLarge` | `16.r` |
| `radiusPill` | `20.r` |
| Shadow | `color: 0x0D000000`, `blurRadius: 4`, `offset: Offset(0, 4)` |
