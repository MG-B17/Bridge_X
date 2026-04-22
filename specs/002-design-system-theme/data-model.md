# Data Model: Design System & Theme

**Feature**: 002-design-system-theme
**Date**: 2026-04-22

> This phase produces configuration/infrastructure — not runtime entities.
> The "data model" here describes the design token catalog and file contract for each
> source file produced by this phase.

---

## File Contracts

### 1. `core/theme/app_color_scheme.dart`

**Type**: `ThemeExtension<AppColorScheme>`
**Access pattern**: `Theme.of(context).extension<AppColorScheme>()!`
**Via extension**: `context.colors` (defined in `core/utils/extensions.dart`)

**Fields** (all `final Color`):

| Field | Light Value | Dark Value |
|---|---|---|
| `primary` | `#2D4B73` | `#4A6CF7` |
| `primaryLight` | `#4A6CF7` | `#4A6CF7` (same) |
| `scaffoldBg` | `#F9FAFB` | `#111827` |
| `surface` | `#FFFFFF` | `#1F2937` |
| `textPrimary` | `#111827` | `#F9FAFB` |
| `textSecondary` | `#6B7280` | `#9CA3AF` |
| `textHint` | `#9CA3AF` | `#9CA3AF` (same) |
| `ongoingBg` | `#E7F0FF` | `#E7F0FF` (same, dark TBD) |
| `ongoingText` | `#2D4B73` | `#4A6CF7` |
| `completedBg` | `#E7F7F2` | `#E7F7F2` (same, dark TBD) |
| `completedText` | `#0E9F6E` | `#0E9F6E` (same) |

**Required methods**:
- `copyWith({Color? primary, ...})` → `AppColorScheme`
- `lerp(AppColorScheme? other, double t)` → `AppColorScheme`
- `static const AppColorScheme light` — the light instance
- `static const AppColorScheme dark` — the dark instance

**Also defines** (as static constants):
```
static const gradient = LinearGradient(
  colors: [Color(0xFF4A6CF7), Color(0xFF2D4B73)],
)
```

---

### 2. `core/theme/text_style.dart`

**Type**: Plain class `AppTextStyles` with 6 static `TextStyle` getters (not const —
require `BuildContext` for `ScreenUtil` scaling)

**Access pattern**: `context.displayLarge`, `context.headlineMedium`, etc.
**Via extension**: `context.*` (defined in `core/utils/extensions.dart`)

| Getter | Size | Weight | Font |
|---|---|---|---|
| `displayLarge` | `24.sp` | `FontWeight.bold` (700) | Inter |
| `headlineMedium` | `20.sp` | `FontWeight.w600` | Inter |
| `titleLarge` | `18.sp` | `FontWeight.w600` | Inter |
| `bodyLarge` | `16.sp` | `FontWeight.normal` (400) | Inter |
| `bodyMedium` | `14.sp` | `FontWeight.normal` (400) | Inter |
| `labelSmall` | `12.sp` | `FontWeight.normal` (400) | Inter |

**Color**: `inherit` — never hardcoded in `text_style.dart`. Color comes from
`context.colors.*` at the call site.

---

### 3. `core/theme/app_them.dart`

**Type**: Class `AppTheme` with two static `ThemeData` getters

| Getter | Mode | ColorScheme | Extension |
|---|---|---|---|
| `AppTheme.light` | Light | `ColorScheme.light()` | `[AppColorScheme.light]` |
| `AppTheme.dark` | Dark | `ColorScheme.dark()` | `[AppColorScheme.dark]` |

Both `ThemeData` instances set:
- `scaffoldBackgroundColor` from `AppColorScheme.scaffoldBg`
- `useMaterial3: true`
- `fontFamily: GoogleFonts.inter().fontFamily`

---

### 4. `core/constant/app_spacing.dart`

**Type**: Abstract class `AppSpacing` with static const fields (requires `ScreenUtil`)

| Field | Type | Value |
|---|---|---|
| `xs` | `double` | `4.w` |
| `sm` | `double` | `8.w` |
| `md` | `double` | `16.w` |
| `lg` | `double` | `20.w` |
| `xl` | `double` | `24.w` |
| `xxl` | `double` | `32.w` |
| `radiusCard` | `double` | `12.r` |
| `radiusCardLarge` | `double` | `16.r` |
| `radiusPill` | `double` | `20.r` |
| `cardShadow` | `BoxShadow` | `color: Color(0x0D000000), blurRadius: 4, offset: Offset(0,4)` |

> Note: Since `.w` and `.r` require `ScreenUtil` to be initialized, these values are
> implemented as static getters (not `const`) — called after `ScreenUtilInit` is built.

---

### 5. `core/constant/app_strings.dart`

**Type**: Abstract class `AppStrings` with static `const String` fields

**Initial known strings** (populated at this phase):

| Constant | Value |
|---|---|
| `appName` | `'TeamUP'` |
| `onboardingTitle1` | `'Find Your Team'` |
| `onboardingTitle2` | `'Collaborate Smarter'` |
| `onboardingTitle3` | `'Track Your Progress'` |
| `login` | `'Login'` |
| `register` | `'Register'` |
| `email` | `'Email'` |
| `password` | `'Password'` |
| `forgotPassword` | `'Forgot Password?'` |
| `verifyOtp` | `'Verify OTP'` |
| `continue_` | `'Continue'` |
| `skip` | `'Skip'` |
| `next` | `'Next'` |
| `home` | `'Home'` |
| `teams` | `'Teams'` |
| `workspace` | `'Workspace'` |
| `chat` | `'Chat'` |
| `profile` | `'Profile'` |
| `notifications` | `'Notifications'` |
| `errorGeneric` | `'Something went wrong. Please try again.'` |
| `errorNoInternet` | `'No internet connection. Please check your network.'` |
| `errorTimeout` | `'Request timed out. Please try again.'` |
| `errorUnauthorized` | `'Your session has expired. Please log in again.'` |
| `noResultsFound` | `'No results found.'` |
| `loading` | `'Loading...'` |

---

### 6. `app.dart`

**Type**: Stateless root widget `App`

**Widget tree**:
```
ScreenUtilInit(
  designSize: Size(390, 844),
  builder: (_, __) => MaterialApp.router(
    title: AppStrings.appName,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    routerConfig: AppRouter.router,       ← wired in later (Phase 4)
  ),
)
```

---

### 7. `core/utils/extensions.dart`

**Type**: Extension methods on `BuildContext`

**Color access**:
```dart
extension AppColors on BuildContext {
  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;
}
```

**Text style access**:
```dart
extension AppTypography on BuildContext {
  TextStyle get displayLarge   => AppTextStyles.displayLarge;
  TextStyle get headlineMedium => AppTextStyles.headlineMedium;
  TextStyle get titleLarge     => AppTextStyles.titleLarge;
  TextStyle get bodyLarge      => AppTextStyles.bodyLarge;
  TextStyle get bodyMedium     => AppTextStyles.bodyMedium;
  TextStyle get labelSmall     => AppTextStyles.labelSmall;
}
```

---

## Token → File Dependency Map

```
AppColorScheme (app_color_scheme.dart)
    ↑ consumed by
AppTheme (app_them.dart) → MaterialApp.router (app.dart)
    ↑ also consumed by
BuildContext extension (extensions.dart) ← every feature widget

AppTextStyles (text_style.dart)
    ↑ consumed by
BuildContext extension (extensions.dart) ← every feature widget

AppSpacing (app_spacing.dart)
    ↑ consumed by
every widget that needs padding / border radius / shadow

AppStrings (app_strings.dart)
    ↑ consumed by
every widget displaying user-visible text
```
