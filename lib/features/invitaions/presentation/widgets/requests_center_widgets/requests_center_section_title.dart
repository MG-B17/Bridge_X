import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class RequestsCenterSectionTitle extends StatelessWidget {
  final InvitaionsTab activeTab;

  const RequestsCenterSectionTitle({
    super.key,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    final title = activeTab == InvitaionsTab.invitations
        ? InvitaionsStrings.pendingInvitations
        : InvitaionsStrings.joinRequestsTab.toUpperCase();

    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        color: context.appColors.textSecondary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }
}
