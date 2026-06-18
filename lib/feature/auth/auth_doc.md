# Auth Feature — Technical Documentation

> **Feature:** Authentication & Onboarding  
> **Entry Screens:** `LoginScreen`, `RegisterScreen`, `ForgetPasswordScreen`, `VerifyEmailScreen`, `VerifyPasswordScreen`, `ResetPasswordScreen`, `CompleteProfileScreen`  
> **Entry point:** The login screen is the app's entry point when no session token exists; all other auth screens are reached via navigation or redirect.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Screens & Navigation Flow](#3-screens--navigation-flow)
4. [Data Models & API Contracts](#4-data-models--api-contracts)
5. [State Machines](#5-state-machines)
6. [Data Flow](#6-data-flow)
7. [Cubit Breakdown](#7-cubit-breakdown)
8. [Widget Trees](#8-widget-trees)
9. [Widget Breakdown](#9-widget-breakdown)
10. [Edge Cases & Logic Rules](#10-edge-cases--logic-rules)
11. [Dependency Injection](#11-dependency-injection)
12. [File Map](#12-file-map)

---

## 1. Overview

The Auth feature handles all authentication-related flows:

- **Login** — Email/password sign-in with FCM token, password visibility toggle, forgot-password link
- **Registration** — Name/email/password sign-up with terms agreement, confirm password
- **Email Verification** — 6-digit OTP verification after registration, resend code
- **Password Reset** — 3-step flow: enter email → verify OTP → set new password
- **Complete Profile** — Post-registration onboarding: select track (7 options), choose experience level (4 levels), confirm with quote

### Auth Flows at a Glance

```
                    ┌──────────────┐
                    │   App Start  │
                    └──────┬───────┘
                           ▼
                   ┌───────────────┐
            ┌──────│  LoginScreen  │──────┐
            │      └───────┬───────┘      │
            │              │ login        │ "Don't have an account?"
            ▼              ▼              ▼
    ┌────────────┐  ┌───────────┐  ┌──────────────┐
    │ForgetPass   │  │  Guard    │  │RegisterScreen │
    │Screen       │  │  checks   │  └───────┬───────┘
    └──────┬──────┘  │ isVerified│          │ register
           │ email   │(API resp) │          ▼
           ▼         └─────┬─────┘  ┌────────────────┐
    ┌──────────────┐  ┌────┴────┐   │VerifyEmailScreen│
    │VerifyPassword│ YES       NO   └───────┬────────┘
    │Screen        │  │         │           │ verify success
    └──────┬───────┘  │         ▼           ▼
           │ verify   │  ┌──────────────────┐
           ▼ success  │  │ CompleteProfile  │
    ┌──────────────┐  │  │ Screen           │
    │ResetPassword │  │  │ (track select)   │
    │Screen        │  │  └────────┬─────────┘
    └──────┬───────┘  │           │ submit success
           │ success  │           ▼
           ▼          │  ┌──────────────────┐
    ┌──────────────┐  │  │ Guard checks     │
    │  LoginScreen │  │  │ username == null  │
    └──────────────┘  │  │ (API resp)        │
                      │  └─────┬─────┬──────┘
                      │      YES      NO
                      │        │       │
                      │        ▼       ▼
                      │  ┌────────┐ ┌──────┐
                      │  │Update  │ │ Home │
                      │  │Profile │ │      │
                      │  │Screen  │ └──────┘
                      │  └───┬────┘
                      │      │ save
                      │      ▼
                      │  ┌──────┐
                      │  │ Home │
                      │  │      │
                      │  └──────┘
```

---

## 2. Architecture

The feature follows **Clean Architecture** with strict layer separation:

```
Presentation  →  Domain  →  Data
(Cubit/UI)       (UseCases/Entities)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|---|
| **Presentation** | UI rendering, state management via 5 cubits: `LoginCubit`, `RegisterCubit`, `PasswordResetCubit`, `VerificationCubit`, `CompleteProfileCubit` |
| **Domain** | Business rules via use cases, pure Dart entities (no serialization, no Flutter imports) |
| **Data** | API calls (Dio), JSON parsing, local session storage (SecureStorage + CacheService) |

### Key Design Decisions
- **Domain entities are pure Dart** — no `toJson()`, no serialization. Mapping to/from models happens at the repository boundary and in remote data source.
- **Cubits are single-responsibility** — each auth flow (login, register, password reset, verification) gets its own cubit; no monolithic `AuthCubit`.
- **OTP form is cubit-agnostic** — `OtpForm` accepts a callback (`onVerify`) and is reused by both `VerificationCubit` (email verify) and `PasswordResetCubit` (password verify).
- **All hardcoded values centralized** — strings in `AuthStrings`, spacing/sizing in `AppSpacing`, colors via `context.colors.*` (theme extension), track labels in `AuthTracks`.
- **`_rethrowOrServerException` helper** — 10× duplicated try/catch boilerplate extracted into a single private method on `AuthRemoteDataImpl`.

---

## 3. Screens & Navigation Flow

### Route Map

| Route Name | Screen | Args |
|---|---|---|
| `login` | `LoginScreen` | none |
| `signUp` | `RegisterScreen` | none |
| `forgotPassword` | `ForgetPasswordScreen` | none |
| `verifyPasswordCode` | `VerifyPasswordScreen` | `OtpArgs(email)` |
| `resetPassword` | `ResetPasswordScreen` | `ResetPasswordArgs(email, token)` |
| `verifyEmail` | `VerifyEmailScreen` | `OtpArgs(email)` |
| `completeProfile` | `CompleteProfileScreen` | none |
| `home` | `HomeScreen` (dashboard) | none |

### Navigation Guard

The `NavigationGuard` (`core/navigation/services/navigation_guard_simple.dart`) intercepts all route changes and redirects based on `AppState` flags derived from the **login API response**:

| Guard Condition | Redirect To | Source |
|---|---|---|
| `!isVerified` | `/complete-profile` | `is_verified` field in login API response |
| `isVerified && (username == null \|\| username.isEmpty)` | `/update-profile` | `user_name` field in login API response |
| `isVerified && username != null` | `/home` (from setup routes) | — |

The complete profile cubit sets `isVerified = true` and persists it. The update profile screen (`EditProfileScreen`) sets the username in `AppState` and persists it to secure storage.

### Navigation Flow by Use Case

#### Login → (Guard decides)
```
LoginScreen (email/password)
    │ login success → context.goNamed('home')
    ▼
NavigationGuard evaluates:
    ├── !isVerified   → /complete-profile (track selection)
    ├── !username     → /update-profile
    └── ready         → /home
```

#### Login → Forgot Password → Reset
```
LoginScreen
    │ tap "Forgot Password" → push 'forgotPassword'
    ▼
ForgetPasswordScreen (enter email)
    │ success → push 'verifyPasswordCode'
    ▼
VerifyPasswordScreen (enter OTP)
    │ success → push 'resetPassword'
    ▼
ResetPasswordScreen (new password + confirm)
    │ success → go 'login'
    ▼
LoginScreen
```

#### Register → Verify Email → Complete Profile → Update Profile
```
RegisterScreen (name, email, password, agree terms)
    │ register success → push 'verifyEmail'
    ▼
VerifyEmailScreen (enter OTP)
    │ verify success → go 'completeProfile'
    ▼
CompleteProfileScreen (select track + experience)
    │ submit success → sets isVerified=true → go 'updateProfile'
    ▼
EditProfileScreen (name + details, isSetupMode:true)
    │ save → sets username + isProfileComplete → go 'home'
    ▼
HomeScreen
```

---

## 4. Data Models & API Contracts

### API Endpoints

| Method | Endpoint | Used By |
|---|---|---|
| `POST` | `/api/login` | `LoginRemoteDataSource.login()` |
| `POST` | `/api/register` | `RegisterRemoteDataSource.register()` |
| `POST` | `/api/register/verify` | `VerifyEmailRemoteDataSource.verifyEmail()` |
| `POST` | `/api/register/resend-code` | `ResendVerificationRemoteDataSource.resendVerify()` |
| `POST` | `/api/register/complete-profile` | `CompleteProfileRemoteDataSource.completeProfile()` |
| `POST` | `/api/forgot-password` | `ForgetPasswordRemoteDataSource.forgetPassword()` |
| `POST` | `/api/reset-password/verify` | `VerifyPasswordRemoteDataSource.verifyPassword()` |
| `POST` | `/api/reset-password` | `ResetPasswordRemoteDataSource.resetPassword()` |
| `POST` | `/api/logout` | `LogoutRemoteDataSource.logout()` |
| `POST` | `/api/change-password` | `ChangePasswordRemoteDataSource.changePassword()` |

### Response JSON Structures

#### Login Response
```json
{
  "token": "jwt_token_here",
  "data": {
    "user": {
      "id": 1,
      "user_name": "Mostafa",
      "is_verified": true,
      "is_profile_complete": false
    }
  }
}
```

> The `LoginResponseModel.fromJson()` parser supports both wrapped (`{ "data": { "user": {...} } }`) and unwrapped shapes. `token` is read from the root; `userId`, `userName`, `isVerified`, `isProfileComplete` are read from `data.user` (with fallback to `data`).
>
> **These API fields are the source of truth for the navigation guard:**
> - `is_verified` — gates the `/complete-profile` route
> - `user_name` — gates the `/update-profile` route

#### Register / Generic Message Response
```json
{
  "message": "User registered successfully. Please verify your email."
}
```

#### Verify Password (Reset) Response
```json
{
  "message": "Code verified successfully",
  "reset_token": "abc123",
  "expires_at": "2026-06-19T00:00:00Z"
}
```

### Domain Entities

| Entity | Fields | Description |
|---|---|---|
| `LoginEntity` | `email`, `password`, `fcmToken?` | Input for login use case |
| `LoginResultEntity` | `token`, `userId`, `userName?`, `isVerified`, `isProfileComplete` | Result returned after successful login |
| `RegisterEntity` | `name`, `email`, `password`, `passwordConfirmation` | Input for register use case |
| `ForgetPasswordEntity` | `email` | Input for forget-password use case |
| `VerifyCodeEntity` | `email`, `code` | Input for both email verification and password OTP verification |
| `VerifyPasswordResultEntity` | `resetToken`, `message`, `expiresAt` | Result from password OTP verification |
| `ResetPasswordEntity` | `email`, `password`, `confirmPassword`, `resetToken` | Input for reset-password use case |

> All domain entities are **pure Dart classes** with no `toJson()` — serialization is handled exclusively by data-layer `Model` classes.

### Data Models

| Model | Maps From | Maps To | Additional Fields |
|---|---|---|---|
| `LoginModel` | `LoginEntity` | JSON | — |
| `LoginResponseModel` | JSON | `LoginResultEntity` | — |
| `RegisterModel` | `RegisterEntity` | JSON | — |
| `ForgetPasswordModel` | `ForgetPasswordEntity` | JSON | — |
| `VerifyCodeModel` | `VerifyCodeEntity` | JSON | — |
| `ResetPasswordModel` | `ResetPasswordEntity` | JSON | — |
| `ResetPasswordResponseModel` | JSON | `VerifyPasswordResultEntity` | — |
| `CompleteProfileRequestModel` | raw params | JSON | — |

---

## 5. State Machines

All cubits share a common `AuthStatus` enum:

```dart
enum AuthStatus { initial, loading, success, error }
```

### 5.1 LoginCubit

```
LoginCubit created
    │
    ▼
LoginState(status: initial, isPasswordVisible: false)
    │ login() called
    ▼
LoginState(status: loading)
    │ result
    ├── success →
    │   LoginState(status: success, message: 'Login successful!')
    │   └─► sets appState.isLoggedIn, .isVerified, .username, .isProfileComplete
    └── failure →
        LoginState(status: error, message: failure.message)
```

| Action | Transition |
|---|---|
| `login()` | initial → loading → (success \| error) |
| `togglePasswordVisibility()` | flips `isPasswordVisible` boolean |

### 5.2 RegisterCubit

```
RegisterCubit created
    │
RegisterState(status: initial, isPasswordVisible: false, isConfirmPasswordVisible: false, agreeTerms: false)
    │ register() called
    ▼
RegisterState(status: loading)
    │ result
    ├── success → RegisterState(status: success, message)
    └── failure → RegisterState(status: error, message)
```

| Action | Transition |
|---|---|
| `register()` | initial → loading → (success \| error) |
| `togglePasswordVisibility()` | flips `isPasswordVisible` |
| `toggleConfirmPasswordVisibility()` | flips `isConfirmPasswordVisible` |
| `toggleAgreeTerms(val)` | sets `agreeTerms` (defaults to `false` on `null`) |

### 5.3 PasswordResetCubit

This cubit manages a 3-step flow:

```
PasswordResetCubit created
    │
PasswordResetState(status: initial, resetToken: null, ...)
    │
    ├── forgetPassword(email) → loading → (success | error)
    │
    ├── verifyPassword(email, code) → loading → (success with resetToken | error)
    │         └─► on success: resetToken is stored in state for the next step
    │
    └── resetPassword(email, code, newPassword, confirmPassword) → loading → (success | error)
```

| Action | Transition |
|---|---|
| `forgetPassword()` | initial → loading → (success \| error) |
| `verifyPassword()` | initial → loading → (success + `resetToken` \| error) |
| `resetPassword()` | initial → loading → (success \| error) |
| `togglePasswordVisibility()` | flips `isPasswordVisible` |
| `toggleConfirmPasswordVisibility()` | flips `isConfirmPasswordVisible` |

> Note: `verifyPassword` and `resetPassword` both use `code` as parameter — the OTP code from the user. In `resetPassword`, `code` is passed as the `resetToken` to the API.

### 5.4 VerificationCubit

```
VerificationCubit created
    │
VerificationState(status: initial)
    │
    ├── verifyEmail(email, code) → loading → (success | error)
    └── resendVerify(email) → loading → (success | error)
```

### 5.5 CompleteProfileCubit

```
CompleteProfileCubit created
    │
CompleteProfileState(selectedTrackIndex: -1, selectedExperience: 'Junior', status: initial)
    │ selectTrack(index)
    ▼
CompleteProfileState(selectedTrackIndex: index)
    │ selectExperience(level)
    ▼
CompleteProfileState(selectedExperience: level)
    │ submitProfile()
    ▼
CompleteProfileState(status: loading)
    │ result
    ├── success → CompleteProfileState(status: success, message: 'Profile completed')
    └── failure → CompleteProfileState(status: error, message)
```

| Guard | Behavior |
|---|---|
| `selectedTrackIndex == -1` | `submitProfile()` returns early (no-op) |
| `status == loading` | `submitProfile()` returns early (prevents double-submit) |

---

## 6. Data Flow

### Login Flow

```
LoginForm user taps "Login"
    │
    └─► _onLoginTapped()
            │ validate form
            │
            └─► LoginCubit.login(email, password)
                    │
                    emit(LoginState.loading)
                    │
                    └─► LoginUsecase.call(loginEntity: LoginEntity(...))
                            │
                            └─► AuthRepoImplement.login(loginEntity)
                                    │
                               networkInfo.isConnected?
                                    │
                               ┌────┴────┐
                             YES         NO
                              │           │
                        authRemoteData   Left(NetworkFailure)
                        .login(entity)
                              │
                        LoginResponseModel
                              │
                     save token, userId, userName
                     to SecureStorage
                              │
                     return Right(LoginResultEntity)
                              │
                    └─► Fold: success → set AppState fields
                                    → emit(LoginState.success)
                              failure → emit(LoginState.error)
```

### Register → Verify → Complete-Profile Flow

```
RegisterForm submit
    │
    └─► RegisterCubit.register(entity)
            │ success → navigate to VerifyEmailScreen
            ▼
    VerifyEmailScreen
        │ OtpForm.onVerify(code)
        │
        └─► VerificationCubit.verifyEmail(email, code)
                │ success → navigate to CompleteProfileScreen
                ▼
        CompleteProfileScreen
            │ selectTrack(index), selectExperience(level)
            │ submitProfile()
            │
            └─► CompleteProfileCubit.submitProfile()
                    │
                    └─► AuthRepoImplement.completeProfile(track, experienceLevel)
                            │
                            └─► AuthRemoteDataImpl.completeProfile(model)
                                    │ POST /api/register/complete-profile
                                    │
                                    └─► on fold success:
                                            sets appState.isVerified = true
                                            sets appState.trackSelectionCompleted = true
                                            persists isVerified + trackSelectionCompleted to SecureStorage
                                            emits success
                                            │
                                            └─► listener navigates to updateProfile
```

### Password Reset Flow (3 steps)

```
ForgetPasswordScreen
    │ email submitted
    └─► PasswordResetCubit.forgetPassword(email)
            │ success → push VerifyPasswordScreen
            ▼
    VerifyPasswordScreen
        │ OTP submitted
        └─► PasswordResetCubit.verifyPassword(email, code)
                │ success (resetToken stored in state) → push ResetPasswordScreen
                ▼
        ResetPasswordScreen
            │ new password + confirm submitted
            └─► PasswordResetCubit.resetPassword(email, code, password, confirm)
                    │ success → go to LoginScreen
```

### Logout Flow

```
Logout requested (from AccountCubit / profile settings)
    │
    └─► LogoutUseCase.call()
            │
            └─► AuthRepoImplement.logout()
                    │
               networkInfo.isConnected?
                    │
               ┌────┴────┐
             YES         NO
              │           │
        POST /api/logout  │
              │           │
         ┌────┴────┐      │
       success    fail    │
         │         │      │
         └────┬────┘      │
              │           │
         delete token,    │
         userId, userName │
         from SecureStore │
         clear Cache      │
              │           │
         return Right(null)
```

> **Design note:** Logout always clears local data even if the API call fails or the device is offline — this ensures the user is never stuck in a logged-in state.

---

## 7. Cubit Breakdown

### `LoginCubit`

| Aspect | Detail |
|---|---|
| **Dependencies** | `LoginUsecase`, `AppState`, `PushNotificationService` |
| **State** | `LoginState(status, message, isPasswordVisible)` |
| **Actions** | `login(email, password)`, `togglePasswordVisibility()` |
| **Side effects** | On success: sets `appState.isLoggedIn`, `isVerified`, `username`, `isProfileComplete` from API response fields (`is_verified`, `user_name`, `is_profile_complete`) |
| **File** | `presentation/controller/login/login_cubit.dart` |

### `RegisterCubit`

| Aspect | Detail |
|---|---|
| **Dependencies** | `RegisterUsecase` |
| **State** | `RegisterState(status, message, isPasswordVisible, isConfirmPasswordVisible, agreeTerms)` |
| **Actions** | `register(name, email, password, passwordConfirmation)`, `togglePasswordVisibility()`, `toggleConfirmPasswordVisibility()`, `toggleAgreeTerms(bool?)` |
| **File** | `presentation/controller/register/register_cubit.dart` |

### `PasswordResetCubit`

| Aspect | Detail |
|---|---|
| **Dependencies** | `ForgetPasswordUsecase`, `VerifyPasswordUsecase`, `ResetPasswordUsecase` |
| **State** | `PasswordResetState(status, message, resetToken?, isPasswordVisible, isConfirmPasswordVisible)` |
| **Actions** | `forgetPassword(email)`, `verifyPassword(email, code)`, `resetPassword(email, code, newPassword, passwordConfirmation)`, `togglePasswordVisibility()`, `toggleConfirmPasswordVisibility()` |
| **Token flow** | `verifyPassword()` stores `resetToken` in state; `resetPassword()` uses it as the `resetToken` parameter |
| **File** | `presentation/controller/password_reset/password_reset_cubit.dart` |

### `VerificationCubit`

| Aspect | Detail |
|---|---|
| **Dependencies** | `VerifyEmailUsecase`, `ResendVerifyUseCase` |
| **State** | `VerificationState(status, message)` |
| **Actions** | `verifyEmail(email, code)`, `resendVerify(email)` |
| **File** | `presentation/controller/verification/verification_cubit.dart` |

### `CompleteProfileCubit`

| Aspect | Detail |
|---|---|
| **Dependencies** | `CompleteProfileUseCase` |
| **State** | `CompleteProfileState(selectedTrackIndex, selectedExperience, status, message)` |
| **Actions** | `selectTrack(index)`, `selectExperience(level)`, `submitProfile()` |
| **Defaults** | `selectedTrackIndex = -1` (nothing selected), `selectedExperience = 'Junior'` |
| **Guard** | `submitProfile()` returns early if no track selected or already loading |
| **Side effects** | On success: sets `appState.isVerified = true`, `appState.trackSelectionCompleted = true`, persists both to SecureStorage |
| **File** | `presentation/controller/complete_profile/complete_profile_cubit.dart` |

### `AccountCubit` (separate — not in scope of this doc's refactor)

Handles `changePassword`, `logout`, `softDeleteProfile` — lives in `presentation/controller/account/`.

---

## 8. Widget Trees

### Login Screen

```
LoginScreen (StatelessWidget)
└── Scaffold
    └── SafeArea
        └── SingleChildScrollView
            └── Column
                ├── LoginHeader
                │   └── SvgPicture (app icon)
                └── AuthContainer
                    └── Column
                        ├── ScreenNameText ("Welcome Back")
                        ├── SubTitleText (subtitle)
                        ├── LoginForm
                        │   └── BlocListener<LoginCubit, LoginState>
                        │       └── Form
                        │           └── Column
                        │               ├── BridgeXTextFormField (email)
                        │               ├── BridgeXTextFormField (password + visibility toggle)
                        │               ├── "Forgot Password?" link
                        │               └── BridgeXButton (login)
                        ├── LoginDivider (BridgeXDivider + "or continue with")
                        ├── LoginSocialRow
                        │   └── Row
                        │       ├── SocialButton > GithubWidget
                        │       └── SocialButton > GoogleWidget
                        └── LoginFooter
                            └── AuthFooter ("Don't have an account? Sign Up")
```

### Register Screen

```
RegisterScreen (StatelessWidget)
└── Scaffold
    └── SafeArea
        └── SingleChildScrollView
            └── Column
                └── AuthContainer
                    └── Column
                        ├── ScreenNameText ("Create Account")
                        ├── RegisterForm
                        │   └── BlocListener<RegisterCubit, RegisterState>
                        │       └── Form
                        │           └── Column
                        │               ├── BridgeXTextFormField (name)
                        │               ├── BridgeXTextFormField (email)
                        │               ├── BridgeXTextFormField (password + visibility)
                        │               ├── BridgeXTextFormField (confirm password + visibility)
                        │               ├── Checkbox + Terms text
                        │               └── BridgeXButton (register)
                        ├── RegisterDivider
                        ├── RegisterSocialRow
                        └── RegisterFooter
                            └── AuthFooter ("Already have an account? Login")
```

### Forget Password Screen

```
ForgetPasswordScreen (StatelessWidget)
└── Scaffold
    └── SingleChildScrollView
        └── Column
            ├── SvgPicture (app icon)
            ├── ScreenNameText ("Reset Password")
            ├── SubTitleText (description)
            ├── ForgetPasswordForm
            │   └── Form
            │       └── Column
            │           ├── BridgeXTextFormField (email)
            │           └── BlocConsumer<PasswordResetCubit, PasswordResetState>
            │               └── BridgeXButton (send)
            └── "Back to Login" button
```

### Verify Screens (Email / Password)

```
VerifyEmailScreen / VerifyPasswordScreen
└── BlocConsumer<VerificationCubit|PasswordResetCubit, ...>
    └── Scaffold
        └── SafeArea
            └── Column
                ├── ScreenNameText ("Verify Code")
                ├── SubTitleText (description)
                └── OtpForm (cubit-agnostic, callback-based)
                    └── Form
                        └── Column
                            ├── OtpWidget (6× TextFormField)
                            ├── "Wrong email?" link (password verify only)
                            └── BridgeXButton (verify)
```

### Complete Profile Screen

```
CompleteProfileScreen (StatelessWidget)
└── BlocProvider<CompleteProfileCubit>
    └── BlocListener<CompleteProfileCubit, CompleteProfileState>
        └── PopScope
            └── Scaffold
                └── Stack
                    ├── _BackgroundDecoration (decorative SVG blobs)
                    └── SafeArea
                        └── SingleChildScrollView
                            └── Column
                                ├── ProfileSetupHeader
                                │   └── Text ("Set Up Your Profile")
                                ├── TrackSelectionGrid
                                │   └── BlocBuilder<CompleteProfileCubit, ...>
                                │       └── GridView.builder
                                │           └── _TrackCard (×7)
                                ├── ExperienceLevelSelector
                                │   └── BlocBuilder<CompleteProfileCubit, ...>
                                │       └── Row (4× experience level chips)
                                ├── ProfileQuote (inspirational quote)
                                └── BlocBuilder<CompleteProfileCubit, ...>
                                    └── "Continue" button (disabled until track selected)
```

---

## 9. Widget Breakdown

### Reusable Auth Widgets

#### `AuthContainer`
- **File:** `presentation/auth_widget/auth_container.dart`
- **Purpose:** Wraps screen content in a rounded white container with shadow — used by Login and Register screens
- **Visual:** `borderRadius: radiusPill + radius25`, `boxShadow` with primary color tint

#### `AuthFooter`
- **File:** `presentation/auth_widget/auth_footer.dart`
- **Inputs:** `prefixText`, `actionText`, `onActionTap`
- **Renders:** `RichText` with tappable action + Bridge X name SVG icon below

#### `ScreenNameText`
- **File:** `presentation/auth_widget/screen_name_text.dart`
- **Input:** `text: String`
- **Style:** `headlineSmall`, bold, `colors.secondary`

#### `SubTitleText`
- **File:** `presentation/auth_widget/sub_title_text.dart`
- **Input:** `text: String`
- **Style:** `bodyMedium`, `colors.textSecondary`, centered

#### `SocialButton`
- **File:** `presentation/auth_widget/social_button.dart`
- **Inputs:** `onTap`, `child`
- **Size:** `72.w` × `52.h`
- **Visual:** `BorderRadius.circular(radiusCard)`, subtle shadow, 1.2px secondary border

#### `GoogleWidget` / `GithubWidget`
- **Files:** `presentation/auth_widget/google_widget.dart`, `github_widget.dart`
- **Purpose:** Placeholder SVG widgets for social login buttons (TODO: implement actual OAuth)

### Screen-Specific Widgets

#### `LoginForm`
- **File:** `presentation/screens/login/widget/login_form.dart`
- **Behavior:** Dual `BlocBuilder` instances: one for password visibility toggle, one for loading state
- **Navigation:** "Forgot Password?" → `pushNamed('forgotPassword')`; success → `goNamed('home')`
- **Fields:** Email (validated), Password (validated, with visibility toggle)

#### `LoginHeader`
- **File:** `presentation/screens/login/widget/login_header.dart`
- **Renders:** SVG app icon at `logoWidth` × `logoHeight` with `headerTop` spacing

#### `LoginDivider` / `RegisterDivider`
- **File:** `presentation/screens/login/widget/login_divider.dart` / `register_divider.dart`
- **Renders:** `BridgeXDivider` + "or continue with" / "or sign up with" text

#### `RegisterForm`
- **File:** `presentation/screens/register/widget/register_form.dart`
- **Fields:** Name, Email, Password (with visibility), Confirm Password (with visibility), Terms checkbox
- **Behavior:** `toggleAgreeTerms` guards the register button; success → navigate to `verifyEmail`

#### `ForgetPasswordForm`
- **File:** `presentation/screens/forget_password/widgets/forget_password_form.dart`
- **Fields:** Email (validated)
- **Behavior:** On success → `pushNamed('verifyPasswordCode')` with `OtpArgs(email)`

#### `ResetPasswordForm`
- **File:** `presentation/screens/forget_password/widgets/reset_password_form.dart`
- **Fields:** New Password (with visibility toggle), Confirm Password (with visibility toggle)
- **Validation:** Password min-length info icon shown inline
- **Behavior:** On success → `goNamed('login')`

#### `OtpForm`
- **File:** `presentation/screens/verify_code/widget/otp_form.dart`
- **Purpose:** Cubit-agnostic — accepts `onVerify(String code)` callback
- **Behavior:** 6-digit OTP input via `OtpWidget`, "Wrong email?" link shown only for password verify flow
- **Verify button:** Enabled only when `_code.length == 6`

#### `OtpWidget`
- **File:** `presentation/screens/verify_code/widget/otp_widget.dart`
- **Behavior:** 6× `TextFormField` with auto-advance on input and auto-backspace on delete
- **Visual:** Each cell sized by `otpCellSize`, styled with `headlineMedium`, `fontSize24`
- **Input:** `FilteringTextInputFormatter.digitsOnly`, max 1 character

### Complete Profile Widgets

#### `ProfileSetupHeader`
- **File:** `presentation/screens/complete_profile/widget/profile_setup_header.dart`
- **Renders:** "Set Up Your Profile" title, "Help us find the right team for you." subtitle

#### `TrackSelectionGrid`
- **File:** `presentation/screens/complete_profile/widget/track_selection_grid.dart`
- **Data:** `AuthTracks.labels` (7 tracks), `_trackIcons` static icon map
- **Grid:** 3 columns, `GridView.builder`, `childAspectRatio: 0.82`
- **Selection:** Tracks selected track index via `CompleteProfileCubit.selectTrack()`

#### `_TrackCard`
- **File:** (private class in `track_selection_grid.dart`)
- **Visual:** Circular container with SVG background, icon overlay, selected state (primary border + glow + check badge)
- **Check badge:** 20×20 primary-colored circle with white checkmark icon, shown only when selected

#### `ExperienceLevelSelector`
- **File:** `presentation/screens/complete_profile/widget/experience_level_selector.dart`
- **Options:** Junior, Mid-Level, Senior, Lead (4 chips)
- **Behavior:** Each chip is a `GestureDetector` → `selectExperience()`; selected chip has primary border

#### `ProfileQuote`
- **File:** `presentation/screens/complete_profile/widget/profile_quote.dart`
- **Content:** `AuthStrings.quoteText` — static inspirational quote

---

## 10. Edge Cases & Logic Rules

### ✅ Login Success
1. `LoginCubit.login()` → API returns `LoginResponseModel` with token, userId, userName, isVerified, isProfileComplete
2. Token, userId, userName persisted to `SecureStorage`
3. `AppState` updated: `isLoggedIn=true`, `isVerified`, `username`, `isProfileComplete`
4. `LoginState.success` emitted → form listener navigates to `home`
5. NavigationGuard intercepts and redirects:
   - `!isVerified` → `/complete-profile`
   - `isVerified && !username` → `/update-profile`
   - `isVerified && username != null` → `/home`

### ✅ Login Fails — Server Error
1. `ServerException` caught → `ServerFailure` returned
2. `LoginState.error` emitted with `failure.message`
3. `ErrorDialog` shown via `BlocListener`

### ✅ Login Fails — Network Offline
1. `NetworkInfo.isConnected` returns `false`
2. `NetworkFailure` returned immediately (no API call)
3. Error message: "Please check your internet connection"

### ✅ Registration → Redirect to Verify
1. `RegisterCubit.register()` returns success string
2. Screen navigates to `verifyEmail` with `OtpArgs(email)`

### ✅ Email Verification Success
1. `VerificationCubit.verifyEmail()` returns success
2. Snackbar shown → navigates to `completeProfile`

### ✅ Password Reset — Full 3-Step Flow
1. Step 1: `forgetPassword()` sends email → navigates to OTP screen
2. Step 2: `verifyPassword()` validates OTP → stores `resetToken` in cubit state → navigates to reset form
3. Step 3: `resetPassword()` sends new password + `resetToken` → navigates to login

### ✅ Complete Profile — Track Required
- **Guard:** `submitProfile()` checks `selectedTrackIndex != -1` — returns early if no track selected
- **Guard:** `submitProfile()` checks `status != loading` — prevents double-submit
- **Experience defaults:** `selectedExperience = 'Junior'` is pre-selected
- **Side effect:** On API success, sets `appState.isVerified = true` and persists to SecureStorage — this allows the navigation guard to proceed past the `/complete-profile` gate

### ✅ Logout — Always Clears Local Data
- API call made first if online
- Regardless of API success/failure: token, userId, userName deleted from `SecureStorage`, cache cleared
- Even when offline: local data is cleared and `Right(null)` returned

### ❌ Full Error — No Network, No Session
- Attempt to load or submit any API-calling action without internet
- `NetworkFailure` returned with "Please check your internet connection"

### 🔒 Password Visibility Toggle (All Forms)
- Each cubit tracks its own `isPasswordVisible` / `isConfirmPasswordVisible` state
- Toggled via a dedicated method per visibility field
- UI renders visibility/visibility_off icon accordingly

### 📋 Terms Agreement (Register)
- `toggleAgreeTerms(bool?)`: defaults to `false` on `null` input
- Checkbox state drives no additional guard in the cubit (enforced by form)

### ✅ Update Profile — Username Required
- **Gate:** The navigation guard checks `appState.username == null` (from login API `user_name` field) to decide if `/update-profile` is needed
- **Side effect:** On save, `EditProfileScreen` sets `appState.username` and persists to SecureStorage via `AppKeys.userName`
- **Flow:** `isVerified && !username` → `/update-profile` → save → `isVerified && username != null` → `/home`

### 🔄 Resend Verification
- `VerificationCubit.resendVerify(email)` triggers a fresh API call
- Follows the same loading → (success | error) state machine as verify

### 🎯 Complete Profile — Experience Level
- Default experience is `'Junior'` (pre-selected)
- Selected experience is lowercased before being sent to API (`selectedExperience.toLowerCase()`)
- 4 options: Junior, Mid-Level, Senior, Lead

### 🚫 Complete Profile — Load Guard
- `submitProfile()` checks `status == AuthStatus.loading` and returns early if already loading

---

## 11. Dependency Injection

All registrations are in `auth_injection.dart`, called at app startup via `initAuth()`.

### Use Cases
All use cases are `registerLazySingleton` (shared instance).

| Type | Scoped As |
|---|---|
| `LoginUsecase` | `registerLazySingleton` |
| `RegisterUsecase` | `registerLazySingleton` |
| `ForgetPasswordUsecase` | `registerLazySingleton` |
| `VerifyPasswordUsecase` | `registerLazySingleton` |
| `ResetPasswordUsecase` | `registerLazySingleton` |
| `VerifyEmailUsecase` | `registerLazySingleton` |
| `ResendVerifyUseCase` | `registerLazySingleton` |
| `CompleteProfileUseCase` | `registerLazySingleton` |
| `ChangePasswordUsecase` | `registerLazySingleton` |
| `LogoutUseCase` | `registerLazySingleton` |

### Data Layer
| Type | Scoped As |
|---|---|
| `AuthRepo` → `AuthRepoImplement` | `registerLazySingleton` |
| `AuthRemoteData` → `AuthRemoteDataImpl` | `registerLazySingleton` |
| `AuthLocalDataSource` → `AuthLocalDataSourceImpl` | `registerLazySingleton` |

### Cubits
All cubits are `registerFactory` (new instance per `BlocProvider`).

| Type | Scoped As |
|---|---|
| `LoginCubit` | `registerFactory` |
| `RegisterCubit` | `registerFactory` |
| `PasswordResetCubit` | `registerFactory` |
| `VerificationCubit` | `registerFactory` |
| `CompleteProfileCubit` | `registerFactory` (created inline in `CompleteProfileScreen`) |
| `AccountCubit` | `registerFactory` |

> Cubits are `registerFactory` (not singleton) because each screen needs a fresh cubit instance when mounted.

---

## 12. File Map

```
lib/feature/auth/
│
├── auth_doc.md                                             # This document
│
├── di/
│   └── auth_injection.dart                                 # DI wiring (10 use cases, 1 repo, 2 data sources, 6 cubits)
│
├── utils/
│   ├── auth_enum.dart                                      # AuthAction (12 actions), AuthStatus (4 states)
│   ├── auth_strings.dart                                   # 5 centralized string constants
│   └── auth_tracks.dart                                    # Track labels (7 tracks) + count
│
├── domain/
│   ├── repo/
│   │   └── auth_repo.dart                                  # Abstract contract (10 methods)
│   ├── usecases/
│   │   ├── login_usecase.dart
│   │   ├── register_usecase.dart
│   │   ├── forget_password_usecase.dart
│   │   ├── reset_password_usecase.dart
│   │   ├── change_password_usecase.dart
│   │   ├── verify_email_usecase.dart
│   │   ├── verify_password_usecase.dart
│   │   ├── resend_verify_usecase.dart
│   │   ├── complete_profile_usecase.dart
│   │   └── logout_usecase.dart
│   └── entity/
│       ├── login_entity/
│       │   ├── login_entity.dart                           # email, password, fcmToken?
│       │   └── login_result_entity.dart                    # token, userId, userName?, isVerified, isProfileComplete
│       ├── register_entity/
│       │   └── register_entity.dart                        # name, email, password, passwordConfirmation
│       ├── forget_password_entity/
│       │   └── forget_password_entity.dart                 # email
│       ├── reset_password_entity/
│       │   └── reset_password_entity.dart                  # email, password, confirmPassword, resetToken
│       ├── change_password_entity/
│       │   └── change_password_entity.dart                 # currentPassword, newPassword, passwordConfirmation
│       ├── verify_code_entity.dart                         # email, code (shared by verifyEmail + verifyPassword)
│       └── verify_password_entity/
│           └── verify_password_result_entity.dart          # resetToken, message, expiresAt
│
├── data/
│   ├── models/
│   │   ├── login_models/
│   │   │   ├── login_model.dart                           # LoginEntity → JSON
│   │   │   └── login_response_model.dart                   # JSON → LoginResultEntity (supports wrapped/unwrapped)
│   │   ├── register_models/
│   │   │   └── register_model.dart                        # RegisterEntity → JSON
│   │   ├── forget_password_models/
│   │   │   └── forget_password_model.dart                 # ForgetPasswordEntity → JSON
│   │   ├── reset_password_models/
│   │   │   ├── reset_password_model.dart                  # ResetPasswordEntity → JSON
│   │   │   └── reset_password_response_model.dart         # JSON → VerifyPasswordResultEntity
│   │   ├── change_password_models/
│   │   │   └── change_password_model.dart                 # ChangePasswordEntity → JSON
│   │   ├── verify_code_model/
│   │   │   └── verify_code_model.dart                     # VerifyCodeEntity → JSON
│   │   └── complete_profile_models/
│   │       └── complete_profile_request_model.dart        # Raw params → JSON
│   ├── data_source/
│   │   ├── remote_data/
│   │   │   └── auth_remote_data.dart                      # Dio API calls + _rethrowOrServerException helper
│   │   └── local_data/
│   │       └── auth_local_data_source.dart                # clearSession() via SecureStorage + CacheService
│   └── repo_implement/
│       └── auth_repo_implement.dart                       # Orchestrates remote + local, maps models ↔ entities
│
└── presentation/
    ├── controller/
    │   ├── login/
    │   │   ├── login_cubit.dart                            # Login state machine + AppState side effects
    │   │   └── login_state.dart                            # status, message, isPasswordVisible
    │   ├── register/
    │   │   ├── register_cubit.dart                         # Register state machine + terms toggle
    │   │   └── register_state.dart                         # status, message, 2× visibility, agreeTerms
    │   ├── password_reset/
    │   │   ├── password_reset_cubit.dart                   # 3-step reset flow (forget → verify → reset)
    │   │   └── password_reset_state.dart                   # status, message, resetToken?, 2× visibility
    │   ├── verification/
    │   │   ├── verification_cubit.dart                     # verifyEmail + resendVerify
    │   │   └── verification_state.dart                     # status, message
    │   ├── complete_profile/
    │   │   ├── complete_profile_cubit.dart                 # track/experience selection + submit
    │   │   └── complete_profile_state.dart                 # selectedTrackIndex, selectedExperience, status, message
    │   └── account/
    │       ├── account_cubit.dart                          # changePassword, logout, softDeleteProfile (separate)
    │       └── account_state.dart
    ├── auth_widget/
    │   ├── auth_container.dart                             # Rounded white container with shadow
    │   ├── auth_footer.dart                                # RichText + app name SVG
    │   ├── screen_name_text.dart                           # Headline screen title
    │   ├── sub_title_text.dart                             # Subtitle description
    │   ├── social_button.dart                              # Social login button shell
    │   ├── google_widget.dart                              # Google SVG placeholder
    │   └── github_widget.dart                              # GitHub SVG placeholder
    └── screens/
        ├── login/
        │   ├── login_screen.dart                           # Root: header + container + form + divider + social + footer
        │   └── widget/
        │       ├── login_header.dart                       # App icon SVG
        │       ├── login_form.dart                         # Email/password form + forgot-password link
        │       ├── login_footer.dart                       # "Don't have an account? Sign Up"
        │       ├── login_divider.dart                      # "or continue with" divider
        │       └── login_social_row.dart                   # GitHub + Google buttons
        ├── register/
        │   ├── register_screen.dart                        # Root: container + form + divider + social + footer
        │   └── widget/
        │       ├── register_form.dart                      # Name/email/password/confirm/terms form
        │       ├── register_footer.dart                    # "Already have an account? Login"
        │       ├── register_divider.dart                   # "or sign up with" divider
        │       └── register_social_row.dart                # GitHub + Google buttons
        ├── verify_code/
        │   ├── screen/
        │   │   ├── verify_email_screen.dart                # BlocConsumer<VerificationCubit> + OtpForm
        │   │   └── verify_password_screen.dart             # BlocConsumer<PasswordResetCubit> + OtpForm
        │   └── widget/
        │       ├── otp_widget.dart                         # 6× auto-advance OTP TextFormField
        │       └── otp_form.dart                           # Cubit-agnostic form with onVerify callback
        ├── forget_password/
        │   ├── screens/
        │   │   ├── forget_password_screen.dart             # App icon + email form + back-to-login
        │   │   └── reset_password_screen.dart              # New password + confirm form
        │   └── widgets/
        │       ├── forget_password_form.dart               # Email input + submit (BlocConsumer)
        │       └── reset_password_form.dart                # Password/confirm + submit (BlocConsumer)
        └── complete_profile/
            ├── complete_profile_screen.dart                # Root: background blobs + header + grid + experience + quote + button
            └── widget/
                ├── profile_setup_header.dart               # Title + subtitle
                ├── track_selection_grid.dart               # 3-column grid of 7 _TrackCard widgets
                ├── experience_level_selector.dart          # 4 experience level chips
                └── profile_quote.dart                      # Static inspirational quote
```

---

## Test Coverage

All tests are in `test/feature/auth/`:

| Test File | Tests | What It Covers |
|---|---|---|
| `auth_repo_implement_test.dart` | 17 | All 9 repo methods + DioException handling + logout variants (online, offline, API fail) |
| `login_cubit_test.dart` | 6 | Login success/error, password toggle, null FCM token, null username + profile complete |
| `register_cubit_test.dart` | 8 | Register success/error, password/confirm visibility toggles, terms toggle (true/false/null), entity mapping |
| `password_reset_cubit_test.dart` | 11 | All 3 steps (forget/verify/reset) success + error, password/confirm visibility toggles, entity mapping |
| `verification_cubit_test.dart` | 6 | verifyEmail success + error + entity mapping, resendVerify success + error + entity mapping |

**Total: 46 tests — all passing.**
