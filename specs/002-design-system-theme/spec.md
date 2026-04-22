# Feature Specification: Design System & Theme

**Feature Branch**: `002-design-system-theme`
**Created**: 2026-04-22
**Status**: Draft
**Input**: Phase 1 from `implementation_plan.md` — Fill all empty theme files using Figma tokens exactly as extracted.

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Developer Uses Figma Color Tokens Without Knowing Hex Values (Priority: P1)

As a developer implementing any feature screen in TeamUP, I need a single centralized
color system derived from the Figma design so that I never hardcode a hex value and all
screens are visually consistent with the design brief.

**Why this priority**: Every subsequent phase (Phases 2–29) will import colors for UI
rendering. A missing or incorrect token here causes visual regressions across the entire app.

**Independent Test**: After completing this story, a developer can access any design color
(e.g., primary, surface, textSecondary) through the theme context and see the correct
value — without importing any color class directly into their feature file.

**Acceptance Scenarios**:

1. **Given** the color system is in place,
   **When** a developer accesses the primary color via the theme context on a test widget,
   **Then** the resolved color matches the Figma-specified hex value `#2D4B73` in light
   mode and `#4A6CF7` in dark mode — with no import of a color class required.

2. **Given** a device switches from light mode to dark mode,
   **When** any screen rebuilds,
   **Then** all colors automatically update to their dark-mode equivalents without any
   conditional logic inside feature files.

3. **Given** the app is running on any screen size,
   **When** any text or layout element renders,
   **Then** it uses the design system values rather than hardcoded sizes, and the visual
   output matches the Figma frame proportions.

4. **Given** no internet connection is available on first launch,
   **When** the app loads,
   **Then** typography renders correctly using a locally bundled font asset — not a
   network-fetched font — so the visual experience is identical offline and online.

---

### User Story 2 — Designer Verifies Exact Figma Token Parity (Priority: P1)

As a designer reviewing the implemented app, I need every spacing, radius, shadow, and
typography value to match the Figma design frame exactly so that the delivered app is
pixel-accurate and no design debt accumulates.

**Why this priority**: Design fidelity is a non-negotiable constitutional requirement.
Any deviation discovered late costs significantly more to fix than if caught at the
design-system stage.

**Independent Test**: A side-by-side comparison of the app at `390×844` viewport against
the Figma frame shows no visible discrepancy in spacing, border radius, shadow, or
typography across the color tokens defined in the design system.

**Acceptance Scenarios**:

1. **Given** the spacing constants are in place,
   **When** a card is rendered on a `390px`-wide screen,
   **Then** its padding, gap, and border radius values match the Figma specification
   without visible deviation.

2. **Given** the typography system is in place,
   **When** a page title renders,
   **Then** it uses the SemiBold Inter font at the size corresponding to `headlineMedium`
   in the design token table — no hardcoded font size or weight exists in any feature file.

3. **Given** the shadow token is configured,
   **When** a card component renders on the off-white scaffold background,
   **Then** a soft shadow with 5% black opacity and 4px blur is visible at 4px vertical
   offset — matching the Figma shadow specification.

---

### User Story 3 — QA Engineer Writes Widget Tests Without Theme Setup Boilerplate (Priority: P2)

As a QA engineer writing widget tests, I need the theme to be trivially wrappable around
any test widget so that every test can verify exact design-system colors without
duplicating theme configuration code.

**Why this priority**: Without a consistent test theme wrapper, every test author will
invent their own approach, making tests brittle and inconsistent.

**Independent Test**: A widget test that wraps any widget in the standard test theme
wrapper passes without errors and resolves colors/styles to the correct design-system
values.

**Acceptance Scenarios**:

1. **Given** the theme is set up,
   **When** a widget test wraps a component in the project's standard theme,
   **Then** the test resolves all context-based colors and styles without throwing null
   errors or requiring additional setup code.

---

### Edge Cases

- What if the Inter font fails to load from the local asset (missing `pubspec.yaml` registration)?
  → App falls back to the system default font. This is prevented by verifying the local
  asset path is registered in `pubspec.yaml` and runs on the first launch smoke test.
- What if a developer uses a hardcoded hex value instead of a token?
  → The linter (via `flutter_lints`) does not catch this automatically. Prevention relies
  on code review and the constitution's "no magic numbers" rule.
- What if `ScreenUtilInit` is initialized with the wrong design frame dimensions?
  → All responsive sizes will be proportionally incorrect across all screens. Prevention:
  design size is locked to `390×844` per constitution and verified in the app root widget.
- What if a new color is needed that isn't in the Figma design?
  → It must not be invented. A constitution amendment or Figma update is required before
  any new color token can be added.
- What if the dark-mode token set is incomplete?
  → Only the 5 dark-mode equivalents defined in the Figma extraction are required now;
  all others inherit from light mode until the full dark theme is designed.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The color system MUST define exactly 11 named light-mode color tokens
  (`primary`, `primaryLight`, `scaffoldBg`, `surface`, `textPrimary`, `textSecondary`,
  `textHint`, `ongoingBg`, `ongoingText`, `completedBg`, `completedText`) matching the
  hex values extracted from Figma.
- **FR-002**: The color system MUST define 5 dark-mode equivalents (`primary`,
  `scaffoldBg`, `surface`, `textPrimary`, `textSecondary`) matching the dark-mode
  Figma hex values.
- **FR-003**: Colors MUST be accessible from any widget through the theme context only —
  no direct class imports allowed in feature files.
- **FR-004**: The color system MUST support smooth animated transitions between light and
  dark mode via standard theme interpolation (`lerp`).
- **FR-005**: The typography system MUST define 6 named text style tokens
  (`displayLarge`, `headlineMedium`, `titleLarge`, `bodyLarge`, `bodyMedium`,
  `labelSmall`) using the Inter font at the sizes and weights specified in the Figma
  design.
- **FR-006**: All text sizes MUST be responsive — scaling proportionally to the device
  screen width based on the `390px` reference frame width.
- **FR-007**: The Inter font MUST be available as a local asset so the app renders
  correct typography even without an internet connection on first launch.
- **FR-008**: The spacing system MUST define 6 named spacing constants (`xs`, `sm`,
  `md`, `lg`, `xl`, `xxl`) and 3 border radius constants (`radiusCard`,
  `radiusCardLarge`, `radiusPill`) matching the Figma specification.
- **FR-009**: The shadow specification MUST be defined as a named constant — not
  hardcoded at the call site — matching the Figma soft shadow spec (5% black opacity,
  4px blur, 4px vertical offset).
- **FR-010**: The root application widget MUST initialize the responsive sizing system
  with the `390×844` design frame before any screen renders.
- **FR-011**: Both light and dark `ThemeData` instances MUST be wired into the root
  application widget so the operating system's theme preference controls the displayed
  theme with no manual toggle required.
- **FR-012**: A standard gradient MUST be defined as a named constant (`#4A6CF7 →
  #2D4B73`, horizontal direction) for use on onboarding and impact card backgrounds.
- **FR-013**: All string literals used across the app MUST be centralized in a single
  constants file — no inline string literals in feature files.

### Key Entities

- **Color Token Set**: The 11 light + 5 dark named color constants derived from Figma.
  Changing a token here propagates the change to every widget in the app.
- **Typography Scale**: The 6 Inter text styles with responsive sizing. These are the
  only text styles permitted in the app.
- **Spacing Constants**: The 6 spacing + 3 radius + 1 shadow constants. These are the
  only layout dimensions permitted (no magic numbers).
- **Root Widget Configuration**: The app entry point that wires together the responsive
  sizing initializer, theme data (light + dark), and router — a change here affects
  the entire app's visual baseline.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of the 11 light-mode and 5 dark-mode color tokens are reachable from
  a widget context — verified by a widget test that reads each token and asserts its
  resolved value.
- **SC-002**: All 6 typography tokens render at the correct responsive size on a `390px`
  reference device — deviation from the Figma specified size is 0px at the reference
  frame width.
- **SC-003**: The app launches and renders correct typography with the Inter font on a
  device with no internet connection — zero font fallback occurrences in the first
  1,000 app starts.
- **SC-004**: Switching the OS between light and dark mode causes all themed colors to
  update on the next frame — zero manual conditionals in any feature file.
- **SC-005**: A widget test for any screen that wraps the subject widget in the standard
  theme requires zero additional setup lines beyond the standard wrapper — confirmed
  by a passing test with no null theme errors.
- **SC-006**: `flutter analyze` reports zero errors and zero warnings after all theme
  files are implemented.
- **SC-007**: A side-by-side review of the app on a `390×844` device against the Figma
  frame shows no visible spacing, radius, or shadow discrepancy across all implemented
  color tokens.

## Assumptions

- The Figma design frame dimensions are `390×844` pixels — this is locked by the
  project constitution and will not change.
- The Inter font files are available for local bundling as asset files in the project;
  if only the `google_fonts` package version is available (network), a local fallback
  copy will need to be added to `assets/fonts/`.
- Only the 5 dark-mode color equivalents extracted from the Figma document are required
  now; a full dark-mode color set will be designed and implemented in a future phase.
- All string literals used across the app are already partially known from the Figma
  screens; any strings not yet encountered will be added to the constants file as
  subsequent phases are implemented.
- The gradient (`#4A6CF7 → #2D4B73`) is a linear horizontal gradient — the direction
  and stop positions are not specified beyond this and will follow standard linear
  gradient conventions.
- No custom icon font is required in this phase — all icons will use Material Icons
  (bundled with Flutter) or SVG assets already in `assets/svg/`.
