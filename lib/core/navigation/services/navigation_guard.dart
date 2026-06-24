import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';

class NavigationGuard {
  static const _publicPrefixes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
    BridgeXRoutePaths.forgotPassword,
  ];

  static const _setupRoutes = [
    BridgeXRoutePaths.onboarding,
    BridgeXRoutePaths.verifyEmail,
    BridgeXRoutePaths.completeProfile,
    BridgeXRoutePaths.updateProfile,
  ];

  static bool _isPublicRoute(String location) {
    return _publicPrefixes.any((prefix) => location.startsWith(prefix));
  }

  static bool _isSetupRoute(String location) {
    return _setupRoutes.contains(location);
  }

  static bool _userNameMissing(AppState appState) {
    return appState.userData?.userName == null ||
        appState.userData!.userName.isEmpty;
  }

  static String? calculateRedirect(String currentLocation, AppState appState) {
    // 1. App not ready → stay on splash
    if (!appState.isReady) {
      if (currentLocation != BridgeXRoutePaths.splash) {
        return BridgeXRoutePaths.splash;
      }
      return null;
    }

    // 2. Leaving splash → where to go first?
    if (currentLocation == BridgeXRoutePaths.splash) {
      if (!appState.hasSeenOnboarding) return BridgeXRoutePaths.onboarding;
      if (!appState.isLoggedIn) return BridgeXRoutePaths.login;
      if (!appState.isVerified) return BridgeXRoutePaths.verifyEmail;
      if (!appState.isProfileComplete) return BridgeXRoutePaths.completeProfile;
      if (_userNameMissing(appState)) {
        return BridgeXRoutePaths.updateProfile;
      }
      return BridgeXRoutePaths.home;
    }

    // 3. Onboarding not seen yet → force onboarding
    if (!appState.hasSeenOnboarding) {
      if (!_isSetupRoute(currentLocation)) {
        return BridgeXRoutePaths.onboarding;
      }
      return null;
    }

    // 4. Not logged in → allow only public routes
    if (!appState.isLoggedIn) {
      if (_isPublicRoute(currentLocation)) {
        return null;
      }
      return BridgeXRoutePaths.login;
    }

    // 5. Not verified → allow only verify-email
    if (!appState.isVerified) {
      if (currentLocation == BridgeXRoutePaths.verifyEmail) return null;
      return BridgeXRoutePaths.verifyEmail;
    }

    // 6. Profile incomplete (no track/experience set) → allow only complete-profile
    if (!appState.isProfileComplete) {
      if (currentLocation == BridgeXRoutePaths.completeProfile) return null;
      return BridgeXRoutePaths.completeProfile;
    }

    // 7. Username missing → allow only update-profile
    if (_userNameMissing(appState)) {
      if (currentLocation == BridgeXRoutePaths.updateProfile) return null;
      return BridgeXRoutePaths.updateProfile;
    }

    // 8. Fully set up → redirect away from public / setup routes to home
    if (_isPublicRoute(currentLocation) || _isSetupRoute(currentLocation)) {
      return BridgeXRoutePaths.home;
    }

    return null;
  }
}
