import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class MemberAgreementText extends StatelessWidget {
  const MemberAgreementText({super.key, required this.colors});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(AppSpacing.spacing12),
        Center(
          child: Text.rich(
            TextSpan(
              text: CreateTeamStrings.byInvitingAgree,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.8),
              ),
              children: [
                TextSpan(
                  text: CreateTeamStrings.teamTerms,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.primary,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(text: CreateTeamStrings.period),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
