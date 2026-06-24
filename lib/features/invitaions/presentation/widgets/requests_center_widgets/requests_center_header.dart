import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class RequestsCenterHeader extends StatelessWidget {
  const RequestsCenterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BridgeXBackButton(),
        HorizontalSpacing(AppSpacing.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                InvitaionsStrings.requestsCenter,
                style: AppTextStyles.displayLarge.copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              VerticalSpacing(AppSpacing.height3),
              Text(
                InvitaionsStrings.manageRequestsDesc,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
