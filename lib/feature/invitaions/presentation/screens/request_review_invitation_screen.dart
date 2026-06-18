import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_cubit.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/invitation_details_widgets/invitation_action_bar.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/invitation_details_widgets/invitation_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequestReviewInvitationScreen extends StatefulWidget {
  final ProjectInvitationEntity invitation;

  const RequestReviewInvitationScreen({
    super.key,
    required this.invitation,
  });

  @override
  State<RequestReviewInvitationScreen> createState() =>
      _RequestReviewInvitationScreenState();
}

class _RequestReviewInvitationScreenState
    extends State<RequestReviewInvitationScreen> {
  bool _isLoadingDialogShowing = false;

  int? get _invitationId => int.tryParse(widget.invitation.id);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final invitationId = _invitationId;
      if (!mounted || invitationId == null) return;
      context.read<InvitaionsCubit>().fetchInvitationDetails(invitationId);
    });
  }

  void _showLoadingDialog() {
    if (_isLoadingDialogShowing) return;
    _isLoadingDialogShowing = true;
    LoadingDialog.show(context: context, message: 'Processing invitation...')
        .then((_) {
          _isLoadingDialogShowing = false;
        });
  }

  void _hideLoadingDialog() {
    if (!_isLoadingDialogShowing) return;
    LoadingDialog.hide(context);
    _isLoadingDialogShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvitaionsCubit, InvitaionsState>(
      listener: (context, state) {
        if (state is! InvitaionsLoaded) return;

        final hasInvitation = state.invitations.any(
          (e) => e.id == widget.invitation.id,
        );
        if (!hasInvitation) {
          _hideLoadingDialog();
          final successMessage = state.detailsActionSuccessMessage;
          if (successMessage != null && context.mounted) {
            SuccessDialog.show(
              context: context,
              title: 'Success',
              message: successMessage,
              onAction: () {
                context.read<InvitaionsCubit>().clearActionFeedback();
                if (context.mounted) context.pop();
              },
            );
          } else if (context.mounted) {
            context.pop();
          }
          return;
        }

        if (state.isInvitationActionLoading) {
          _showLoadingDialog();
        } else {
          _hideLoadingDialog();
        }

        if (state.detailsActionError != null) {
          ErrorDialog.show(
            context: context,
            title: 'Action Failed',
            message: state.detailsActionError!,
            onAction: () => context.read<InvitaionsCubit>().clearActionFeedback(),
          );
        }
      },
      builder: (context, state) {
        final loadedState = state is InvitaionsLoaded ? state : null;
        final isDetailsLoading = loadedState?.isDetailsLoading ?? false;
        final details = loadedState?.selectedInvitationDetails;
        final matchesCurrent = details?.invitationId.toString() == widget.invitation.id;
        final currentInvitation = matchesCurrent && details != null
            ? ProjectInvitationEntity.fromInvitationDetailsEntity(details)
            : widget.invitation;

        if (loadedState?.detailsError != null && details == null) {
          return Scaffold(
            body: SafeArea(
              child: BridgeXErrorWidget(
                errorTittle: 'Failed to Load Invitation',
                errorMessage: loadedState!.detailsError!,
                refreshButtonTap: () {
                  final invitationId = _invitationId;
                  if (invitationId == null) return;
                  context.read<InvitaionsCubit>().fetchInvitationDetails(
                    invitationId,
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
                    child: InvitationDetailsContent(
                      invitation: currentInvitation,
                    ),
                  ),
                  InvitationActionBar(
                    status: currentInvitation.status,
                    isLoading: loadedState?.isInvitationActionLoading == true,
                    onDecline: () {
                      context.read<InvitaionsCubit>().declineInvitation(
                        widget.invitation.id,
                      );
                    },
                    onAccept: () {
                      context.read<InvitaionsCubit>().acceptInvitation(
                        widget.invitation.id,
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
