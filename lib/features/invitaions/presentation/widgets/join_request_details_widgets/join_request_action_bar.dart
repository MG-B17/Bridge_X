import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class JoinRequestActionBar extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const JoinRequestActionBar({
    super.key,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
        vertical: AppSpacing.spacing16,
      ),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(
          top: BorderSide(
            color: context.appColors.divider.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: BridgeXOutlineButton(
              text: InvitaionsStrings.rejectRequest,
              onTap: onReject,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing12),
          Expanded(
            child: BridgeXButton(
              text: InvitaionsStrings.acceptMember,
              onTap: onAccept,
            ),
          ),
        ],
      ),
    );
  }
}
