import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';


class NavigationGuard {
  
  static const publicRoutes = [
    BridgeXRoutePaths.login,
    BridgeXRoutePaths.signUp,
  ];

 
  static const onboardingRoutes = [
    BridgeXRoutePaths.onboarding,
    BridgeXRoutePaths.completeProfile,
  ];

  static String? calculateRedirect(String currentLocation, AppState appState) {
    
    if (!appState.isReady) {
      if (currentLocation != BridgeXRoutePaths.splash) {
        return BridgeXRoutePaths.splash;
      }
      return null;
    }

    
    if (currentLocation == BridgeXRoutePaths.splash) {
      if (!appState.hasSeenOnboarding) return BridgeXRoutePaths.onboarding;
      if (!appState.isLoggedIn) return BridgeXRoutePaths.login;
      return BridgeXRoutePaths.home;
    }

    
    if (!appState.hasSeenOnboarding) {
      if (!onboardingRoutes.contains(currentLocation)) {
        return BridgeXRoutePaths.onboarding;
      }
      return null; 
    }

    
    if (!appState.isLoggedIn) {
      if (!publicRoutes.contains(currentLocation)) {
        return BridgeXRoutePaths.login;
      }
      return null;
    }

    
    if (publicRoutes.contains(currentLocation) || onboardingRoutes.contains(currentLocation)) {
      return BridgeXRoutePaths.home;
    }

    return null; 
  }
}
