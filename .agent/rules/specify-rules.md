# bridgex Development Guidelines

Auto-generated from all feature plans. Last updated: 2026-04-22

## Active Technologies

- Dart 3.x + pubspec.yaml (Flutter package manager — pub.dev) (001-packages-setup)
- flutter_screenutil ^5.9.3 + google_fonts ^6.2.1 + ThemeExtension (002-design-system-theme)

## Project Structure

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constant/
│   ├── theme/
│   ├── network/
│   ├── di/
│   ├── navigation/
│   ├── error/
│   ├── helper/
│   ├── usecases/
│   ├── utils/
│   └── widgets/
└── features/
    ├── auth/
    ├── home/
    ├── teams/
    ├── workspace/
    ├── chat/
    ├── profile/
    ├── notifications/
    └── company/

specs/
├── 001-packages-setup/
└── 002-design-system-theme/

assets/
├── fonts/       ← Inter-Regular.ttf, Inter-SemiBold.ttf, Inter-Bold.ttf
├── images/
└── svg/
```

## Commands

```bash
flutter pub get          # Install / update dependencies
flutter analyze          # Static analysis — must return zero errors
flutter test --coverage  # Run tests with coverage (≥85% required)
flutter run --debug      # Run app on connected device
```

## Code Style

- **Dart 3.x**: Use `sealed` classes for state hierarchies; prefer `required named` parameters
- All sizes use `flutter_screenutil` units (`.w`, `.h`, `.sp`, `.r`)
- All colors via `context.colors.*` — never hardcode hex values
- All text styles via `context.headlineMedium` etc. — never import `AppTextStyles` directly
- `go_router` only for navigation — `Navigator.push()` is forbidden
- `get_it` only for dependency injection — `new` only in `core/di/di.dart`
- Every use case returns `Either<Failure, T>` via `dartz`

## Recent Changes

- 002-design-system-theme: Added flutter_screenutil + google_fonts + ThemeExtension
- 001-packages-setup: Added Dart 3.x + pubspec.yaml (Flutter package manager — pub.dev)

<!-- MANUAL ADDITIONS START -->
<!-- MANUAL ADDITIONS END -->
