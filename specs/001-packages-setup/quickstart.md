# Quickstart: Packages Setup Verification

**Feature**: 001-packages-setup
**Date**: 2026-04-22

## Prerequisites

- Flutter SDK ≥ 3.9.2 installed (`flutter --version` to verify)
- Internet connection available
- Terminal open at project root (`c:\Users\mostafa\StudioProjects\bridgex`)

## Step 1 — Verify Current State

```powershell
# Confirm you are in the project root
ls pubspec.yaml

# Check installed Flutter SDK version
flutter --version
```

## Step 2 — Get All Packages

```powershell
flutter pub get
```

**Expected output**: Resolves X packages. No errors. No version conflicts.

If conflicts appear:
```powershell
# Inspect full dependency tree
flutter pub deps
# Then pin the conflicting package to the compatible version in pubspec.yaml
```

## Step 3 — Verify Zero Analyzer Errors

```powershell
flutter analyze
```

**Expected output**: `No issues found!` or only infos/hints (no errors or warnings).

## Step 4 — Verify Asset Directories Exist

```powershell
# Windows PowerShell
Test-Path assets\images    # Should return True
Test-Path assets\svg       # Should return True
```

If missing:
```powershell
New-Item -ItemType Directory -Path assets\images
New-Item -ItemType Directory -Path assets\svg
```

## Step 5 — Build Smoke Test

```powershell
# Verify the project compiles (no device needed)
flutter build apk --debug --no-tree-shake-icons 2>&1 | Select-String -Pattern "error:"
```

**Expected**: No lines containing `error:` in output.

Alternatively with a connected device:
```powershell
flutter run --debug
```

**Expected**: App launches to default Flutter counter screen without crashing.

## Deliverable Checklist

- [ ] `flutter pub get` — zero errors, zero conflicts
- [ ] `flutter analyze` — zero errors
- [ ] `assets/images/` directory exists
- [ ] `assets/svg/` directory exists
- [ ] Both asset dirs registered in `pubspec.yaml`
- [ ] `environment.sdk: ^3.9.2` unchanged
- [ ] All 25 new production packages present in `dependencies:`
- [ ] `bloc_test` and `mocktail` present in `dev_dependencies:`
- [ ] Project builds or runs without startup crash
