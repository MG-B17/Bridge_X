import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/register_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/screen/verfiy_email_screen.dart';
import 'package:go_router/go_router.dart';

GoRoute singupRoute = GoRoute(
      path: BridgeXRoutePaths.signUp,
      name: BridegeXRouteNames.signUp,
      builder: (context, state) => const RegisterScreen(),
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.verifyEmailCode,
          name: BridegeXRouteNames.verifyEmailCode,
          builder: (context, state) {
            final otpargs = state.extra as OtpArgs;
            return VerfiyEmailScreen(otpArgs: otpargs);
          },
        ),
      ],
    );