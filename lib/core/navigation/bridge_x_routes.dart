import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/navigator_keys.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';

import 'package:bridge_x/core/navigation/routes/home_route.dart';
import 'package:bridge_x/core/navigation/routes/forget_password_route.dart';
import 'package:bridge_x/core/navigation/routes/profile_route.dart';
import 'package:bridge_x/core/navigation/routes/project_route.dart';
import 'package:bridge_x/core/navigation/routes/singup_route.dart';
import 'package:bridge_x/core/navigation/routes/invitaions_route.dart';
import 'package:bridge_x/core/navigation/services/navigation_guard.dart';
import 'package:bridge_x/features/auth/presentation/screens/complete_profile/complete_profile_screen.dart';
import 'package:bridge_x/features/auth/presentation/screens/login/login_screen.dart';
import 'package:bridge_x/features/auth/presentation/screens/verify_code/screen/post_login_verify_email_screen.dart';
import 'package:bridge_x/features/layout/layout.dart';
import 'package:bridge_x/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:bridge_x/features/profile/presentation/screen/edit_profile.dart';
import 'package:bridge_x/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
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
      name: BridgeXRouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: BridgeXRoutePaths.onboarding,
      name: BridgeXRouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: BridgeXRoutePaths.login,
      name: BridgeXRouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    forgetPasswordRoute,
    singupRoute,
    invitaionsRoute,
    GoRoute(
      path: BridgeXRoutePaths.verifyEmail,
      name: BridgeXRouteNames.verifyEmail,
      builder: (context, state) => const PostLoginVerifyEmailScreen(),
    ),
    GoRoute(
      path: BridgeXRoutePaths.completeProfile,
      name: BridgeXRouteNames.completeProfile,
      builder: (context, state) => const CompleteProfileScreen(),
    ),
    GoRoute(
      path: BridgeXRoutePaths.updateProfile,
      name: BridgeXRouteNames.updateProfile,
      builder: (context, state) => const EditProfileScreen(isSetupMode: true),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, statefulNavigationShell) =>
          LayoutScreen(navigationShell: statefulNavigationShell),
      branches: [homeRoute,  projectRoute, profileRoute],// chatRoute
    ),
  ],
);
