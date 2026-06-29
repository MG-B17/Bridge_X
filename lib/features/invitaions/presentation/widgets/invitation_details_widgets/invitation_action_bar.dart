import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class InvitationActionBar extends StatelessWidget {
  final String status;
  final bool isLoading;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  const InvitationActionBar({
    super.key,
    required this.status,
    required this.isLoading,
    required this.onDecline,
    required this.onAccept,
  });

  bool get _isPending => status.toLowerCase() == 'pending';

  @override
  Widget build(BuildContext context) {
    if (!_isPending) return const SizedBox.shrink();

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
              text: InvitaionsStrings.decline,
              onTap: isLoading ? null : onDecline,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing12),
          Expanded(
            child: BridgeXButton(
              text: InvitaionsStrings.acceptInvitation,
              onTap: isLoading ? null : onAccept,
            ),
          ),
        ],
      ),
    );
  }
}
