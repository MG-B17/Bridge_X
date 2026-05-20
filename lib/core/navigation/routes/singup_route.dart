import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_up_transition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/register_screen.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/screen/verfiy_email_screen.dart';
import 'package:go_router/go_router.dart';

final BottomSheetTransitionPage bottomSheetTransitionPage = BottomSheetTransitionPage();
final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();
GoRoute singupRoute = GoRoute(
  path: BridgeXRoutePaths.signUp,
  name: BridegeXRouteNames.signUp,
  pageBuilder: (context, state) =>
      bottomSheetTransitionPage.build(child: RegisterScreen(), state: state),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.verifyEmailCode,
      name: BridegeXRouteNames.verifyEmailCode,
      pageBuilder: (context, state) {
        final otpargs = state.extra as OtpArgs;
        return slideRightTransitionPage.build(
          child: VerfiyEmailScreen(otpArgs: otpargs),
          state: state,
        );
      },
    ),
  ],
);
