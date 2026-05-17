import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/core/navigation/screens_args/reset_password_args.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/screens/forget_password_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/screens/reset_password_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/login_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/screen/verfiy_password_screen.dart';
import 'package:go_router/go_router.dart';

GoRoute loginRoute = GoRoute(
  path: BridgeXRoutePaths.login,
  name: BridegeXRouteNames.login,
  builder: (context, state) => const LoginScreen(),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.forgotPassword,
      name: BridegeXRouteNames.forgotPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: BridgeXRoutePaths.verifyPasswordCode,
      name: BridegeXRouteNames.verifyPasswordCode,
      builder: (context, state) {
        final otpargs = state.extra as OtpArgs;
        return VerfiyPasswordScreen(otpArgs: otpargs);
      },
    ),
    GoRoute(
      path: BridgeXRoutePaths.resetPassword,
      name: BridegeXRouteNames.resetPassword,
      builder: (context, state) {
        final args = state.extra as ResetPasswordArgs;
        return ResetPasswordScreen(email: args.email, token: args.token);
      },
    ),
  ],
);
