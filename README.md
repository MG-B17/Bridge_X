# Bridge X
<!-- Add your banner image here -->
<!-- <img width="1024" alt="Bridge X Banner" src="YOUR_BANNER_URL" /> -->

## 📜 Description
Bridge X is a cross-platform mobile application built with Flutter that bridges the gap between academic education and the job market. It provides a realistic, collaborative training environment where students and early-career programmers can form or join multidisciplinary teams and work on real-world projects that simulate professional workplace conditions.

The platform features an AI-powered team matching engine that assembles balanced teams based on technical skills and experience, and a multi-layered evaluation system — **The Score™** — combining Self Evaluation, Peer Evaluation, and Automated Evaluation from GitHub activity and task completion metrics. Bridge X also includes integrated real-time chat, task management, gamification progression, and a comprehensive onboarding flow — all wrapped in a responsive design system with full light and dark mode support.

## 🎦 Video Demonstration
<!-- Add your demo video link here -->
<!-- 🎥 [Watch App Demo](YOUR_VIDEO_URL) -->

## 📱 Screenshots
<!-- Add your screenshots here -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->
<!-- ![Image](YOUR_SCREENSHOT_URL) -->

## 🚀 Features
- **AI-Powered Team Matching** — Intelligent algorithm that recommends the best teams based on skill coverage, experience fit, and team composition balance
- **The Score™ Evaluation System** — Multi-layered performance scoring through self-assessment, peer reviews, and automated GitHub activity analysis
- **Project & Task Management** — Full lifecycle management with assignments, due dates, priorities, tags, progress tracking, and team evaluation reports
- **Real-Time Team Chat** — WebSocket-powered messaging with file attachments and inline code snippets via Supabase Realtime
- **Gamification & Level Progression** — Track your growth from Beginner Silver to Senior tier with badges, stars, and detailed performance statistics
- **Secure Authentication** — Email/password login with OAuth support for Google, GitHub, and Facebook, plus email verification and password recovery
- **Push Notifications** — Instant alerts for task assignments, team invitations, and project updates via Firebase Cloud Messaging
- **Onboarding & Profile Setup** — Guided three-step carousel followed by track selection, skill tagging, and experience level configuration
- **Invitation & Join Request System** — Structured workflows for creating public/private teams, sending invitations, and managing join requests
- **Dark & Light Mode** — Dynamic adaptive theming engine with custom color palettes that persists user preference
- **Responsive Design** — Adaptive layouts across mobile, tablet, and web platforms using flutter_screenutil
- **Performance Analytics** — Visual charts displaying task statistics, productivity trends, and project progress

## 🔨 Technologies Used

| **Aspect** | **Details** |
|---|---|
| **Framework** | Flutter |
| **State Management** | flutter_bloc (Cubits) + ChangeNotifier |
| **Architecture** | Feature-first Clean Architecture (Data, Domain, Presentation layers) |
| **Navigation** | GoRouter (StatefulShellRoute — 4 persistent bottom tabs) |
| **Dependency Injection** | GetIt (service locator) |
| **HTTP Client** | Dio (interceptor pipeline: Connectivity → Auth → Logging → Retry → Refresh) |
| **Real-time Communication** | Supabase Realtime + WebSocket |
| **Backend API** | Laravel (RESTful) |
| **Push Notifications** | Firebase Cloud Messaging + flutter_local_notifications |
| **Local Storage** | sqflite + shared_preferences + flutter_secure_storage |
| **UI/UX Utilities** | flutter_screenutil, Lottie, flutter_svg, shimmer, skeletonizer, fl_chart, google_fonts |
| **Functional Logic** | dartz (Either/Failure/UseCase pattern) |
| **Media & File** | image_picker, file_picker, cached_network_image |
| **Testing** | bloc_test, mocktail, flutter_test |

## 📜 Summary of Architecture
The project follows a **Feature-first Clean Architecture** organized into a shared `core/` module and 14 independent feature modules. Each feature is divided into three layers:

- **Data Layer** — Remote data sources (Dio API client, Supabase) and local storage (sqflite, SharedPreferences) with repository implementations
- **Domain Layer** — Business entities, abstract repository contracts, and use cases that encapsulate all business logic
- **Presentation Layer** — Flutter widgets, pages, and Cubit state managers that reactively update the UI

The **Core module** provides shared infrastructure: dependency injection (GetIt with 80+ registrations), centralized routing (GoRouter with 56 routes and a navigation guard), networking (Dio interceptor pipeline), theming (dynamic light/dark with custom color scheme), a custom design system, and reusable utilities.

State management is handled by **flutter_bloc Cubits**, while a global `AppState` ChangeNotifier powers the authentication-aware navigation guard: `Splash → Onboarding → Login → Verify Email → Complete Profile → Home`.

## 🏡 Getting Started

### Prerequisites
Before you begin, ensure you have the following installed:
- **Flutter SDK** (^3.11.5) — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (^3.11.5) — Included with Flutter
- **Android Studio** or **VS Code** — Recommended IDEs
- **Firebase Project** — Required for push notifications
- **Supabase Project** — Required for real-time chat

## 🛠️ Installation

Follow these steps to set up the project locally:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/bridge_x.git
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`
   - Or use FlutterFire CLI: `flutterfire configure`

4. **Run the App**
   ```bash
   flutter run
   ```

> **Note:** The backend API and Supabase credentials are pre-configured for the development environment. For production, update the endpoints in `lib/core/network/api/` and Supabase configuration.
