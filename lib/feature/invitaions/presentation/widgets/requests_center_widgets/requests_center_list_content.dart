import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/request_review_invitation_args.dart';
import 'package:bridge_x/core/navigation/screens_args/request_review_join_request_args.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_cubit.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/invitation_card.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/join_request_card.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/requests_center_widgets/requests_center_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestsCenterListContent extends StatelessWidget {
  final InvitaionsTab activeTab;
  final List<ProjectInvitationEntity> invitations;
  final List<JoinRequestEntity> joinRequests;
  final InvitaionsCubit cubit;

  const RequestsCenterListContent({
    super.key,
    required this.activeTab,
    required this.invitations,
    required this.joinRequests,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (activeTab == InvitaionsTab.invitations) {
      if (invitations.isEmpty) {
        return const RequestsCenterEmptyState(
          message: 'No pending invitations',
        );
      }

      return Column(
        children: invitations.map((invitation) {
          return InvitationCard(
            invitation: invitation,
            onReview: () {
              context.pushNamed(
                BridegeXRouteNames.requestReviewInvitation,
                extra: RequestReviewInvitationArgs(
                  invitation: invitation,
                  cubit: cubit,
                ),
              );
            },
          );
        }).toList(),
      );
    }

    if (joinRequests.isEmpty) {
      return const RequestsCenterEmptyState(message: 'No membership requests');
    }

    return Column(
      children: joinRequests.map((joinRequest) {
        return JoinRequestCard(
          joinRequest: joinRequest,
          onReview: () {
            context.pushNamed(
              BridegeXRouteNames.requestReviewJoinRequest,
              extra: RequestReviewJoinRequestArgs(
                joinRequest: joinRequest,
                cubit: cubit,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
