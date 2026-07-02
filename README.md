# Bridge X
<img width="1024" alt="Bridge X Banner" src="YOUR_BANNER_URL" />

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)

## 📜 Description
Bridge X bridges the gap between academic education and the job market by providing a realistic, collaborative training environment. Students and early-career programmers can form or join multidisciplinary teams and work on real-world projects that simulate professional workplace conditions. The platform features an AI-powered team matching engine and **The Score™** evaluation system — combining Self Evaluation, Peer Evaluation, and Automated Evaluation from GitHub activity and task completion metrics.

## 📱 Screenshots
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->

## 🎦 Video Demonstration
<!-- 🎥 [Watch App Demo](YOUR_VIDEO_URL) -->

## 🚀 Features
- **AI-Powered Team Matching** — Intelligent algorithm that recommends the best teams based on skill coverage, experience fit, and team composition balance
- **The Score™ Evaluation System** — Multi-layered performance scoring through self-assessment, peer reviews, and automated GitHub activity analysis
- **Project & Task Management** — Full lifecycle management with assignments, due dates, priorities, tags, progress tracking, and team evaluation reports
- **Real-Time Team Chat** — WebSocket-powered messaging with file attachments and inline code snippets via Supabase Realtime
- **Level Progression System** — Track your growth from Beginner to Senior tiers with progress tracking, performance statistics, and a visual roadmap
- **Secure Authentication** — Email/password login with OAuth support for Google and GitHub, plus email verification and password recovery
- **Push Notifications** — Instant alerts for task assignments, team invitations, and project updates via Firebase Cloud Messaging
- **Onboarding & Profile Setup** — Guided three-step carousel followed by track selection, skill tagging, and experience level configuration
- **Invitation & Join Request System** — Structured workflows for creating public/private teams, sending invitations, and managing join requests
- **Responsive Design** — Adaptive layouts across mobile, tablet, and web platforms using flutter_screenutil
- **Performance Analytics** — Visual charts displaying task statistics, productivity trends, and project progress

## 📜 Architecture
The project follows a **Feature-first Clean Architecture** organized into a shared `core/` module and 14 independent feature modules. Each feature is divided into three layers:

```
lib/
├── core/                          # Shared infrastructure
│   ├── di/                        # Dependency injection (GetIt)
│   ├── network/                   # Dio client + interceptors
│   ├── navigation/                # GoRouter + NavigationGuard
│   ├── theme/                     # Custom color scheme & styles
│   ├── services/                  # Cache, secure storage, notifications
│   ├── error/                     # Failure hierarchy & error handling
│   ├── widget/                    # Reusable design system
│   └── ...
├── features/                      # 14 feature modules
│   ├── auth/                      # Authentication & onboarding
│   ├── dashboard/                 # Home screen & project progress
│   ├── matching/                  # AI team matching engine
│   ├── chat/                      # Real-time messaging
│   ├── notifications/             # Push & local notifications
│   ├── levels/                    # Rank progression system
│   ├── profile/                   # User profile & dashboard
│   ├── settings/                  # App settings & preferences
│   └── team_managment/            # Projects, tasks, teams, evaluation
└── main.dart
```

### Layer Breakdown
- **Data Layer** — Remote data sources (Dio API client, Supabase) and local storage (sqflite, SharedPreferences) with repository implementations
- **Domain Layer** — Business entities, abstract repository contracts, and use cases that encapsulate all business logic
- **Presentation Layer** — Flutter widgets, pages, and Cubit state managers that reactively update the UI

State management is handled by **flutter_bloc Cubits**, while a global `AppState` ChangeNotifier powers the authentication-aware navigation guard: `Splash → Onboarding → Login → Verify Email → Complete Profile → Home`.

## 🔨 Tech Stack

| **Aspect** | **Details** |
|---|---|
| **Framework** | Flutter |
| **State Management** | flutter_bloc (Cubits) + ChangeNotifier |
| **Architecture** | Feature-first Clean Architecture (Data, Domain, Presentation) |
| **Navigation** | GoRouter (StatefulShellRoute — 4 persistent bottom tabs) |
| **Dependency Injection** | GetIt (service locator, 80+ registrations) |
| **HTTP Client** | Dio (Connectivity → Auth → Logging → Retry → Refresh pipeline) |
| **Real-time** | Supabase Realtime + WebSocket |
| **Backend API** | Laravel (RESTful) |
| **Push Notifications** | Firebase Cloud Messaging + flutter_local_notifications |
| **Local Storage** | sqflite + shared_preferences + flutter_secure_storage |
| **UI Utilities** | flutter_screenutil, Lottie, flutter_svg, shimmer, skeletonizer, fl_chart, google_fonts |
| **Functional Logic** | dartz (Either/Failure/UseCase pattern) |
| **Media** | image_picker, file_picker, cached_network_image |
| **Testing** | bloc_test, mocktail, flutter_test |

## 📁 Project Structure
```
lib/
├── bridge_x.dart                  # App entry widget
├── main.dart                      # Entry point
├── firebase_options.dart          # Firebase config
├── core/
│   ├── animation/                 # Bottom nav animation & screen transitions
│   ├── constant/                  # Strings, validation messages, keys
│   ├── di/                        # GetIt DI container
│   ├── error/                     # Failures, exceptions, error handler
│   ├── extensions/                # BuildContext helpers
│   ├── init/                      # App initializer & global state
│   ├── navigation/                # GoRouter config (56 routes) + guard
│   ├── network/                   # ApiClient, endpoints, interceptors
│   ├── repository/                # Repository mixin
│   ├── services/                  # Cache, storage, notifications, supabase
│   ├── theme/                     # Colors, text styles, theme data
│   ├── usecase/                   # Abstract UseCase classes
│   ├── utils/                     # Validators, extensions, models
│   └── widget/                    # Buttons, inputs, layout, feedback, loading
└── features/
    ├── auth/                      # Login, register, verification, password reset
    ├── chat/                      # Real-time messaging (Supabase)
    ├── dashboard/                 # Home screen, project progress
    ├── invitaions/                # Invitations & join requests
    ├── layout/                    # Bottom nav shell (4 tabs)
    ├── levels/                    # Rank progression
    ├── matching/                  # AI team matching
    ├── notifications/             # Push notifications
    ├── onboarding/                # 3-step carousel
    ├── profile/                   # User profile & dashboard
    ├── settings/                  # App settings
    ├── splash/                    # Splash screen
    ├── team_managment/            # Projects, tasks, teams, evaluation, reports
    └── skills_and_experience/     # Skills & experience display
```

## 🧗 Challenges Solved

- **Designed a scalable Feature-first Clean Architecture** with 14 feature modules, each split into data/domain/presentation layers, enabling parallel development and long-term maintainability
- **Built a persistent multi-tab navigation system** using GoRouter's `StatefulShellRoute` that preserves tab state across 4 bottom tabs (Home, Chat, Projects, Profile) with animated show/hide
- **Implemented real-time messaging** with Supabase Realtime subscriptions, handling room membership, typing indicators, and message synchronization across devices
- **Created an AI-assisted team recommendation engine** that matches programmers based on skill coverage, experience, and team composition balance using backend-driven algorithms
- **Integrated Firebase Cloud Messaging with a Laravel backend**, managing push notification delivery across Android, iOS, Web, and Desktop with foreground/background/terminated state handling
- **Developed an 8-step NavigationGuard** that handles auth-aware redirects from splash through onboarding, login, email verification, profile completion, and finally to the home screen
- **Designed a custom theme system** with Material 3, Google Fonts integration, and a consistent color scheme managed through ThemeExtension

## 🛠️ Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/bridge_x.git

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## ⚙️ Configuration

### Firebase Setup
- Place `google-services.json` in `android/app/`
- Place `GoogleService-Info.plist` in `ios/Runner/`
- Or run `flutterfire configure` to auto-generate config

### Supabase Setup
- Update Supabase URL and anon key in `lib/core/services/supabase_service.dart`

### Environment
- Backend API is pre-configured at `https://teamwork2-production-ucr9dn.laravel.cloud/`
- Update endpoints in `lib/core/network/api/api_endpoint.dart` for production

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

Testing tools: `bloc_test`, `mocktail`, `flutter_test`

## 🗺️ Roadmap
- [ ] Complete OAuth implementation (Google, GitHub)
- [ ] Wire up dark mode support
- [ ] Expand AI matching with more granular skill categories
- [ ] Add CI/CD pipeline with GitHub Actions
- [ ] Increase test coverage
- [ ] Performance optimization for large datasets
- [ ] Localization (Arabic support)

## 🤝 Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

## 📄 License
This project is licensed under the MIT License.
