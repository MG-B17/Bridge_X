import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';

class NavigationGuard {
  /// Routes accessible without authentication (full resolved paths)
  static const publicRoutes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
    BridgeXRoutePaths.forgotPassword,
  ];

  /// Prefixes that cover all auth sub-routes (signup/verify, forgot/verify/reset)
  static const _publicPrefixes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
    BridgeXRoutePaths.forgotPassword,
  ];

  static const onboardingRoutes = [
    BridgeXRoutePaths.onboarding,
    BridgeXRoutePaths.completeProfile,
  ];

  static bool _isPublicRoute(String location) {
    return _publicPrefixes.any((prefix) => location.startsWith(prefix));
  }

  static bool _isOnboardingRoute(String location) {
    return onboardingRoutes.contains(location);
  }

  static String? calculateRedirect(String currentLocation, AppState appState) {
    // App not ready → stay on splash
    if (!appState.isReady) {
      if (currentLocation != BridgeXRoutePaths.splash) {
        return BridgeXRoutePaths.splash;
      }
      return null;
    }

    // Leaving splash → determine destination
    if (currentLocation == BridgeXRoutePaths.splash) {
      if (!appState.hasSeenOnboarding) return BridgeXRoutePaths.onboarding;
      if (!appState.isLoggedIn) return BridgeXRoutePaths.login;
      return BridgeXRoutePaths.home;
    }

    // Onboarding not seen → force onboarding (unless already there)
    if (!appState.hasSeenOnboarding) {
      if (!_isOnboardingRoute(currentLocation)) {
        return BridgeXRoutePaths.onboarding;
      }
      return null;
    }

    // Not logged in → allow public routes, redirect others to login
    if (!appState.isLoggedIn) {
      if (_isPublicRoute(currentLocation)) {
        return null;
      }
      return BridgeXRoutePaths.login;
    }

    // Logged in → redirect away from public/onboarding routes to home
    if (_isPublicRoute(currentLocation) || _isOnboardingRoute(currentLocation)) {
      return BridgeXRoutePaths.home;
    }

    return null;
  }
}
