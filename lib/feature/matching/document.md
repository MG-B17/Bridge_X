# AI Team Matching Feature — Technical Documentation

> **Feature:** AI Team Matching  
> **Screen:** `MatchingProcessScreen`, `RecommendedTeamsScreen`, `NoTeamsFoundScreen`  
> **Entry point:** `SelectCategoryScreen` bottom sheet, then navigates to matching flow.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture](#2-architecture)
3. [Data Model & API Contract](#3-data-model--api-contract)
4. [State Machine](#4-state-machine)
5. [Data Flow](#5-data-flow)
6. [Caching Strategy](#6-caching-strategy)
7. [Widget Tree](#7-widget-tree)
8. [Widget Breakdown](#8-widget-breakdown)
9. [Edge Cases & Logic Rules](#9-edge-cases--logic-rules)
10. [Dependency Injection](#10-dependency-injection)
11. [File Map](#11-file-map)

---

## 1. Overview

The AI Team Matching feature finds optimal teams for the authenticated programmer based on their skills and preferences. It consists of a three-step flow:

1. **Category Selection** — the user picks interest areas (Development, Design, etc.)
2. **Matching Process** — a 4-second animated loading screen while the AI engine processes
3. **Result Screen** — shows recommended teams, an empty/no-teams state, or an error

All data is fetched from a remote API every time the screen opens. **No local cache** is used — every visit to the matching flow triggers a fresh API call.

---

## 2. Architecture

The feature follows **Clean Architecture** with strict layer separation:

```
Presentation  →  Domain  →  Data
(Cubit/UI)       (UseCases/Entities)   (Repository/Models/DataSources)
```

### Layers

| Layer | Responsibility |
|---|---|
| **Presentation** | UI rendering, animation, state management via `MatchingCubit` |
| **Domain** | Business rules via `GetAiMatchesUseCase`, pure `AiMatchEntity` |
| **Data** | API calls via `ApiClient`, JSON parsing, exception mapping |

### Key Design Decisions
- **No mock data** — all data flows from the backend API
- **No local cache** — each screen open fetches fresh data
- **`MatchingCubit` is a singleton** — shared between `MatchingProcessScreen` (triggers fetch) and `RecommendedTeamsScreen` (reads result)
- **4-second animation** plays regardless of API speed for visual polish; navigation only occurs after both animation completes and API has returned
- **`RepaintBoundary`** wraps the progress ring `CustomPaint` to isolate animation repaints

---

## 3. Data Model & API Contract

### API Endpoint
```
GET /api/ai/match-teams   (ApiEndpoint.aiMatchTeams)
```

### Response JSON Structure
```json
{
  "success": true,
  "message": "Teams matched and saved successfully.",
  "data": {
    "user_id": 15,
    "team_ids": [3],
    "recommendations": [
      {
        "team_id": 3,
        "team_name": "Team 1 for Task Management System",
        "matched_skills": [],
        "matched_skills_count": 0,
        "skill_coverage": 0,
        "missing_skills_count": 6,
        "team_vibe": "Junior Heavy",
        "chemistry_score": 0,
        "experience_fit_score": 50,
        "total_match_score": 13.12
      }
    ]
  }
}
```

> The `fromJson` parser unwraps `json['data']` and falls back to the raw JSON if `data` is absent.

### Entity: `AiMatchEntity`

| Field | Type | Description |
|---|---|---|
| `userId` | `int` | Authenticated user's ID |
| `teamIds` | `List<int>` | Flat list of matched team IDs |
| `recommendations` | `List<TeamRecommendationEntity>` | Detailed recommendation list |

### Entity: `TeamRecommendationEntity`

| Field | Type | Description |
|---|---|---|
| `teamId` | `int` | Unique team identifier |
| `teamName` | `String` | Displayed as the team card title |
| `matchedSkills` | `List<String>` | Rendered as tag chips on the card |
| `matchedSkillsCount` | `int` | Count of skills the user's profile matched |
| `skillCoverage` | `num` | 0–100, displayed as a score badge |
| `missingSkillsCount` | `int` | Skills the team needs but user lacks |
| `teamVibe` | `String` | Describes the team culture (e.g. "Junior Heavy") |
| `chemistryScore` | `num` | 0–100 compatibility score |
| `experienceFitScore` | `num` | 0–100 experience alignment score |
| `totalMatchScore` | `num` | 0–100 aggregated match score |

---

## 4. State Machine

The `MatchingCubit` emits the following states:

```
                   ┌─────────────────────────────────────────────┐
                   │           MatchingInitial                   │
                   │    (cubit created, no fetch yet)            │
                   └───────────────────────┬─────────────────────┘
                                           │ fetchMatches() called
                                           ▼
                   ┌─────────────────────────────────────────────┐
                   │           MatchingLoading                   │
                   │  (triggered from MatchingProcessScreen)     │
                   └──────┬──────────────────────────┬──────────┘
                          │ API success               │ API failure
                          ▼                            ▼
     ┌─────────────────────────────┐   ┌─────────────────────────────┐
     │       MatchingLoaded        │   │       MatchingError         │
     │  (contains AiMatchEntity)   │   │  (contains error message)   │
     └─────────────────────────────┘   └─────────────────────────────┘
              │                                    │
              ▼                                    ▼
     navigate to recommendedTeams         navigate to noTeamsFound
     (if recommendations not empty)                     
     navigate to noTeamsFound                          
     (if recommendations is empty)                     
```

### State Descriptions

| State | `data` | Skeletonizer | UI |
|---|---|---|---|
| `MatchingInitial` | `null` | ❌ (not shown) | Not displayed — navigation happens before |
| `MatchingLoading` | `null` | ❌ | `MatchingProcessScreen` with animated ring |
| `MatchingLoaded` | real data | ❌ | `RecommendedTeamsScreen` or `NoTeamsFoundScreen` |
| `MatchingError` | `null` | ❌ | `BridgeXErrorWidget` on recommended screen, or no-teams screen |

### Navigation Guard
Navigation from `MatchingProcessScreen` only fires **after both**:
1. The 4-second animation completes (`AnimationStatus.completed`)
2. The API call has returned (`_apiCompleted == true`)

This ensures the user always sees the full animation.

---

## 5. Data Flow

### Initial Load

```
SelectCategoryScreen
    │ "Start Matching"
    ▼
MatchingProcessScreen.initState()
    │
    ├──► sl<MatchingCubit>().fetchMatches()
    │       │
    │       emit(MatchingLoading)
    │       │
    │       └──► GetAiMatchesUseCase.call(NoParams)
    │               │
    │               └──► MatchingRepositoryImpl.getAiMatches()
    │                       │
    │                  networkInfo.isConnected?
    │                       │
    │                  ┌─────┴──────┐
    │                YES            NO
    │                  │             │
    │            remoteDataSource    │
    │            .getAiMatches()     │
    │                  │          Left(NetworkFailure)
    │             success?          │
    │          ┌─────┴──────┐       │
    │        YES            NO      │
    │          │             │       │
    │      emit(Loaded)   Left      │
    │                     (Failure) │
    │                        │      │
    │                    emit(Error) │
    │                        │      │
    │                        └──────┘
    │
    └──► AnimationController.forward() (4 seconds)
            │
            _onAnimationStatus(completed)
            │
            └──► _navigationCheck()
                    │
              if _apiCompleted && mounted
                    │
              ┌─────┴──────────┐
        Loaded + has data   Loaded(empty) / Error
              │                   │
              ▼                   ▼
     goNamed(recommended)  goNamed(noTeamsFound)
```

### Pull-to-Refresh (RecommendedTeamsScreen)

```
User pulls down
    │
    └─► cubit.refreshMatches()
            │
            emit(MatchingLoading)
            │
            └─► GetAiMatchesUseCase.call(NoParams)
                    │
                    result.fold(failure → emit(Error), data → emit(Loaded))
```

---

## 6. Caching Strategy

**No caching.** Every screen open always fetches fresh data from the API.

| Open Path | Behavior |
|---|---|
| SelectCategory → Start Matching → MatchingProcessScreen | Always calls `fetchMatches()` |
| NoTeamsFoundScreen → Retry Matching | Navigates to MatchingProcessScreen → calls `fetchMatches()` again |
| Pull-to-refresh on RecommendedTeamsScreen | Calls `refreshMatches()` → re-fetches |

When the user navigates away and comes back, the `MatchingCubit` singleton still holds the previous state. Calling `fetchMatches()` immediately emits `MatchingLoading`, so the UI always transitions to loading before showing results.

---

## 7. Widget Tree

```
SelectCategoryScreen (bottom sheet)
    │ "Start Matching"
    ▼
MatchingProcessScreen (StatefulWidget + TickerProvider)
└── BlocProvider.value(value: sl<MatchingCubit>())
    └── BlocListener<MatchingCubit, MatchingState>
        └── ScrollNavListener
            └── Scaffold
                └── SafeArea
                    └── SingleChildScrollView
                        └── Column
                            ├── BridgeXBackButton
                            ├── MatchingProcessTitle
                            ├── VerticalSpacing
                            ├── MatchingProgressRing (animated 0→100%)
                            ├── VerticalSpacing
                            ├── DynamicInsightCard
                            ├── VerticalSpacing
                            └── SkillScanSection (animated progress)

RecommendedTeamsScreen (StatefulWidget)
└── BlocProvider.value(value: sl<MatchingCubit>())
    └── ScrollNavListener
        └── Scaffold
            └── SafeArea
                └── BlocBuilder<MatchingCubit, MatchingState>
                    ├── [Loading/Initial] → BridgeXSkeletonizer
                    │                           └── skeleton layout
                    ├── [Loaded + empty] → NoTeamsIllustration + NoTeamsTitle
                    ├── [Error] → BridgeXErrorWidget
                    │                 └── "Try Again" → cubit.refreshMatches()
                    └── [Loaded + has data] → SingleChildScrollView
                                                  └── BridgeXRefreshIndicator
                                                      └── Column
                                                          ├── BridgeXBackButton → home
                                                          ├── SectionHeader
                                                          └── TeamCardsList
                                                              └── TeamCard (×N)
                                                                  ├── header (initials + name + vibe)
                                                                  ├── description
                                                                  ├── score badges (4)
                                                                  ├── matched skills (tags)
                                                                  └── members indicator + "Request to Join"
```

---

## 8. Widget Breakdown

### `MatchingProcessScreen`
- **File:** `presentation/screens/matching_process_screen.dart`
- **Type:** `StatefulWidget` + `SingleTickerProviderStateMixin`
- **Animation:** `AnimationController` (4s `easeInOut`), drives `_progress` 0.0→1.0
- **Init:** calls `sl<MatchingCubit>().fetchMatches()` and `_animationController.forward()` simultaneously
- **Navigation:** `_navigationCheck()` fires when `AnimationStatus.completed && _apiCompleted`
- **Back button:** pops to `selectCategory` (default `BridgeXBackButton` behavior)

### `MatchingProgressRing`
- **File:** `presentation/widgets/matching_process_widgets/matching_progress_ring.dart`
- **Input:** `percentage: double` (0–100), `label: String`
- **Painter:** `_RingPainter` uses `SweepGradient` with `teal → primary` gradient
- **Safety:** When `progress <= 0`, the progress arc is **not painted** to avoid `SweepGradient` assertion (`endAngle` must be > `startAngle`)
- **Performance:** Wrapped in `RepaintBoundary` to isolate animation repaints

### `SkillScanSection`
- **File:** `presentation/widgets/matching_process_widgets/skill_scan_section.dart`
- **Input:** `progress: double` (0.0–1.0)
- **Progress bar:** `FractionallySizedBox` width scales linearly with progress
- **Verification steps:**
  - Skills Verified — completes at `progress >= 0.15`
  - Experience Analyzed — completes at `progress >= 0.50`
  - Finalizing Shortlist — completes at `progress >= 0.85`
- **In-progress steps:** show a small `CircularProgressIndicator` in the check circle

### `RecommendedTeamsScreen`
- **File:** `presentation/screens/recommended_teams_screen.dart`
- **Back button:** All states navigate to `home` (dashboard) — not back through the matching flow
- **Loading state:** `BridgeXSkeletonizer` wrapping a skeleton layout with 3 placeholder cards
- **Error state:** `BridgeXErrorWidget` with message from cubit state; "Try Again" calls `refreshMatches()`
- **Empty state:** `NoTeamsIllustration` + `NoTeamsTitle` (reused from `no_teams_found_widgets`) + "Retry Matching" button
- **Loaded state:** `BridgeXRefreshIndicator` wrapping `TeamCardsList`

### `TeamCard`
- **File:** `presentation/widgets/recommended_teams_widgets/team_card.dart`
- **Legacy inputs:** `initials`, `name`, `category`, `description`, `tags`, `currentMembers`, `maxMembers`
- **AI fields (optional):** `teamVibe`, `totalMatchScore`, `chemistryScore`, `experienceFitScore`, `skillCoverage`, `matchedSkillsCount`, `missingSkillsCount`, `teamId`
- **Score badges:** 4 compact badges (`_ScoreBadge`) displayed below the description: Match, Chemistry, Exp Fit, Coverage
- **Vibe display:** `teamVibe` replaces `category` text when present

### `TeamCardsList`
- **File:** `presentation/widgets/recommended_teams_widgets/team_cards_list.dart`
- **Input:** `List<TeamRecommendationEntity>`
- **Mapping:**
  - `initials` ← first char of `teamName`
  - `name` ← `teamName`
  - `description` ← `'Matched based on your skills and experience. {vibe} vibe.'`
  - `tags` ← `matchedSkills`
  - `currentMembers` ← `matchedSkillsCount`
  - `maxMembers` ← `matchedSkillsCount + missingSkillsCount`
  - AI score fields ← mapped directly from entity

### `NoTeamsFoundScreen`
- **File:** `presentation/screens/no_teams_found_screen.dart`
- **Reached when:** API returns empty recommendations or error
- **Back button:** pops to `matchingProcess` (default behavior)
- **"Retry Matching":** navigates to `matchingProcess` → triggers `fetchMatches()` again
- **"Create Your Own Team":** navigates to `createTeam` route

---

## 9. Edge Cases & Logic Rules

### ✅ Normal Load (API Success → Has Recommendations)
1. `MatchingProcessScreen` shows 4-second animation
2. Animation completes, API has returned
3. Navigate to `RecommendedTeamsScreen` with `MatchingLoaded` state
4. `BlocBuilder` renders `TeamCardsList` with data

### ✅ Normal Load (API Success → Empty Recommendations)
1. Same animation flow
2. API returns `recommendations: []`
3. Navigate to `NoTeamsFoundScreen`
4. User can retry matching or create a team

### ❌ API Failure
1. `MatchingProcessScreen` animation plays
2. When animation completes and API has errored → navigate to `NoTeamsFoundScreen`
3. User can retry matching

### ❌ Error on RecommendedTeamsScreen (after successful navigation)
1. If user pulls to refresh and the refresh fails:
   - `MatchingError` emitted
   - `BlocBuilder` swaps `TeamCardsList` for `BridgeXErrorWidget`
2. "Try Again" button calls `cubit.refreshMatches()` → re-fetches

### 🔄 Pull-to-Refresh (Success)
1. `MatchingLoading` emitted
2. `BridgeXSkeletonizer` wraps `TeamCardsList` with shimmer
3. API returns → `MatchingLoaded` → skeleton disabled, fresh data rendered

### 🔄 Pull-to-Refresh (Failure)
1. `MatchingLoading` emitted
2. API fails → `MatchingError` emitted
3. Entire content replaced by `BridgeXErrorWidget`
4. User taps "Try Again" → `refreshMatches()` re-fetches

### 📱 Screen Reopened
- Always calls `fetchMatches()` in `MatchingProcessScreen.initState()`
- `MatchingCubit` is a singleton — its previous state is overwritten by the new fetch
- No cache is consulted

### 📊 Scores Equal 0
- All score badges render `"0.0%"` — the UI handles zero values normally

### 📛 Long Team Names
- Team name in `TeamCard` uses `Text` with `maxLines: 2` (handled by parent layout)
- Score badges are `Wrap`-based, so they wrap gracefully on narrow screens

### 📛 Null Values from Backend
- All `fromJson` constructors use `as int? ?? 0`, `as String? ?? ''`, `as List? ?? []` — null-safe
- `TeamCard` AI fields are all `Optional?` — if null, the section is hidden entirely

### 🔒 Double-Tap Guard
- Not needed — the cubit singleton means repeated `fetchMatches()` calls simply reset the state. The matching process screen navigates away on first completion, preventing re-entry.

### 🎨 Progress Ring at 0%
- `_RingPainter` has `if (progress <= 0) return;` — skips `SweepGradient` creation entirely, avoiding the Flutter assertion `endAngle > startAngle`

---

## 10. Dependency Injection

All registrations are in `matching_injection.dart`, called at app startup.

| Type | Registration | Scope |
|---|---|---|
| `MatchingCubit` | `registerLazySingleton` | Shared across `MatchingProcessScreen` and `RecommendedTeamsScreen` |
| `GetAiMatchesUseCase` | `registerLazySingleton` | Shared instance |
| `MatchingRepository` → `MatchingRepositoryImpl` | `registerLazySingleton` | Shared instance |
| `MatchingRemoteDataSource` → `MatchingRemoteDataSourceImpl` | `registerLazySingleton` | Shared instance |

> `MatchingCubit` is a singleton (not factory) because it is shared between two screens in the navigation flow. The cubit is provided to each screen via `BlocProvider.value(value: sl<MatchingCubit>())`.

---

## 11. File Map

```
lib/feature/matching/
│
├── di/
│   └── matching_injection.dart            # DI wiring
│
├── domain/
│   ├── entities/
│   │   ├── ai_match_entity.dart           # Top-level response entity
│   │   └── team_recommendation_entity.dart # Per-recommendation entity
│   ├── repositories/
│   │   └── matching_repository.dart       # Abstract contract
│   └── usecases/
│       └── get_ai_matches_usecase.dart    # NoParams → AiMatchEntity
│
├── data/
│   ├── models/
│   │   ├── ai_match_response_model.dart   # JSON → AiMatchEntity
│   │   └── team_recommendation_response_model.dart  # JSON → TeamRecommendationEntity
│   ├── datasources/
│   │   └── matching_remote_data_source.dart  # ApiClient call to /api/ai/match-teams
│   └── repositories/
│       └── matching_repository_impl.dart   # Orchestrates remote + error mapping
│
└── presentation/
    ├── cubit/
    │   ├── matching_cubit.dart            # State machine controller
    │   └── matching_state.dart            # 4 states: Initial, Loading, Loaded, Error
    ├── screens/
    │   ├── matching_process_screen.dart    # Animated loading screen (0→100%)
    │   ├── recommended_teams_screen.dart   # Shows recommendations or error/empty
    │   ├── no_teams_found_screen.dart      # Empty/error fallback screen
    │   └── select_category_screen.dart     # Entry point (unchanged)
    └── widgets/
        ├── matching_process_widgets/
        │   ├── matching_progress_ring.dart  # CustomPaint ring with SweepGradient
        │   ├── matching_process_title.dart  # "Finding Your Perfect Team"
        │   ├── skill_scan_section.dart      # Animated progress bar + verification steps
        │   └── dynamic_insight_card.dart    # AI insight blurb
        ├── recommended_teams_widgets/
        │   ├── team_cards_list.dart         # Builds TeamCard list from entities
        │   └── team_card.dart              # Extended with AI score badges + vibe
        └── no_teams_found_widgets/
            ├── no_teams_illustration.dart   # Illustration asset (reused)
            ├── no_teams_title.dart          # "No Teams Found" text (reused)
            └── try_again_button.dart        # Retry button (reused)
```
