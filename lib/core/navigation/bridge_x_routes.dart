import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/routes/chat_route.dart';
import 'package:bridge_x/core/navigation/routes/home_route.dart';
import 'package:bridge_x/core/navigation/routes/forget_password_route.dart';
import 'package:bridge_x/core/navigation/routes/matching_route.dart';
import 'package:bridge_x/core/navigation/routes/profile_route.dart';
import 'package:bridge_x/core/navigation/routes/project_route.dart';
import 'package:bridge_x/core/navigation/routes/singup_route.dart';
import 'package:bridge_x/core/navigation/services/navigation_guard_simple.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/complete_profile_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/login_screen.dart';
import 'package:bridge_x/feature/layout/layout.dart';
import 'package:bridge_x/feature/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:bridge_x/feature/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: BridgeXRoutePaths.splash,
  redirect: (context, state) {
    final appState = sl<AppState>();
    final redirect = NavigationGuard.calculateRedirect(state.matchedLocation, appState);
    return redirect;
  },
  refreshListenable: sl<AppState>(),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.splash,
      name: BridegeXRouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: BridgeXRoutePaths.onboarding,
      name: BridegeXRouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: BridgeXRoutePaths.login,
      name: BridegeXRouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    forgetPasswordRoute,
    singupRoute,
    GoRoute(
      path: BridgeXRoutePaths.completeProfile,
      name: BridegeXRouteNames.completeProfile,
      builder: (context, state) => const CompleteProfileScreen(),
    ),
    matchingRoute,

    StatefulShellRoute.indexedStack(
      builder: (context, state, statefulNavigationShell) =>
          LayoutScreen(navigationShell: statefulNavigationShell),
      branches: [homeRoute, chatRoute, projectRoute, profileRoute],
    ),
  ],
);
