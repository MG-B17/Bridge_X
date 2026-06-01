# Core Directory Documentation

**Root:** `lib/core/`

The `core` folder provides all shared infrastructure, utilities, widgets, and configuration used across feature modules. Feature-specific code lives under `lib/feature/` following Clean Architecture (data/domain/presentation).

---

## Directory Tree

```
lib/core/
├── animation/
│   ├── bottom_nav_bar_animation/
│   │   ├── controller/
│   │   │   ├── scroll_cubit.dart          # Cubit managing bottom-nav visibility on scroll
│   │   │   └── scroll_state.dart          # Immutable state with showNavbar bool
│   │   └── widget/
│   │       └── scroller_listener.dart      # Listens to ScrollController, calls show/hide on ScrollCubit
│   └── screen_transtion_animation/
│       ├── app_page_transition.dart        # Abstract strategy interface for GoRouter page transitions
│       └── transitions/
│           ├── fade_transition.dart        # FadeTransition (750ms)
│           ├── scale_transition.dart       # Scale + Fade combined (750ms)
│           ├── slide_right_trnasition.dart # Slide from right (750ms)
│           └── slide_up_transition.dart    # Bottom-sheet style slide up
├── constant/
│   ├── app_feedback_messages.dart          # User-facing feedback/snackbar message strings
│   ├── app_keys.dart                       # SharedPreferences/SecureStorage key constants
│   ├── app_validation_messages.dart        # Validation error message strings
│   └── bridge_x_strings.dart               # All user-facing UI strings (~457 lines)
├── di/
│   └── di.dart                             # Central DI wiring via GetIt (~80+ registrations)
├── error/
│   ├── cache_failure.dart                  # CacheFailure (message only)
│   ├── error_handler.dart                  # Maps DioException → typed Failure subclasses
│   ├── error_strings.dart                  # Generic error message constants
│   ├── exception.dart                      # ServerException, CacheException, NetworkException, AuthException
│   ├── failure.dart                        # Abstract Failure + AuthFailure, ValidationFailure; re-exports
│   ├── network_failure.dart                # NetworkFailure (message only)
│   ├── server_failure.dart                 # ServerFailure (message + optional statusCode)
│   └── unauthorized_failure.dart           # UnauthorizedFailure (default status 401)
├── extensions/
│   ├── context_extension.dart              # Barrel export of theme + media query extensions
│   ├── media_query_extension.dart          # BuildContext → screenWidth/Height, safeArea, padding
│   └── theme_extension.dart                # BuildContext → theme, textTheme, colors (AppColorScheme)
├── init/
│   ├── app_initializer_result.dart         # Data class: isLoggedIn, hasSeenOnboarding
│   ├── app_state.dart                      # ChangeNotifier global app state (ready, loggedIn, onboarding)
│   └── init_app.dart                       # Reads auth token + onboarding flag on startup
├── navigation/
│   ├── bridge_x_routes.dart                # Top-level GoRouter definition with StatefulShellRoute
│   ├── navigators_keys.dart                # GlobalKey<NavigatorState> for layout
│   ├── route_constant/
│   │   ├── bridege_x_route_names.dart      # Named route constants
│   │   └── bridge_x_route_paths.dart       # Route path constants
│   ├── routes/
│   │   ├── chat_route.dart                 # Chat shell branch routes
│   │   ├── forget_password_route.dart      # Forgot password flow chain
│   │   ├── home_route.dart                 # Home shell branch routes
│   │   ├── profile_route.dart              # Profile shell branch routes (nested)
│   │   ├── project_route.dart              # Projects shell branch routes
│   │   └── singup_route.dart               # Signup flow routes
│   ├── screens_args/
│   │   ├── notifications_details_args.dart # Notification detail screen args
│   │   ├── otp_args.dart                   # OTP screen args (email)
│   │   ├── project_dashboard_args.dart     # Project dashboard screen args (projectId)
│   │   ├── project_details_args.dart       # Project details screen args (projectId, status)
│   │   └── reset_password_args.dart        # Reset password screen args (email, token)
│   └── services/
│       └── navigation_guard_simple.dart    # Auth guard redirect logic
├── network/
│   ├── network_info.dart                   # Abstract + impl for connectivity check
│   ├── api/
│   │   ├── api_client.dart                 # Thin Dio wrapper (get/post/put/delete)
│   │   ├── api_endpoint.dart               # All API endpoint path constants
│   │   └── dio_factory.dart                # Dio instance factory (base URL, timeouts, headers)
│   └── interceptors/
│       ├── auth_interceptor.dart           # Attaches Bearer token to requests
│       ├── connectivity_interceptor.dart   # Checks connectivity before requests
│       ├── logging_interceptor.dart        # Logs request/response details
│       ├── refresh_token_interceptor.dart  # Placeholder for token refresh on 401
│       └── retry_interceptor.dart          # Retries on timeout (max 3, 1s delay)
├── services/
│   ├── app_lifecycle_service.dart          # Lifecycle observer with shutdown callbacks
│   ├── chache_service.dart                 # SharedPreferences wrapper (save/get/remove/clear)
│   ├── connectivity_service.dart           # Connectivity monitoring with error dialog
│   ├── local_data_service.dart             # Sqflite database service (placeholder)
│   ├── logger_service.dart                 # Structured logging via debugPrint
│   └── secure_storage_service.dart         # FlutterSecureStorage wrapper
├── theme/
│   ├── app_color_schema.dart               # AppColorScheme ThemeExtension (light + dark)
│   ├── bridge_x_colors.dart                # Raw color palette + named gradients
│   ├── bridge_x_text_styles.dart           # AppTextStyles (Google Fonts Inter, screenutil)
│   ├── bridge_x_theme.dart                 # Light + dark ThemeData with Material3
│   └── theme_controller.dart               # ThemeCubit persisting to SharedPreferences
├── usecase/
│   └── usecases.dart                       # Abstract UseCase<Output, Params> + NoParams
├── utils/
│   ├── app_gradient.dart                   # Named gradient presets + utility builders
│   ├── app_shadow.dart                     # BoxShadow presets for cards, nav, glow
│   ├── app_spacing.dart                    # Spacing/sizing/radius/duration constants (screenutil)
│   ├── extensions.dart                     # BuildContext extensions (duplicates extensions/ folder)
│   ├── validator.dart                      # Form validation methods
│   └── enum/
│       ├── auth_enum.dart                  # AuthAction, AuthStatus enums
│       ├── create_team_status_enum.dart    # CreateTeamStatus enum
│       ├── team_types_enum.dart            # TeamTypesEnum
│       └── track_experience_level_enum.dart# TrackExperienceLevel enum
└── widget/
    ├── buttons/
    │   ├── bridge_x_back_button.dart       # Circular back button with context.pop default
    │   ├── bridge_x_button.dart            # Full-width gradient primary button
    │   ├── bridge_x_outline_button.dart    # Full-width outlined button
    │   └── text_button.dart                # Simple text button
    ├── feedback/
    │   ├── bridge_x_error_widget.dart      # Full-page error screen with retry
    │   ├── bridge_x_snackbar.dart          # Styled snackbar (success/error/warning)
    │   ├── bridge_x_tip_banner.dart        # Tip/info banner widget
    │   ├── error_dialog.dart               # Error dialog + confirm dialog + ErrorSnackBar
    │   ├── loading_dialog.dart             # Lottie loading dialog (non-dismissible)
    │   └── success_dialog.dart             # Success dialog (mirrors error dialog structure)
    ├── inputs/
    │   └── bridge_x_text_form_field.dart   # Configurable text form field
    ├── layout/
    │   ├── bridge_x_background_gears.dart  # Decorative background watermark pattern
    │   ├── bridge_x_chip.dart              # Animated selectable chip/tag
    │   ├── bridge_x_divider.dart           # Themed divider
    │   ├── bridge_x_screen_header.dart     # Back button + title header row
    │   ├── horizontal_spacing.dart         # Responsive SizedBox width spacer
    │   ├── section_header.dart             # Section title + optional action label
    │   └── vertical_spacing.dart           # Responsive SizedBox height spacer
    └── loading/
        ├── bridge_x_refresh_indicator.dart # RefreshIndicator wrapper (transparent-safe)
        └── bridge_x_skeletonizer.dart      # Shimmer loading placeholder wrapper
```

---

## Key Architecture & Patterns

### Overall Architecture
- **Feature-first Clean Architecture**: Features under `lib/feature/` have `data/domain/presentation` layers. `core/` provides shared infrastructure consumed by all features.
- **Dependency Injection**: All wiring in `di/di.dart` using `GetIt`. The `sl` (service locator) instance is imported across the codebase. Singletons use `registerLazySingleton`; Cubits use `registerFactory`.

### State Management
- **Cubit** for feature-level state; **ChangeNotifier** (`AppState`) for global app state (auth readiness).
- `AppState` is attached to GoRouter as `refreshListenable` for navigation redirects.
- All state/entity classes extend `Equatable` for value equality.

### Navigation
- **GoRouter** with `StatefulShellRoute.indexedStack` for persistent bottom nav (4 tabs: Home, Chat, Projects, Profile).
- **Custom page transitions**: Abstract `AppPageTransition` strategy with implementations: `SlideRightTransitionPage`, `FadeTransitionPage`, `ScaleTransitionPage`, `SlideUpTransitionPage`.
- **Navigation guard**: `NavigationGuard.calculateRedirect()` implements auth flow logic (splash → onboarding → login → home).
- **Typed screen args**: Strongly-typed argument classes passed via `state.extra`.
- Route names and paths are separated into two constant files.

### Networking
- **Dio** with interceptor pipeline: Connectivity → Auth (Bearer token) → Logging → Retry (3x on timeout) → RefreshToken (placeholder).
- **Error handling**: `ErrorHandler.map(DioException)` → typed `Failure` subclasses (Auth, Validation, Server, Network, Cache).
- API endpoints centralized in `ApiEndpoint` as static strings.

### Error Handling Strategy
- Two-tier: `Exception` classes (for throwing) ↔ `Failure` classes (for returning via `Either`).
- `ErrorHandler` bridges Dio exceptions to domain failures.
- Use cases return `Either<Failure, Output>` using the `dartz` package.

### Theming
- **AppColorScheme**: Custom `ThemeExtension<AppColorScheme>` with full light + dark design tokens (brand, surfaces, text, semantic, section accents, status tags).
- **AppColors**: Raw color palette with named section gradients.
- **AppTextStyles**: Named text styles via `GoogleFonts.inter` + `flutter_screenutil` responsive sizing.
- **ThemeCubit**: Persists light/dark/system choice to SharedPreferences.

### Widget Design System
- **Naming**: All custom widgets prefixed `BridgeX...`.
- **Fully parameterized**: Named parameters with theme defaults; no hardcoded values.
- **Loading states**: `BridgeXSkeletonizer` (shimmer), `BridgeXRefreshIndicator`, loading state in buttons.
- **Feedback widgets**: Snackbar (3 variants), Error/Success dialog, Loading dialog (Lottie), Error page, Tip banner.

### Utility Classes
- `AppSpacing` — central design token file with spacing/sizing/radius/duration constants via `flutter_screenutil`.
- `AppShadow` — composable BoxShadow presets for cards, nav, glow effects.
- `AppGradient` — named gradient presets and utility builders.
- `AppValidator` — form validation (email, password, phone, name, URL, OTP, etc.).

### Known Dupes & Typos
- `utils/extensions.dart` duplicates `extensions/theme_extension.dart` + `extensions/media_query_extension.dart` (both provide `BuildContext` extensions).
- Filename typo: `slide_right_trnasition.dart` (trnasition → transition).
- Class name typo: `BridegeXRouteNames` (BridegeX → BridgeX).
- Filename typo: `chache_service.dart` (chache → cache).

### Placeholders
- `RefreshTokenInterceptor`: No token refresh logic yet.
- `LocalDataService._onCreate` / `_onUpgrade`: Empty placeholders.
- `DioFactory.createSecureDio()`: Not currently used.
- Several route screens have placeholder `Scaffold(body: Center(child: Text(...)))` widgets.

### External Packages Used
`dio` · `flutter_bloc` / `bloc` · `get_it` · `go_router` · `equatable` · `dartz` · `flutter_secure_storage` · `shared_preferences` · `internet_connection_checker_plus` · `flutter_screenutil` · `google_fonts` · `skeletonizer` · `lottie` · `sqflite` / `path`
