import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_cubit.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/join_request_details_widgets/join_request_action_bar.dart';
import 'package:bridge_x/feature/invitaions/presentation/widgets/join_request_details_widgets/join_request_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequestReviewJoinRequestScreen extends StatelessWidget {
  final JoinRequestEntity joinRequest;

  const RequestReviewJoinRequestScreen({
    super.key,
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvitaionsCubit, InvitaionsState>(
      listener: (context, state) {
        if (state is InvitaionsLoaded) {
          final hasRequest = state.joinRequests.any((e) => e.id == joinRequest.id);
          if (!hasRequest) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: JoinRequestDetailsContent(joinRequest: joinRequest),
              ),
              JoinRequestActionBar(
                onReject: () {
                  context.read<InvitaionsCubit>().declineJoinRequest(
                    joinRequest.id,
                  );
                },
                onAccept: () {
                  context.read<InvitaionsCubit>().acceptJoinRequest(
                    joinRequest.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
