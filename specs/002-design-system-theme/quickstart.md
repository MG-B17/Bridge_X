# Quickstart: Design System & Theme Verification

**Feature**: 002-design-system-theme
**Date**: 2026-04-22

## Prerequisites

- Phase 0 (Packages Setup) complete — `flutter pub get` has passed ✅
- `flutter_screenutil ^5.9.3` and `google_fonts ^6.2.1` installed ✅
- Terminal open at project root (`c:\Users\mostafa\StudioProjects\bridgex`)

---

## Step 1 — Verify Inter Font Local Assets Exist

```powershell
Test-Path assets\fonts\Inter-Regular.ttf    # Should return True
Test-Path assets\fonts\Inter-SemiBold.ttf   # Should return True
Test-Path assets\fonts\Inter-Bold.ttf       # Should return True
```

If any return `False`, download Inter font files from
[https://fonts.google.com/specimen/Inter](https://fonts.google.com/specimen/Inter)
and place TTF files in `assets/fonts/`.

---

## Step 2 — Verify pubspec.yaml Font Registration

Open `pubspec.yaml` and confirm the `flutter:` section contains:

```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

---

## Step 3 — Run Analyzer After Implementation

```powershell
flutter analyze
```

**Expected**: `No issues found!`

Any errors here indicate a syntax issue in the theme files. Fix before proceeding.

---

## Step 4 — Manual Token Spot Check

Run the app in debug mode (`flutter run --debug`) and verify visually:

| Check | Expected |
|---|---|
| Scaffold background | Off-white `#F9FAFB` — not pure white |
| Primary button | Deep blue `#2D4B73` |
| Body text | Near-black `#111827` — not pure black |
| Secondary text | Medium grey `#6B7280` |
| Card shadow | Soft visible shadow — 5% black, 4px blur |
| Border radius (cards) | Noticeably rounded — `12px` equivalent |
| Typography | Inter font visible — proportional to `390px` base |

---

## Step 5 — Dark Mode Spot Check

On your device/emulator, switch the OS to dark mode while the app is running.

| Check | Expected |
|---|---|
| Scaffold background | Dark `#111827` |
| Surface (cards) | Dark `#1F2937` |
| Body text | Near-white `#F9FAFB` |
| Primary color | Bright blue `#4A6CF7` |

**Expected**: All colors update on the next frame — no restart required, no manual
conditional checks in the code.

---

## Step 6 — Offline Font Verification

1. Disable network on the device/emulator
2. Clear the app data (or install fresh)
3. Launch the app

**Expected**: Typography renders in Inter font — not the OS system font (e.g., Roboto
on Android, SF Pro on iOS). Visible difference: Inter has distinctive letter shapes
(`a`, `g`, `l`).

---

## Step 7 — Run `flutter pub get` After pubspec Changes

If `pubspec.yaml` was modified to add font assets:

```powershell
flutter pub get
```

**Expected**: Zero errors.

---

## Deliverable Checklist

- [ ] `app_color_scheme.dart` — 11 light + 5 dark tokens + gradient defined
- [ ] `text_style.dart` — 6 Inter text styles with `.sp` sizes
- [ ] `app_them.dart` — `AppTheme.light` + `AppTheme.dark` wired
- [ ] `app_spacing.dart` — 6 spacing + 3 radius + 1 shadow constant defined
- [ ] `app_strings.dart` — initial known strings populated
- [ ] `app.dart` — `ScreenUtilInit(designSize: Size(390,844))` wrapping `MaterialApp.router`
- [ ] `extensions.dart` — `context.colors.*` and `context.*TextStyle` extensions wired
- [ ] Inter font files in `assets/fonts/` and registered in `pubspec.yaml`
- [ ] `flutter analyze` — zero errors
- [ ] Manual light mode spot check passes
- [ ] Manual dark mode spot check passes
- [ ] Offline font spot check passes
