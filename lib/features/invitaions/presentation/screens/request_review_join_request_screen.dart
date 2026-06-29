import 'package:bridge_x/core/extensions/date_extension.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_cubit.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/join_request_details_widgets/join_request_action_bar.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/join_request_details_widgets/join_request_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequestReviewJoinRequestScreen extends StatefulWidget {
  final JoinRequestEntity joinRequest;

  const RequestReviewJoinRequestScreen({
    super.key,
    required this.joinRequest,
  });

  @override
  State<RequestReviewJoinRequestScreen> createState() =>
      _RequestReviewJoinRequestScreenState();
}

class _RequestReviewJoinRequestScreenState
    extends State<RequestReviewJoinRequestScreen> {
  int? get _joinRequestId => int.tryParse(widget.joinRequest.id);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final joinRequestId = _joinRequestId;
      if (!mounted || joinRequestId == null) return;
      context.read<InvitaionsCubit>().fetchJoinRequestDetails(joinRequestId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvitaionsCubit, InvitaionsState>(
      listener: (context, state) {
        if (state is InvitaionsLoaded) {
          final hasRequest = state.joinRequests.any(
            (e) => e.id == widget.joinRequest.id,
          );
          if (!hasRequest && context.mounted) {
            context.pop();
          }
        }
      },
      builder: (context, state) {
        final loadedState = state is InvitaionsLoaded ? state : null;
        final isDetailsLoading = loadedState?.isJoinRequestDetailsLoading ?? false;
        final details = loadedState?.selectedJoinRequestDetails;
        final matchesCurrent = details?.joinRequestId.toString() == widget.joinRequest.id;

        final currentJoinRequest = matchesCurrent && details != null
            ? JoinRequestEntity(
                id: details.joinRequestId.toString(),
                userName: details.programmer.name,
                userHandle: details.programmer.username,
                userRole: details.programmer.track,
                userRating: details.programmer.averageStars,
                userAvatar: details.programmer.avatarUrl ??
                    'https://i.pravatar.cc/150?u=${details.programmer.programmerId}',
                expertiseTags: details.programmer.skills,
                aboutText: details.programmer.bio ?? '',
                appliedTimeAgo: details.createdAt.toFormattedDate(),
                isNew: details.status == 'pending',
              )
            : widget.joinRequest;

        if (loadedState?.joinRequestDetailsError != null && details == null) {
          return Scaffold(
            body: SafeArea(
              child: BridgeXErrorWidget(
                errorTittle: 'Failed to Load Request Details',
                errorMessage: loadedState!.joinRequestDetailsError!,
                refreshButtonTap: () {
                  final joinRequestId = _joinRequestId;
                  if (joinRequestId == null) return;
                  context.read<InvitaionsCubit>().fetchJoinRequestDetails(
                    joinRequestId,
                  );
                },
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: BridgeXSkeletonizer(
              enableloading: isDetailsLoading,
              child: Column(
                children: [
                  Expanded(
                    child: JoinRequestDetailsContent(
                      joinRequest: currentJoinRequest,
                    ),
                  ),
                  JoinRequestActionBar(
                    onReject: () {
                      context.read<InvitaionsCubit>().declineJoinRequest(
                        widget.joinRequest.id,
                      );
                    },
                    onAccept: () {
                      context.read<InvitaionsCubit>().acceptJoinRequest(
                        widget.joinRequest.id,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
