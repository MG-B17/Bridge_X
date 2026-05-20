import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/scale_transition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/core/navigation/screens_args/reset_password_args.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/screens/forget_password_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/screens/reset_password_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/screen/verfiy_password_screen.dart';
import 'package:go_router/go_router.dart';


final ScaleTransitionPage scaleTransitionPage = ScaleTransitionPage();
final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

GoRoute forgetPasswordRoute = GoRoute(
  path: BridgeXRoutePaths.forgotPassword,
  name: BridegeXRouteNames.forgotPassword,
  pageBuilder: (context, state) =>
      scaleTransitionPage.build(child: const ForgetPasswordScreen(), state: state),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.verifyPasswordCode,
      name: BridegeXRouteNames.verifyPasswordCode,
      pageBuilder: (context, state) {
        final otpargs = state.extra as OtpArgs;
        return slideRightTransitionPage.build(
          child: VerfiyPasswordScreen(otpArgs: otpargs),
          state: state,
        );
      },
      routes: [
        GoRoute(
          path: BridgeXRoutePaths.resetPassword,
          name: BridegeXRouteNames.resetPassword,
          pageBuilder: (context, state) {
            final args = state.extra as ResetPasswordArgs;
            return slideRightTransitionPage.build(
              child: ResetPasswordScreen(email: args.email, token: args.token),
              state: state,
            );
          },
        ),
      ],
    ),
  ],
);
