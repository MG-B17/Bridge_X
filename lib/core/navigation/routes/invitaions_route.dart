import 'package:bridge_x/core/animation/screen_transtion_animation/transitions/slide_right_trnasition.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/navigation/screens_args/request_review_invitation_args.dart';
import 'package:bridge_x/core/navigation/screens_args/request_review_join_request_args.dart';
import 'package:bridge_x/feature/invitaions/presentation/screens/requests_center_screen.dart';
import 'package:bridge_x/feature/invitaions/presentation/screens/request_review_invitation_screen.dart';
import 'package:bridge_x/feature/invitaions/presentation/screens/request_review_join_request_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final SlideRightTransitionPage slideRightTransitionPage = SlideRightTransitionPage();

final invitaionsRoute = GoRoute(
  path: BridgeXRoutePaths.requestsCenter,
  name: BridegeXRouteNames.requestsCenter,
  builder: (context, state) => const RequestsCenterScreen(),
  routes: [
    GoRoute(
      path: BridgeXRoutePaths.requestReviewInvitation,
      name: BridegeXRouteNames.requestReviewInvitation,
      pageBuilder: (context, state) {
        final args = state.extra as RequestReviewInvitationArgs;
        return slideRightTransitionPage.build(
          child: BlocProvider.value(
            value: args.cubit,
            child: RequestReviewInvitationScreen(invitation: args.invitation),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: BridgeXRoutePaths.requestReviewJoinRequest,
      name: BridegeXRouteNames.requestReviewJoinRequest,
      pageBuilder: (context, state) {
        final args = state.extra as RequestReviewJoinRequestArgs;
        return slideRightTransitionPage.build(
          child: BlocProvider.value(
            value: args.cubit,
            child: RequestReviewJoinRequestScreen(joinRequest: args.joinRequest),
          ),
          state: state,
        );
      },
    ),
  ],
);
