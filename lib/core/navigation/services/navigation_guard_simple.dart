import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';


class NavigationGuard {
  // Routes accessible without being logged in (after onboarding)
  static const publicRoutes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
  ];

  // Onboarding routes — accessible without login (first-time users)
  static const onboardingRoutes = [
    BridgeXRoutePaths.onboarding,
    BridgeXRoutePaths.completeProfile,
  ];

  static String? calculateRedirect(String currentLocation, AppState appState) {
    // 1. App is still loading → stay on splash
    if (!appState.isReady) {
      if (currentLocation != BridgeXRoutePaths.splash) {
        return BridgeXRoutePaths.splash;
      }
      return null;
    }

    // 2. App ready → always leave splash
    //    Priority: onboarding check BEFORE login check
    //    First-time user: not seen onboarding → go to onboarding (even if not logged in)
    if (currentLocation == BridgeXRoutePaths.splash) {
      if (!appState.hasSeenOnboarding) return BridgeXRoutePaths.onboarding;
      if (!appState.isLoggedIn) return BridgeXRoutePaths.login;
      return BridgeXRoutePaths.home;
    }

    // 3. Haven't seen onboarding yet → lock to onboarding routes
    //    (applies to first-time unauthenticated users navigating deeper)
    if (!appState.hasSeenOnboarding) {
      if (!onboardingRoutes.contains(currentLocation)) {
        return BridgeXRoutePaths.onboarding;
      }
      return null; // Allow them to stay on onboarding pages
    }

    // 4. Seen onboarding but not logged in → force login
    if (!appState.isLoggedIn) {
      if (!publicRoutes.contains(currentLocation)) {
        return BridgeXRoutePaths.login;
      }
      return null;
    }

    // 5. Fully authenticated → redirect away from public/onboarding to home
    if (publicRoutes.contains(currentLocation) || onboardingRoutes.contains(currentLocation)) {
      return BridgeXRoutePaths.home;
    }

    return null; // Already where they should be
  }
}
