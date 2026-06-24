import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_up_transition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/features/auth/presentation/screens/register/register_screen.dart';
import 'package:bridge_x/features/auth/presentation/screens/verify_code/screen/verify_email_screen.dart';
import 'package:go_router/go_router.dart';

final BottomSheetTransitionPage bottomSheetTransitionPage = BottomSheetTransitionPage();
final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();
GoRoute singupRoute = GoRoute(
  path: BridgeXRoutePaths.signUp,
  name: BridgeXRouteNames.signUp,
  pageBuilder: (context, state) =>
      bottomSheetTransitionPage.build(child: RegisterScreen(), state: state),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.verifyEmailCode,
      name: BridgeXRouteNames.verifyEmailCode,
      pageBuilder: (context, state) {
        final otpargs = state.extra as OtpArgs;
        return slideRightTransitionPage.build(
          child: VerifyEmailScreen(otpArgs: otpargs),
          state: state,
        );
      },
    ),
  ],
);
