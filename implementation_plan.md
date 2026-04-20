# TeamUP — Flutter Implementation Plan (Final)

## ✅ Technical Decisions (Locked)

| Concern | Decision |
|---|---|
| **Architecture** | Clean Architecture — `data → domain → presentation` |
| **State Management** | Bloc / Cubit |
| **File Structure** | Feature-First + Shared `core/` |
| **Navigation** | `go_router` |
| **Dependency Injection** | `get_it` |
| **Networking** | `dio` |
| **Real-time (Chat)** | `web_socket_channel` |
| **Responsive UI** | `flutter_screenutil` on every widget |
| **Local Storage** | `sqflite` — structured local data, caching |

---

## 🏛️ Architecture Rules

| Rule | Detail |
|---|---|
| **SOLID** | Every class has one reason to change — no fat classes |
| **Entities** | Pure Dart — no Flutter, no JSON, no annotations |
| **Models** | Extend entity + `fromJson` / `toJson` |
| **Repository interface** | In `domain/` — abstract only |
| **Repository impl** | In `data/` — concrete, implements domain interface |
| **UseCase** | One action per class, returns `Either<Failure, T>` via `dartz` |
| **Bloc/Cubit scope** | Presentation only — no data/domain imports in pages |
| **`get_it`** | Only place `new` keyword lives for dependencies |
| **`go_router`** | All navigation — zero `Navigator.push()` anywhere |
| **`buildWhen`** | Use only when a Bloc emits multiple states and only some require a UI rebuild |
| **Static Bloc access** | `context.read<Bloc>().add(...)` for triggering events — not inside `build()` |
| **Responsive UI** | Every size uses `.w`, `.h`, `.sp` from `flutter_screenutil` |
| **Clean code** | No magic numbers, no unused imports, all names are meaningful |
| **Follow Figma** | UI must match Figma exactly — no custom/invented UI |

---

## 🎨 Design System — Extracted from Figma

### Colors

```dart
// Primary
static const Color primary          = Color(0xFF2D4B73); // Deep Blue — buttons, active nav, headings
static const Color primaryLight     = Color(0xFF4A6CF7); // Medium Blue — gradient start, highlights

// Gradient (onboarding, impact cards)
// LinearGradient: Color(0xFF4A6CF7) → Color(0xFF2D4B73)

// Status
static const Color ongoingBg        = Color(0xFFE7F0FF); // Light Blue — "Ongoing" badge background
static const Color ongoingText      = Color(0xFF2D4B73); // Deep Blue — "Ongoing" badge text
static const Color completedBg      = Color(0xFFE7F7F2); // Mint Green — "Completed" badge background
static const Color completedText    = Color(0xFF0E9F6E); // Dark Green — "Completed" badge text

// Background
static const Color scaffoldBg       = Color(0xFFF9FAFB); // Off-white — page background
static const Color surface          = Color(0xFFFFFFFF); // White — cards, nav bar, inputs

// Text
static const Color textPrimary      = Color(0xFF111827); // Near Black — headings, body
static const Color textSecondary    = Color(0xFF6B7280); // Medium Gray — subtitles, labels
static const Color textHint         = Color(0xFF9CA3AF); // Light Gray — hints, disabled
```

### Typography — Inter font

```dart
// All sizes in .sp via flutter_screenutil
displayLarge     → 24.sp / Bold       // Splash, onboarding main titles
headlineMedium   → 20.sp / SemiBold   // Page titles
titleLarge       → 18.sp / SemiBold   // Card titles, section headers
bodyLarge        → 16.sp / Regular    // Buttons, subheadings
bodyMedium       → 14.sp / Regular    // Standard body, labels
labelSmall       → 12.sp / Regular    // Status badges, dates, roles, metadata
```

### Spacing (flutter_screenutil)

```dart
static const double xs   = 4;   // → 4.w
static const double sm   = 8;   // → 8.w
static const double md   = 16;  // → 16.w  (card internal padding, element gaps)
static const double lg   = 20;  // → 20.w  (page horizontal margin)
static const double xl   = 24;  // → 24.w
static const double xxl  = 32;  // → 32.w
```

### Border Radius

```dart
static const double radiusCard      = 12; // Cards and buttons  → .r
static const double radiusCardLarge = 16; // Large cards        → .r
static const double radiusPill      = 20; // Status badges/chips → .r (fully rounded)
```

### Elevation / Shadow

```dart
// Soft shadow used on white cards against the off-white background
BoxShadow(
  color: Colors.black.withOpacity(0.05),
  blurRadius: 4,
  offset: Offset(0, 4),
)
```

---

## 📦 Packages (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State management — Bloc pattern with Cubit support
  flutter_bloc: ^8.1.6

  # Value equality for entities, states, events — required by Bloc
  equatable: ^2.0.5

  # Declarative routing with type-safe route configuration
  go_router: ^14.2.0

  # Service locator for dependency injection
  get_it: ^8.0.2

  # HTTP client with interceptors, timeout config, and multipart support
  dio: ^5.6.0

  # Dio interceptor for readable request/response logs in debug mode only
  pretty_dio_logger: ^1.4.0

  # WebSocket client for real-time chat messaging
  web_socket_channel: ^3.0.1

  # Functional error handling — Either<Failure, Data> for all use cases
  dartz: ^0.10.1

  # Responsive layout sizing — .w .h .sp units on all widgets
  flutter_screenutil: ^5.9.3

  # Efficient network image loading with disk caching
  cached_network_image: ^3.4.1

  # SVG asset rendering support
  flutter_svg: ^2.0.10+1

  # Skeleton loading animation shown while data is fetching
  shimmer: ^3.0.0

  # Lottie animation player — used in onboarding and AI matching screens
  lottie: ^3.1.2

  # Chart library — used for productivity stats and activity bar chart on home screen
  fl_chart: ^0.69.0

  # Inter font family from Google Fonts — matches Figma typography
  google_fonts: ^6.2.1

  # Lightweight key-value storage — used only for auth token and first-launch flag
  shared_preferences: ^2.3.2

  # Relational local database — used for offline caching of projects, tasks, and messages
  sqflite: ^2.3.3+1

  # Provides the correct local database file path for sqflite on each platform
  path: ^1.9.0

  # Device image/camera picker — used in profile photo upload
  image_picker: ^1.1.2

  # Multi-type file picker — used in chat file attachment
  file_picker: ^8.1.2

  # App file system paths — needed by file picker and attachments
  path_provider: ^2.1.4

  # Date formatting for task due dates and message timestamps
  intl: ^0.19.0

  # Network connectivity detection — used in NetworkInfo for offline check
  connectivity_plus: ^6.0.5

  # Reliable active internet checker (beyond connectivity status)
  internet_connection_checker_plus: ^2.5.1

  # Reactive stream utilities — used for WebSocket stream transformations in chat
  rxdart: ^0.28.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Unit testing utilities for Bloc/Cubit — emit sequence assertions
  bloc_test: ^9.1.7

  # Mock objects for unit tests without code generation
  mocktail: ^1.0.4

  # Dart lint rules enforcing clean code style
  flutter_lints: ^5.0.0
```

---

## 🗂️ File Structure

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constant/
│   │   ├── app_strings.dart          ← exists, fill with all string literals
│   │   └── app_spacing.dart          ← NEW: spacing constants
│   ├── theme/
│   │   ├── app_color.dart            ← exists, fill from Figma tokens above
│   │   ├── app_them.dart             ← exists, fill ThemeData
│   │   └── text_style.dart           ← exists, fill typography from Figma
│   ├── network/
│   │   ├── network_info.dart         ← exists, implement with connectivity_plus
│   │   ├── api_client.dart           ← NEW: Dio instance + interceptors
│   │   └── api_endpoints.dart        ← NEW: all URL constants
│   ├── di/
│   │   └── di.dart                   ← exists, register all core dependencies
│   ├── navigation/
│   │   ├── app_route.dart            ← exists, implement GoRouter
│   │   └── app_route_constant.dart   ← exists, fill route name constants
│   ├── error/
│   │   ├── exception.dart            ← exists, define all exception types
│   │   ├── failure.dart              ← exists, define all failure types
│   │   └── error_strings.dart        ← exists, error message constants
│   ├── helper/
│   │   ├── api/                      ← exists
│   │   └── cache/                    ← exists, add CacheHelper (SharedPreferences)
│   ├── utils/
│   │   ├── validators.dart           ← NEW
│   │   ├── date_formatter.dart       ← NEW
│   │   └── extensions.dart           ← NEW
│   └── widgets/
│       ├── bridge_app_button.dart    ← exists, implement from Figma
│       ├── app_text_field.dart       ← NEW
│       ├── app_loading.dart          ← NEW
│       ├── app_error_widget.dart     ← NEW
│       └── app_avatar.dart           ← NEW
│
└── features/
    ├── auth/
    ├── home/
    ├── teams/
    ├── workspace/
    ├── chat/
    ├── profile/
    ├── notifications/
    └── company/
```

---

## 🚀 Implementation Phases

---

### Phase 0 — Packages Setup
**Goal:** Add all packages to pubspec.yaml, verify the project builds.

- [ ] Add all packages listed above to `pubspec.yaml`
- [ ] Run `flutter pub get` — zero errors
- [ ] Verify `assets/images/` and `assets/svg/` sections registered

**Deliverable:** Clean project with all packages installed.

---

### Phase 1 — Design System & Theme
**Goal:** Fill all empty theme files using Figma tokens exactly as extracted above.

- [ ] `core/theme/app_color.dart` — implement all color constants from Figma tokens section
- [ ] `core/theme/text_style.dart` — Inter font, full hierarchy using `.sp` for all sizes
- [ ] `core/theme/app_them.dart` — build `ThemeData` from color + text tokens, light mode only
- [ ] `core/constant/app_spacing.dart` — spacing and border radius constants from Figma
- [ ] `core/constant/app_strings.dart` — fill all string literals used across the app
- [ ] `app.dart` — `MaterialApp.router` wrapped in `ScreenUtilInit` (design size: `390×844`), theme applied

**Deliverable:** Design system ready — all Figma tokens available as named Dart constants.

---

### Phase 2 — Core: Error Handling & UseCase Base
**Goal:** Build the error layer and base UseCase contract.

- [ ] `core/error/exception.dart`:
  ```dart
  class ServerException extends Equatable {
    const ServerException({required this.message});
    final String message;
    @override List<Object> get props => [message];
  }
  class CacheException extends Equatable {
    const CacheException({required this.message});
    final String message;
    @override List<Object> get props => [message];
  }
  class NetworkException extends Equatable {
    const NetworkException({required this.message});
    final String message;
    @override List<Object> get props => [message];
  }
  class UnauthorizedException extends Equatable {
    const UnauthorizedException({required this.message});
    final String message;
    @override List<Object> get props => [message];
  }
  ```
- [ ] `core/error/failure.dart`:
  ```dart
  abstract class Failure extends Equatable {}
  class ServerFailure extends Failure { ... }
  class NetworkFailure extends Failure {}
  class CacheFailure extends Failure { ... }
  class UnauthorizedFailure extends Failure {}
  ```
- [ ] `core/error/error_strings.dart` — constant error message strings
- [ ] `core/usecases/usecase.dart`:
  ```dart
  abstract class UseCase<Type, Params> {
    Future<Either<Failure, Type>> call({required Params params});
  }
  class NoParams extends Equatable {
    const NoParams();
    @override List<Object> get props => [];
  }
  ```

**Deliverable:** Failure hierarchy + UseCase base class available for all features.

---

### Phase 3 — Core: Network Client (Dio)
**Goal:** Fully configured Dio instance with auth and error interceptors.

- [ ] `core/network/network_info.dart` — implement using `internet_connection_checker_plus`
- [ ] `core/network/api_endpoints.dart` — all URL constants as `static const String` (stubs until backend ready)
- [ ] `core/network/api_client.dart`:
  - Dio instance with base URL, timeouts (`connectTimeout: 30s`, `receiveTimeout: 30s`)
  - `AuthInterceptor` — reads token from `CacheHelper`, attaches as `Authorization: Bearer <token>`
  - `ErrorInterceptor` — maps HTTP status codes → typed exceptions (401 → `UnauthorizedException`, 5xx → `ServerException`)
  - `pretty_dio_logger` added only in debug mode
- [ ] `core/helper/cache/cache_helper.dart` — `SharedPreferences` wrapper:
  - `saveToken(String)`, `getToken()`, `deleteToken()`
  - `saveUserRole(String)`, `getUserRole()`
  - `setFirstLaunch(bool)`, `isFirstLaunch()`

**Deliverable:** `ApiClient` ready — all future datasources use `sl<ApiClient>()`.

---

### Phase 4 — Core: Router & DI Shell
**Goal:** Wire `go_router` and register all core singletons in `get_it`.

- [ ] `core/navigation/app_route_constant.dart` — all route paths as `static const String`:
  ```dart
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';
  // ... all remaining routes
  ```
- [ ] `core/navigation/app_route.dart` — `GoRouter` configuration:
  - `redirect` guard: check token + role → appropriate entry point
  - Stub routes returning `const Scaffold(body: SizedBox())` for all pages
  - `StatefulShellRoute` for bottom navigation shell (added in Phase 13)
- [ ] `core/di/di.dart` — register core with category comments:
  ```dart
  // ─── Local Storage ───────────────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sl()));

  // ─── Network ─────────────────────────────────────────────────
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));

  // Feature DI sections follow the same pattern:
  // ─── Data Sources ─────────────────────────────────────────────
  // sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  // sl.registerLazySingleton<AuthLocalDataSource>(() =>  AuthLocalDataSourceImpl(sl()));

  // ─── Repositories ─────────────────────────────────────────────
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl(), sl()));

  // ─── Use Cases ────────────────────────────────────────────────
  // sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  // ─── Bloc / Cubit ─────────────────────────────────────────────
  // sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  ```
- [ ] `main.dart` — `await initDi()` before `runApp()`

**Deliverable:** App starts, routing redirects correctly, DI shell initialized.

---

### Phase 5 — Core: Extensions, Color Schema & Shared Widgets
**Goal:** Create `BuildContext` extensions for colors and text styles so every feature accesses the design system through `context` — never by importing `AppColors` or `AppTextStyles` directly. Then build the shared widget library from Figma.

#### 5a — AppColorScheme Extension
- [ ] `core/theme/app_color.dart` — define a custom `AppColorScheme` class holding all Figma tokens:
  ```dart
  class AppColorScheme {
    const AppColorScheme();
    final Color primary          = const Color(0xFF2D4B73);
    final Color primaryLight     = const Color(0xFF4A6CF7);
    final Color scaffoldBg       = const Color(0xFFF9FAFB);
    final Color surface          = const Color(0xFFFFFFFF);
    final Color textPrimary      = const Color(0xFF111827);
    final Color textSecondary    = const Color(0xFF6B7280);
    final Color textHint         = const Color(0xFF9CA3AF);
    final Color ongoingBg        = const Color(0xFFE7F0FF);
    final Color ongoingText      = const Color(0xFF2D4B73);
    final Color completedBg      = const Color(0xFFE7F7F2);
    final Color completedText    = const Color(0xFF0E9F6E);
  }
  ```

#### 5b — BuildContext Color Extension
- [ ] `core/utils/extensions.dart` — add color extension on `BuildContext`:
  ```dart
  extension AppColorsExtension on BuildContext {
    AppColorScheme get colors => const AppColorScheme();
  }
  ```
  - **Usage in any feature:** `context.colors.primary` — never `AppColors.primary` directly
  - Enforced: features must only use `context.colors.*` — no direct `AppColors` imports outside `core/`

#### 5c — BuildContext Text Style Extension
- [ ] `core/utils/extensions.dart` — add text style extension on `BuildContext`:
  ```dart
  extension AppTextStylesExtension on BuildContext {
    TextStyle get displayLarge   => Theme.of(this).textTheme.displayLarge!;
    TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
    TextStyle get titleLarge     => Theme.of(this).textTheme.titleLarge!;
    TextStyle get bodyLarge      => Theme.of(this).textTheme.bodyLarge!;
    TextStyle get bodyMedium     => Theme.of(this).textTheme.bodyMedium!;
    TextStyle get labelSmall     => Theme.of(this).textTheme.labelSmall!;
  }
  ```
  - **Usage in any feature:** `context.headlineMedium` — never `AppTextStyles.headlineMedium` directly
  - All styles are already registered in `ThemeData` in Phase 1 — extensions just expose them via context

#### 5d — Other BuildContext Utilities
- [ ] `core/utils/extensions.dart` — add remaining utilities:
  ```dart
  extension BuildContextExtension on BuildContext {
    void showSnackBar(String message) { ... }
    double get screenWidth  => MediaQuery.of(this).size.width;
    double get screenHeight => MediaQuery.of(this).size.height;
  }

  extension StringExtension on String {
    String get capitalize => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
  ```

#### 5e — Shared Widgets (strictly from Figma)
- [ ] `bridge_app_button.dart` — primary and secondary variants from Figma:
  - Uses `context.colors.primary` and `context.bodyLarge` — no direct imports
  - Background: `context.colors.primary`, border radius: `12.r`, height: `52.h`
  - Loading state replaces label with `CircularProgressIndicator`
- [ ] `app_text_field.dart` — from Figma input style:
  - Fill: `context.colors.surface`, subtle border, radius: `12.r`
  - Padding: `16.w` horizontal, `14.h` vertical
  - Uses `context.bodyMedium` for text style
- [ ] `app_loading.dart` — centered `CircularProgressIndicator` using `context.colors.primary`
- [ ] `app_error_widget.dart` — error icon + message + retry (from Figma error/empty states)
- [ ] `app_avatar.dart` — `CachedNetworkImage` in circle, fallback to initials
- [ ] `core/utils/validators.dart` — email, password, required field validators
- [ ] `core/utils/date_formatter.dart` — format timestamps for messages and task due dates

> [!IMPORTANT]
> **Enforcement rule:** Every feature — without exception — accesses colors via `context.colors.*` and text styles via `context.headlineMedium` etc. No feature file may import `AppColors` or `AppTextStyles` directly. All design values flow through `BuildContext` extensions defined in `core/utils/extensions.dart`.

**Deliverable:** `BuildContext` color + text style extensions live in `core/`. Every future feature widget uses `context.colors.*` and `context.*TextStyle` — zero direct design class imports outside core.

---

### Phase 6 — Splash Screen
**Goal:** Branded splash screen that checks auth state and redirects.

> **Figma:** Centered logo on `#F9FAFB` background with app name "TeamUP"

- [ ] `features/auth/presentation/pages/splash_page.dart`
  - Display app logo from `assets/images/` centered on `AppColors.scaffoldBg`
  - App name text using `displayLarge` style, color `AppColors.primary`
  - Short delay (1.5s) then let `go_router` redirect handle navigation
  - No business logic in the page itself — redirect handled by router guard

**Deliverable:** Branded splash screen, auto-redirects via router.

---

### Phase 7 — Onboarding
**Goal:** 3-slide first-launch onboarding exactly as shown in Figma.

> **Figma:** Full-screen slides with illustration at top, title + subtitle below, dot indicators, Skip + Next buttons. Gradient from `#4A6CF7` → `#2D4B73` on some slides.

- [ ] `core/helper/cache/cache_helper.dart` — add `isFirstLaunch` flag
- [ ] `features/auth/presentation/pages/onboarding_page.dart`:
  - `PageView` with exactly 3 slides matching Figma content and illustrations
  - Dot page indicators matching Figma style
  - "Skip" button top-right (text style, `AppColors.textSecondary`)
  - "Next" button bottom — primary button style; last slide shows "Get Started"
  - On complete: write `isFirstLaunch = false`, navigate to `/login`
- [ ] `features/auth/presentation/widgets/onboarding_slide.dart`:
  - Illustration area (Lottie or image — matching Figma asset)
  - Title: `titleLarge` style
  - Subtitle: `bodyMedium`, `AppColors.textSecondary`

**Deliverable:** Onboarding runs once on first launch, matches Figma exactly.

---

### Phase 8 — Auth: Login
**Goal:** Login screen matching Figma design, connected to AuthBloc.

> **Figma:** "Welcome Back" heading, email + password fields, "Forgot Password?" link, primary CTA button, social login row (Google / GitHub / Apple icons), "Don't have an account? Register" link.

- [ ] **Domain**
  - `user_entity.dart` — `id`, `name`, `email`, `role`, `track`, `seniority`, `token`
  - `auth_repository.dart` (abstract) — `login` method
  - `login_usecase.dart` → `Either<Failure, UserEntity>`
- [ ] **Data**
  - `user_model.dart` — extends `UserEntity`, `fromJson` / `toJson`
  - `auth_remote_datasource.dart` — Dio call to login endpoint
  - `auth_local_datasource.dart` — save/read token via `CacheHelper`
  - `auth_repository_impl.dart`
- [ ] **Presentation**
  - `AuthBloc`: `LoginRequested` event → `AuthLoading`, `AuthSuccess(user)`, `AuthFailure(message)`
  - `login_page.dart` — matches Figma layout exactly:
    - `BlocConsumer`:
      - `listener`: navigate on `AuthSuccess`, show `SnackBar` on `AuthFailure`
      - `buildWhen: (previous, current) => current is AuthLoading` — only rebuild for button loading state
    - Email `AppTextField`, password `AppTextField` with eye toggle
    - Primary `AppButton` — shows loader when state is `AuthLoading`
    - Social login buttons — UI only (functionality in later phase)
  - Register all in `di.dart`

**Deliverable:** Login screen, Figma-accurate, connected to AuthBloc.

---

### Phase 9 — Auth: Register
**Goal:** Registration screen matching Figma.

> **Figma:** "Create Account" heading, name + email + password + confirm password fields, primary CTA, "Already have an account? Login" link.

- [ ] **Domain** — add `register` to `AuthRepository`, `RegisterUseCase`
- [ ] **Data** — `register(name, email, password)` in `AuthRemoteDataSource` + impl
- [ ] **Presentation**
  - Add `RegisterRequested` event to `AuthBloc`
  - `register_page.dart` — matches Figma layout:
    - 4 fields: full name, email, password, confirm password
    - Form validation using `validators.dart`
    - `buildWhen: (previous, current) => current is AuthLoading` — button state only
    - On `AuthSuccess` → navigate to `/otp`

**Deliverable:** Register screen, Figma-accurate.

---

### Phase 10 — Auth: OTP Verification
**Goal:** OTP verification screen matching Figma, with countdown resend.

> **Figma:** "Enter OTP" heading, subtitle with email masked, 6 individual digit boxes in a row, countdown timer, "Resend Code" text button.

- [ ] **Domain** — `VerifyOtpUseCase`, `ResendOtpUseCase`
- [ ] **Data** — add to `AuthRemoteDataSource` + impl
- [ ] **Presentation**
  - Add `OtpVerified`, `OtpResendRequested` events to `AuthBloc`
  - `otp_verification_page.dart` — matches Figma:
    - 6 individual `TextField` boxes with auto-focus and auto-advance
    - Timer: 60s countdown; when 0 → "Resend Code" button becomes active
    - `buildWhen`: only rebuild when state changes to `AuthLoading` (for verify button) or timer ticks (isolated `StatefulWidget`)
    - On `AuthSuccess` → navigate to `/profile-setup`

**Deliverable:** OTP screen with 6-box input and resend timer.

---

### Phase 11 — Auth: Forgot Password
**Goal:** Password recovery screen matching Figma.

> **Figma:** "Reset Password" heading, subtitle instruction, email field, "Send Reset Link" primary button, back arrow navigation.

- [ ] **Domain** — `ForgotPasswordUseCase`
- [ ] **Data** — add to `AuthRemoteDataSource`
- [ ] **Presentation**
  - Add `ForgotPasswordRequested` event to `AuthBloc`
  - `forgot_password_page.dart` — matches Figma layout
  - On success → show success message (Figma confirmation state)

**Deliverable:** Forgot password screen, Figma-accurate.

---

### Phase 12 — Auth: Profile Setup
**Goal:** Role/track/seniority selection screen matching Figma.

> **Figma:** Multi-step form with tap-to-select cards for each option. Step 1: role (Student / Supervisor / Company cards). Step 2: track (Frontend / Backend / Mobile / AI / Design). Step 3: seniority (Junior / Mid / Senior). Progress indicator at top.

- [ ] **Domain** — `SetupProfileUseCase` with `ProfileSetupParams(role, track, seniority)`
- [ ] **Data** — add to `AuthRemoteDataSource`, save role to `CacheHelper`
- [ ] **Presentation**
  - Add `ProfileSetupSubmitted` event to `AuthBloc`
  - `profile_setup_page.dart` — matches Figma multi-step layout:
    - Step progress indicator (top)
    - Selection cards styled per Figma (border highlight when selected, `AppColors.primary`)
    - "Continue" button navigates to next step
    - On final step submit → navigate to `/home`

**Deliverable:** Profile setup working, user role saved, redirected to home.

---

### Phase 13 — Main Shell & Bottom Navigation
**Goal:** App shell with bottom navigation bar matching Figma.

> **Figma:** Bottom nav with 4 tabs — Home, Chat, Projects, Profile. Active tab icon uses `AppColors.primary`, inactive uses `AppColors.textSecondary`. White background with top shadow.

- [ ] `features/home/presentation/pages/main_shell_page.dart`
  - `StatefulShellRoute` with 4 branches in `go_router`
  - Bottom nav: items, icons, and active/inactive colors exactly from Figma
  - Company role sees different tab label/icon for "Talent" browse
  - Tab state preserved — no rebuilds when switching tabs

**Deliverable:** App shell with Figma-accurate bottom navigation.

---

### Phase 14 — Home Dashboard
**Goal:** Home screen matching Figma dashboard design.

> **Figma:** Top greeting header with user avatar. Circular progress card (tasks completion %). AI insight card with text and icon. Weekly activity bar chart. Quick action buttons: "Join Team" and "Create Team".

- [ ] **Domain** — `ProductivityStatsEntity`, `AiInsightEntity`, `HomeRepository`, 2 use cases
- [ ] **Data** — models, datasource, repository impl
- [ ] **Presentation**
  - `HomeCubit` — states: `HomeLoading`, `HomeLoaded`, `HomeError`
  - `home_page.dart` — matches Figma layout exactly:
    - Greeting header with `AppAvatar`
    - Circular progress card: fl_chart `PieChart`, colors from Figma
    - AI insight card: bordered card, icon + insight text
    - Bar chart: fl_chart `BarChart` with `AppColors.primary` bars
    - Quick action buttons from Figma: "Join Team" + "Create Team"
    - `BlocBuilder(buildWhen: (p, c) => c is HomeLoaded || c is HomeError)` — shimmer shown during `HomeLoading` independently
    - Shimmer skeleton matching Figma card shapes during initial load

**Deliverable:** Home screen matching Figma exactly.

---

### Phase 15 — Teams: Discovery & Browse
**Goal:** Team discovery page matching Figma list design.

> **Figma:** Page title "Find a Team". Scrollable list of team cards — each card: team name, project category badge (pill chip), member avatar stack, AI match % badge, "Request to Join" outline button.

- [ ] **Domain** — `TeamEntity`, `TeamsRepository`, `GetRecommendedTeamsUseCase`
- [ ] **Data** — `TeamModel`, `TeamsRemoteDataSource`, `TeamsRepositoryImpl`
- [ ] **Presentation**
  - `TeamsBloc` — `LoadTeams` event → `TeamsLoading`, `TeamsLoaded`, `TeamsError`
  - `teams_discovery_page.dart` — scrollable list, matches Figma
  - `TeamCard` widget — matches Figma card design: white surface, `12.r` radius, soft shadow
  - `MemberAvatarStack` — overlapping `AppAvatar` widgets as in Figma
  - Shimmer skeleton matching Figma card shape
  - `buildWhen: (p, c) => c is TeamsLoaded || c is TeamsError`

**Deliverable:** Teams discovery page matching Figma.

---

### Phase 16 — Teams: AI Matching
**Goal:** AI matching animated screen matching Figma.

> **Figma:** Centered animated progress circle with % value. "Analyzing your skills..." subtitle text. Background gradient. Result card slides up with team name, score, "Accept" and "Skip" buttons.

- [ ] **Domain** — `GetAiMatchScoreUseCase`, `MatchResultEntity`
- [ ] **Data** — add to `TeamsRemoteDataSource`
- [ ] **Presentation**
  - `ai_matching_page.dart` — matches Figma animation screen:
    - Lottie animation while matching runs
    - Circular indicator using Figma gradient colors
    - Result card from Figma design

**Deliverable:** AI matching screen matching Figma.

---

### Phase 17 — Teams: Join & Create Team
**Goal:** Join request flow + create team form matching Figma.

> **Figma:** "Request to Join" bottom sheet/page with team details and confirm button. "Create Team" form: project name field, category selector, required skills chips, team size input.

- [ ] **Domain** — `RequestJoinTeamUseCase`, `CreateTeamUseCase`
- [ ] **Data** — add to `TeamsRemoteDataSource`
- [ ] **Presentation**
  - `TeamsBloc` — add `JoinTeamRequested`, `CreateTeamRequested` events
  - Join: bottom sheet matching Figma confirm design
  - `create_team_page.dart` — form matching Figma layout
  - Route guard: create team only for Supervisor role

**Deliverable:** Join request + create team functional.

---

### Phase 18 — Workspace: Projects List
**Goal:** Projects list page matching Figma.

> **Figma:** Page title "My Projects". TabBar: "Ongoing" / "Completed". Each project card: project name, color-coded status badge, team member avatars, role label (e.g. "Frontend Dev"), linear progress bar.

- [ ] **Domain** — `ProjectEntity`, `WorkspaceRepository`, `GetProjectsUseCase`
- [ ] **Data** — `ProjectModel`, `WorkspaceRemoteDataSource`, `WorkspaceRepositoryImpl`
- [ ] **Presentation**
  - `WorkspaceBloc` — `LoadProjects` event → `ProjectsLoading`, `ProjectsLoaded`, `ProjectsError`
  - `projects_list_page.dart` — matches Figma TabBar + list layout
  - `ProjectCard` — matches Figma card design exactly (status badge, progress bar, avatars)
  - Empty state: matches Figma "No Projects" illustration + CTA
  - Shimmer skeleton during load

**Deliverable:** Projects list matching Figma, with tab filter.

---

### Phase 19 — Workspace: Task Board
**Goal:** Task list per project matching Figma.

> **Figma:** Project detail page: project name header, team members strip, task list grouped by status. Task card: title, assignee avatar, priority indicator dot, due date, status chip.

- [ ] **Domain** — `TaskEntity`, `GetProjectTasksUseCase`, `UpdateTaskStatusUseCase`
- [ ] **Data** — `TaskModel`, add to `WorkspaceRemoteDataSource`
- [ ] **Presentation**
  - `WorkspaceBloc` — add `LoadTasks`, `UpdateTaskStatus` events
  - `project_detail_page.dart` — matches Figma layout
  - `TaskCard` — matches Figma task card design
  - `TaskStatusChip` — pill chip with Figma colors (ongoing/completed from color tokens)
  - `task_detail_page.dart` — full detail view matching Figma

**Deliverable:** Task board matching Figma.

---

### Phase 20 — Workspace: Create Task & Supervisor Settings
**Goal:** Create task form + supervisor settings panel matching Figma.

> **Figma:** Create Task form: title field, assignee picker (user avatars), priority selector (Low/Medium/High), date picker. Team Settings page: member list with remove option, "Danger Zone" section with red delete button and confirmation dialog.

- [ ] **Domain** — `CreateTaskUseCase`, `DeleteProjectUseCase`
- [ ] **Data** — add to `WorkspaceRemoteDataSource`
- [ ] **Presentation**
  - `create_task_page.dart` — matches Figma form exactly
  - `team_settings_page.dart` — matches Figma settings layout (Supervisor role only, route guarded)
  - Delete confirmation dialog — matches Figma dialog design

**Deliverable:** Task creation and supervisor settings panel.

---

### Phase 21 — Chat: List & Room (REST History)
**Goal:** Chat list page and chat room with message history, matching Figma.

> **Figma:** Chat list: rows with team avatar, team name, last message preview, timestamp. Chat room: messages list (sent=right blue bubble, received=left gray bubble), avatar beside received, timestamp below. Input bar: text field + send icon.

- [ ] **Domain** — `MessageEntity`, `ChatRepository`, `GetMessagesUseCase`
- [ ] **Data** — `MessageModel`, `ChatRemoteDataSource` (Dio), `ChatRepositoryImpl`
- [ ] **Presentation**
  - `ChatBloc` — `LoadMessages` event
  - `chat_list_page.dart` — matches Figma list design
  - `chat_room_page.dart` — `ListView.builder` reversed for bottom-up display
  - `MessageBubble` — matches Figma: sent (right, `AppColors.primary`), received (left, `AppColors.surface`)
  - `ChatInputBar` — matches Figma input bar design

**Deliverable:** Chat list and room with REST history, matching Figma.

---

### Phase 22 — Chat: Real-time WebSocket
**Goal:** Connect WebSocket for live messaging.

- [ ] **Data** — `ChatSocketDataSource` using `web_socket_channel`:
  - `connect(roomId)`, `disconnect()`, `sendMessage(text)`, `messagesStream` → `Stream<MessageEntity>`
  - `rxdart` for stream debounce / transformation
- [ ] **Domain** — `SendMessageUseCase`, `WatchMessagesUseCase` (returns `Stream`)
- [ ] **Presentation** — update `ChatBloc`:
  - `ConnectSocket`, `DisconnectSocket`, `SendMessage`, `MessageReceived` events
  - Subscribe in `ChatBloc` on `ConnectSocket` — listen to stream
  - `buildWhen: (p, c) => c is MessagesUpdated` — list rebuilds only when new message arrives
  - Send button uses `context.read<ChatBloc>().add(SendMessage(...))` — no page rebuild
  - Disconnect on page pop via `go_router` listener

**Deliverable:** Real-time bidirectional chat.

---

### Phase 23 — Chat: Rich Messages
**Goal:** Code snippets and file attachments in chat matching Figma.

> **Figma:** Code message bubble: dark background, monospace text, copy icon. File attachment: file icon + filename + size.

- [ ] `MessageEntity` — add `type` enum (text/code/file), `attachmentUrl`
- [ ] `CodeSnippetBubble` — matches Figma code bubble design
- [ ] `FileAttachmentWidget` — matches Figma file attachment design
- [ ] Update `ChatInputBar` — attachment icon → file picker (matches Figma icons)

**Deliverable:** Rich message types matching Figma.

---

### Phase 24 — Profile: View & Edit
**Goal:** User profile page matching Figma.

> **Figma:** Large avatar at top, name, role badge, track label, seniority label. Skills section with pill chips. Bio text section. Edit button (pencil icon top-right). Edit opens same page in edit mode with fields.

- [ ] **Domain** — `ProfileEntity`, `ProfileRepository`, `GetProfileUseCase`, `UpdateProfileUseCase`
- [ ] **Data** — `ProfileModel`, `ProfileRemoteDataSource`, `ProfileRepositoryImpl`
- [ ] **Presentation**
  - `ProfileCubit` — states: `ProfileLoading`, `ProfileLoaded`, `ProfileError`, `ProfileUpdating`
  - `profile_page.dart` — matches Figma profile layout exactly
  - `SkillChip` — pill chip matching Figma chip design
  - Edit mode — fields editable in-place or on separate page per Figma

**Deliverable:** Profile page matching Figma.

---

### Phase 25 — Profile: Portfolio
**Goal:** Portfolio section matching Figma.

> **Figma:** Portfolio cards: project name, role, impact metric (e.g. "Reduced load time by 40%"), star rating (peer rating), "Mentor Choice" badge (gold star icon). Detail page expands the card.

- [ ] **Domain** — `PortfolioItemEntity`, `GetPortfolioUseCase`
- [ ] **Data** — `PortfolioItemModel`, add to `ProfileRemoteDataSource`
- [ ] **Presentation**
  - `PortfolioCard` — matches Figma card design
  - `ImpactMetricCard` — matches Figma metric display
  - `PeerRatingWidget` — star row matching Figma rating stars
  - Mentor badge — matching Figma badge asset

**Deliverable:** Portfolio section matching Figma.

---

### Phase 26 — Notifications
**Goal:** Notification center matching Figma.

> **Figma:** Grouped list: "Today" / "Earlier" section headers. Notification row: icon by type (team invite = people icon, task = tick icon), title bold, body text, timestamp right-aligned. Unread dot indicator left. Badge count on bottom nav.

- [ ] **Domain** — `NotificationEntity`, `NotificationsRepository`, `GetNotificationsUseCase`, `MarkAsReadUseCase`
- [ ] **Data** — `NotificationModel`, `NotificationsRemoteDataSource`, `NotificationsRepositoryImpl`
- [ ] **Presentation**
  - `NotificationsCubit`
  - `notifications_page.dart` — grouped list matching Figma
  - `NotificationTile` — matches Figma row design
  - Unread badge on bottom nav tab icon
  - `buildWhen: (p, c) => c is NotificationsLoaded || c is UnreadCountChanged`

**Deliverable:** Notification center matching Figma.

---

### Phase 27 — Company Role: Talent Discovery
**Goal:** Company-specific screens matching Figma.

> **Figma:** Company dashboard: posted projects list, team stats. Talent browse page: filterable list of developer cards — avatar, name, top skills chips, completed projects count. Tap card → read-only profile page.

- [ ] **Domain** — `TalentEntity`, `CompanyRepository`, `GetTalentListUseCase`
- [ ] **Data** — `TalentModel`, `CompanyRemoteDataSource`, `CompanyRepositoryImpl`
- [ ] **Presentation**
  - `CompanyCubit`
  - `company_dashboard_page.dart` — matches Figma company dashboard
  - `talent_browse_page.dart` — matches Figma talent list design
  - `TalentCard` — matches Figma talent card
  - Route guard: Company role only

**Deliverable:** Company role fully functional, matching Figma.

---

## 📊 Phase Summary

| Phase | Name | Category |
|---|---|---|
| **0** | Packages Setup | Foundation |
| **1** | Design System & Theme | Foundation |
| **2** | Error Handling & UseCase Base | Foundation |
| **3** | Network Client (Dio) | Foundation |
| **4** | Router & DI Shell | Foundation |
| **5** | Shared Widgets | Foundation |
| **6** | Splash Screen | Auth |
| **7** | Onboarding | Auth |
| **8** | Login | Auth |
| **9** | Register | Auth |
| **10** | OTP Verification | Auth |
| **11** | Forgot Password | Auth |
| **12** | Profile Setup | Auth |
| **13** | Main Shell & Bottom Nav | Navigation |
| **14** | Home Dashboard | Home |
| **15** | Teams Discovery | Teams |
| **16** | AI Matching | Teams |
| **17** | Join & Create Team | Teams |
| **18** | Projects List | Workspace |
| **19** | Task Board | Workspace |
| **20** | Create Task & Supervisor Settings | Workspace |
| **21** | Chat History (REST) | Chat |
| **22** | Real-time WebSocket | Chat |
| **23** | Rich Messages | Chat |
| **24** | Profile View & Edit | Profile |
| **25** | Portfolio | Profile |
| **26** | Notifications | Notifications |
| **27** | Company Role | Company |

---

> **Total: 27 focused phases** — each independently deliverable and testable.
> **Rule: Every screen must match Figma exactly — no invented UI.**
> **Ready to execute starting from Phase 0.**
