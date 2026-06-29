import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/join_request_details_widgets/join_request_application_card.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/join_request_details_widgets/join_request_info_sections.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/join_request_details_widgets/join_request_profile_section.dart';
import 'package:flutter/material.dart';

class JoinRequestDetailsContent extends StatelessWidget {
  final JoinRequestEntity joinRequest;

  const JoinRequestDetailsContent({
    super.key,
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
        vertical: AppSpacing.spacing20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BridgeXScreenHeader(title: InvitaionsStrings.requestDetails),
          VerticalSpacing(AppSpacing.spacing32),
          JoinRequestProfileSection(joinRequest: joinRequest),
          VerticalSpacing(AppSpacing.spacing28),
          Divider(color: context.appColors.divider.withValues(alpha: 0.5)),
          VerticalSpacing(AppSpacing.spacing20),
          JoinRequestInfoSections(joinRequest: joinRequest),
          VerticalSpacing(AppSpacing.spacing24),
          JoinRequestApplicationCard(joinRequest: joinRequest),
        ],
      ),
    );
  }
}
