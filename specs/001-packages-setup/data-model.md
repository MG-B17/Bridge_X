# Data Model: Packages Setup

**Feature**: 001-packages-setup
**Date**: 2026-04-22

> This phase has no runtime data entities — it is purely a configuration phase.
> The "data model" here describes the structure of `pubspec.yaml` as the primary artifact.

## pubspec.yaml Structure

### Production Dependencies Block

All packages added under `dependencies:` in `pubspec.yaml`:

| Package | Version | Category | Purpose |
|---|---|---|---|
| `flutter_bloc` | `^8.1.6` | State Management | Bloc/Cubit pattern |
| `equatable` | `^2.0.5` | State Management | Value equality for states/entities |
| `go_router` | `^14.2.0` | Navigation | Declarative routing |
| `get_it` | `^8.0.2` | DI | Service locator |
| `dio` | `^5.6.0` | Network | HTTP client with interceptors |
| `pretty_dio_logger` | `^1.4.0` | Network | Debug request/response logging |
| `web_socket_channel` | `^3.0.1` | Real-time | WebSocket client for chat |
| `dartz` | `^0.10.1` | Error Handling | `Either<Failure, T>` functional types |
| `flutter_screenutil` | `^5.9.3` | UI | Responsive sizing units |
| `cached_network_image` | `^3.4.1` | UI | Network image with disk cache |
| `flutter_svg` | `^2.0.10+1` | UI | SVG asset rendering |
| `shimmer` | `^3.0.0` | UI | Skeleton loading animation |
| `lottie` | `^3.1.2` | UI | Lottie animation player |
| `fl_chart` | `^0.69.0` | UI | Charts for home dashboard |
| `google_fonts` | `^6.2.1` | UI | Inter font family |
| `shared_preferences` | `^2.3.2` | Storage | Auth token + first-launch flag |
| `sqflite` | `^2.3.3+1` | Storage | Relational local database |
| `path` | `^1.9.0` | Storage | File path utilities for sqflite |
| `image_picker` | `^1.1.2` | Media | Device image/camera picker |
| `file_picker` | `^8.1.2` | Media | Multi-type file picker |
| `path_provider` | `^2.1.4` | Media | App file system paths |
| `intl` | `^0.19.0` | Utility | Date formatting |
| `connectivity_plus` | `^6.0.5` | Utility | Network connectivity detection |
| `internet_connection_checker_plus` | `^2.5.1` | Utility | Active internet check |
| `rxdart` | `^0.28.0` | Utility | Reactive stream utilities |

### Dev Dependencies Block

All packages added under `dev_dependencies:` in `pubspec.yaml`:

| Package | Version | Purpose |
|---|---|---|
| `bloc_test` | `^9.1.7` | Unit testing for Bloc/Cubit |
| `mocktail` | `^1.0.4` | Mock objects for unit tests |
| `flutter_lints` | `^5.0.0` | ✅ Already present — no change needed |

### Flutter Assets Block

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/    ← ✅ Already registered
    - assets/svg/       ← ✅ Already registered
```

### SDK Constraint

```yaml
environment:
  sdk: ^3.9.2    ← ✅ Already correct — no change needed
```

## State Transitions (pubspec.yaml lifecycle)

```
[Current state]                      [Target state]
pubspec.yaml with only              pubspec.yaml with all
cupertino_icons + flutter_lints  →  27 production packages +
                                     3 dev packages declared
                                     ↓
                                    flutter pub get runs clean
                                     ↓
                                    .dart_tool/ lockfile updated
                                     ↓
                                    flutter analyze: 0 errors
```

## Validation Rules

- All 25 new production packages (excluding existing `cupertino_icons`) MUST be present
  under `dependencies:`.
- `bloc_test` and `mocktail` MUST be under `dev_dependencies:` only.
- `flutter_lints` MUST remain under `dev_dependencies:` (already there).
- No package MUST appear in both `dependencies:` and `dev_dependencies:`.
- No duplicate package declarations.
