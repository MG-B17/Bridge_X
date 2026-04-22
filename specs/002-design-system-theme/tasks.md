---
description: "Task list for Phase 1 — Design System & Theme"
---

# Tasks: Design System & Theme (Phase 1)

**Input**: Design documents from `specs/002-design-system-theme/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, quickstart.md ✅

**Tests**: No automated test tasks — this phase produces pure configuration/infrastructure.
Verification is done via `flutter analyze`, manual visual spot checks (light/dark/offline),
and confirming `context.colors.*` resolves correctly in any future widget test.

**User Stories**:
- **US1** (P1): Developer uses Figma color tokens via context — never hardcodes hex
- **US2** (P1): Designer verifies exact Figma token parity at `390×844`
- **US3** (P2): QA engineer wraps widgets in theme with zero boilerplate

**Organization**: US1 and US2 share implementation tasks (same 7 files). US3 is satisfied
by `extensions.dart` being available — no extra test file needed (tests not explicitly
requested in spec). Setup and Foundational phases handle font asset prerequisites.

---

## Phase 1: Setup (Inter Font Local Assets)

**Purpose**: Ensure Inter font files exist on disk and are registered in `pubspec.yaml`
before any other file is written. Typography implementation depends on this.

- [x] T001 Download Inter font files (Regular, SemiBold `weight:600`, Bold `weight:700`)
  from https://fonts.google.com/specimen/Inter and place the TTF files at:
  `assets/fonts/Inter-Regular.ttf`, `assets/fonts/Inter-SemiBold.ttf`,
  `assets/fonts/Inter-Bold.ttf`. Create the `assets/fonts/` directory if missing.

- [x] T002 In `pubspec.yaml`, add the following font declaration under the `flutter:` section
  (after the existing `assets:` block):
  ```yaml
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
  ```
  Then run `flutter pub get` to confirm zero errors.

**Checkpoint**: `assets/fonts/` contains 3 TTF files, `pubspec.yaml` font section is
registered, `flutter pub get` exits with code 0.

---

## Phase 2: Foundational (Color + Theme Infrastructure)

**Purpose**: Build the `AppColorScheme` ThemeExtension and `AppTheme` wrappers before
any context extension or spacing constants are added — all other files depend on these.

- [x] T003 Create `lib/core/theme/app_color_scheme.dart`. Define `AppColorScheme extends
  ThemeExtension<AppColorScheme>` with 11 `final Color` fields (all light-mode tokens),
  `static const AppColorScheme light` (all 11 hex values from Figma), `static const
  AppColorScheme dark` (5 overridden + 6 inherited from light), `static const gradient`
  (`LinearGradient` from `#4A6CF7` to `#2D4B73`), and required `copyWith` and `lerp`
  overrides. Light tokens: `primary:#2D4B73`, `primaryLight:#4A6CF7`,
  `scaffoldBg:#F9FAFB`, `surface:#FFFFFF`, `textPrimary:#111827`,
  `textSecondary:#6B7280`, `textHint:#9CA3AF`, `ongoingBg:#E7F0FF`,
  `ongoingText:#2D4B73`, `completedBg:#E7F7F2`, `completedText:#0E9F6E`.
  Dark overrides: `primary:#4A6CF7`, `scaffoldBg:#111827`, `surface:#1F2937`,
  `textPrimary:#F9FAFB`, `textSecondary:#9CA3AF`.

- [x] T004 Modify `lib/core/theme/app_them.dart`. Implement abstract class `AppTheme`
  with two static getters: `static ThemeData get light` → `ThemeData(useMaterial3: true,
  scaffoldBackgroundColor: AppColorScheme.light.scaffoldBg, extensions:
  [AppColorScheme.light], ...)` and `static ThemeData get dark` (same structure with
  dark extension). Both themes set `fontFamily` to `GoogleFonts.inter().fontFamily`.

**Checkpoint**: `app_color_scheme.dart` and `app_them.dart` compile with zero errors.
`AppTheme.light` and `AppTheme.dark` return valid `ThemeData` instances.

---

## Phase 3: User Story 1 — Developer Uses Color Tokens Without Hardcoding (Priority: P1) 🎯 MVP

**Goal**: Complete all 7 design system files so every subsequent phase can access colors,
typography, spacing, and strings through standardized APIs — no hardcoded values anywhere.

**Independent Test**: A widget wrapped in `MaterialApp(theme: AppTheme.light)` resolves
`context.colors.primary` to a non-null `Color` value matching `#2D4B73`, and
`context.headlineMedium` returns a non-null `TextStyle` with size 20 — confirmed by
`flutter analyze` passing and a manual print-and-run check.

### Implementation for User Story 1

- [x] T005 [US1] Modify `lib/core/theme/text_style.dart`. Define abstract class
  `AppTextStyles` with 6 static `TextStyle` getters using `GoogleFonts.inter()` as
  the base: `displayLarge` (24.sp, FontWeight.bold), `headlineMedium` (20.sp,
  FontWeight.w600), `titleLarge` (18.sp, FontWeight.w600), `bodyLarge` (16.sp,
  FontWeight.normal), `bodyMedium` (14.sp, FontWeight.normal), `labelSmall` (12.sp,
  FontWeight.normal). No color is set in any style — color is always applied at the
  call site.

- [x] T006 [P] [US1] Create `lib/core/constant/app_spacing.dart`. Define abstract class
  `AppSpacing` with static getters (not `const` — require ScreenUtil init) for:
  `xs` (4.w), `sm` (8.w), `md` (16.w), `lg` (20.w), `xl` (24.w), `xxl` (32.w),
  `radiusCard` (12.r), `radiusCardLarge` (16.r), `radiusPill` (20.r), and
  `cardShadow` → `BoxShadow(color: Color(0x0D000000), blurRadius: 4,
  offset: Offset(0, 4))`.

- [x] T007 [P] [US1] Modify `lib/core/constant/app_strings.dart`. Define abstract class
  `AppStrings` with `static const String` fields for all known strings: `appName`
  (`'TeamUP'`), `onboardingTitle1/2/3`, `login`, `register`, `email`, `password`,
  `forgotPassword`, `verifyOtp`, `continue_`, `skip`, `next`, navigation labels
  (`home`, `teams`, `workspace`, `chat`, `profile`, `notifications`), and error
  constants (`errorGeneric`, `errorNoInternet`, `errorTimeout`, `errorUnauthorized`,
  `noResultsFound`, `loading`). Full list in `data-model.md`.

- [x] T008 [US1] Create `lib/core/utils/extensions.dart`. Define two extensions on
  `BuildContext`: (1) `extension AppColors on BuildContext` with getter `colors` →
  `Theme.of(this).extension<AppColorScheme>()!`, and (2) `extension AppTypography on
  BuildContext` with 6 getters: `displayLarge`, `headlineMedium`, `titleLarge`,
  `bodyLarge`, `bodyMedium`, `labelSmall` — each delegating to the corresponding
  `AppTextStyles` getter.

- [x] T009 [US1] Modify `lib/app.dart`. Replace the existing root widget body with:
  `ScreenUtilInit(designSize: const Size(390, 844), minTextAdapt: true, builder: (_,
  __) => MaterialApp.router(title: AppStrings.appName, theme: AppTheme.light,
  darkTheme: AppTheme.dark, themeMode: ThemeMode.system, routerConfig: ...))`.
  Keep `routerConfig` wired to whatever is currently configured (or a placeholder
  `GoRouter(routes: [])` stub if not yet implemented in Phase 4).

**Checkpoint**: All 7 files compile. `flutter analyze` reports zero errors. A developer
can write `context.colors.primary` in any widget under `MaterialApp` without importing
`AppColorScheme` — the only import needed is `core/utils/extensions.dart`.

---

## Phase 4: User Story 2 — Designer Verifies Exact Figma Token Parity (Priority: P1)

**Goal**: Manually verify every token renders at the correct value on a `390×844`
reference device — no implementation changes, verification-only.

**Independent Test**: Side-by-side comparison of the app running on a `390px`-wide
emulator against the Figma frame shows zero visible discrepancy in spacing, radius,
shadow, and typography.

### Verification for User Story 2

- [x] T010 [US2] Run the app on a `390×844` emulator or physical device (`flutter run
  --debug`). Perform the light-mode spot check from `quickstart.md Step 4`:
  scaffold background is off-white `#F9FAFB`, primary buttons are `#2D4B73`, body
  text is `#111827`, secondary text is `#6B7280`, card shadow is soft/visible,
  card corners are noticeably rounded, typography is Inter font.

- [x] T011 [P] [US2] Switch the OS to dark mode while the app is running. Perform the
  dark-mode spot check from `quickstart.md Step 5`: scaffold goes to `#111827`,
  surfaces to `#1F2937`, body text to `#F9FAFB`, primary to `#4A6CF7`.
  Confirm all colors update on next frame — no restart required.

- [x] T012 [P] [US2] Disable network on the device, clear app data, and relaunch.
  Perform the offline font check from `quickstart.md Step 6`: typography renders in
  Inter — not the OS default system font. Confirm by observing the distinct Inter
  letterforms (`a`, `g`, `l`).

**Checkpoint**: All three spot checks pass. Zero hardcoded hex values visible in any
theme-related source file.

---

## Phase 5: User Story 3 — QA Widget Test Theme Wrapper (Priority: P2)

**Goal**: Confirm that any widget test can wrap a subject widget in the standard theme
with zero boilerplate beyond the wrapper itself.

**Independent Test**: A minimal widget test that wraps a `Text` widget in
`MaterialApp(theme: AppTheme.light, home: Builder(builder: (ctx) => Text('test',
style: ctx.bodyMedium)))` passes without null errors and without any additional setup.

### Verification for User Story 3

- [x] T013 [US3] In `test/widget_test.dart` (or any existing test file), write and run
  a minimal verification snippet:
  ```dart
  testWidgets('Theme resolves without null errors', (WidgetTester tester) async {
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        theme: AppTheme.light,
        home: Builder(builder: (ctx) {
          // These will throw if they can't find the extension or the style
          expect(ctx.colors.primary, isNotNull);
          expect(ctx.bodyMedium, isNotNull);
          return const SizedBox();
        }),
      ),
    ));
  });
  ```
  Run with `flutter test`. Confirm it passes — no exceptions, no null pointer errors.

**Checkpoint**: `flutter test` passes for the theme wrapper test. US3 is fully satisfied.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final static analysis pass, cleanup, and version control commit.

- [x] T014 Run `flutter analyze` from the project root. Confirm `No issues found!`
  (zero errors, zero warnings). Fix any lint issues in the 7 modified/created files
  before committing.

- [x] T015 [P] Run `flutter build apk --debug` to confirm the project still compiles
  end-to-end after all theme changes. Confirm the build artifact is produced at
  `build/app/outputs/flutter-apk/app-debug.apk` with exit code 0.

- [x] T016 [P] Review all 7 modified/created files to confirm: (a) no hardcoded hex
  color in any feature file, (b) no magic number sizes outside `app_spacing.dart`,
  (c) no direct `AppColorScheme` import outside `extensions.dart` and `app_them.dart`,
  (d) all `.sp` / `.w` / `.r` usages are inside widgets that are descendants of
  `ScreenUtilInit` in the widget tree.

- [x] T017 [P] Commit all changes to version control:
  `git add . ; git commit -m "feat(design-system): implement foundational design system and theme"`
