import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';

class NavigationGuard {
  /// Routes accessible without authentication (resolved paths)
  static const _publicPrefixes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
    BridgeXRoutePaths.forgotPassword,
  ];

  /// Routes used during the onboarding / profile-setup flow
  static const _setupRoutes = [
    BridgeXRoutePaths.onboarding,
    BridgeXRoutePaths.completeProfile,
    BridgeXRoutePaths.updateProfile,
  ];

  static bool _isPublicRoute(String location) {
    return _publicPrefixes.any((prefix) => location.startsWith(prefix));
  }

  static bool _isSetupRoute(String location) {
    return _setupRoutes.contains(location);
  }

  static String? calculateRedirect(String currentLocation, AppState appState) {
    // ─────────────────────────────────────────────
    // 1. App not ready → stay on splash
    // ─────────────────────────────────────────────
    if (!appState.isReady) {
      if (currentLocation != BridgeXRoutePaths.splash) {
        return BridgeXRoutePaths.splash;
      }
      return null;
    }

    // ─────────────────────────────────────────────
    // 2. Leaving splash → where to go first?
    // ─────────────────────────────────────────────
    if (currentLocation == BridgeXRoutePaths.splash) {
      if (!appState.hasSeenOnboarding) return BridgeXRoutePaths.onboarding;
      if (!appState.isLoggedIn) return BridgeXRoutePaths.login;
      if (!appState.isVerified) return BridgeXRoutePaths.completeProfile;
      if (appState.username == null || appState.username!.isEmpty) {
        return BridgeXRoutePaths.updateProfile;
      }
      return BridgeXRoutePaths.home;
    }

    // ─────────────────────────────────────────────
    // 3. Onboarding not seen yet → force onboarding
    // ─────────────────────────────────────────────
    if (!appState.hasSeenOnboarding) {
      if (!_isSetupRoute(currentLocation)) {
        return BridgeXRoutePaths.onboarding;
      }
      return null;
    }

    // ─────────────────────────────────────────────
    // 4. Not logged in → allow only public routes
    // ─────────────────────────────────────────────
    if (!appState.isLoggedIn) {
      if (_isPublicRoute(currentLocation)) {
        return null;
      }
      return BridgeXRoutePaths.login;
    }

    // ─────────────────────────────────────────────
    // 5. Logged in but not verified → must complete
    //    track selection first
    // ─────────────────────────────────────────────
    if (!appState.isVerified) {
      if (currentLocation != BridgeXRoutePaths.completeProfile) {
        return BridgeXRoutePaths.completeProfile;
      }
      return null;
    }

    // ─────────────────────────────────────────────
    // 6. Verified → check if username is set
    // ─────────────────────────────────────────────
    if (appState.username == null || appState.username!.isEmpty) {
      if (currentLocation != BridgeXRoutePaths.updateProfile) {
        return BridgeXRoutePaths.updateProfile;
      }
      return null;
    }

    // ─────────────────────────────────────────────
    // 7. Fully set up → redirect away from
    //    public / setup routes to home
    // ─────────────────────────────────────────────
    if (_isPublicRoute(currentLocation) || _isSetupRoute(currentLocation)) {
      return BridgeXRoutePaths.home;
    }

    return null;
  }
}
