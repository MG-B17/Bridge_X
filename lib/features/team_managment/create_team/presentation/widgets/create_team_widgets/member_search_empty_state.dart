import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class MemberSearchEmptyState extends StatelessWidget {
  const MemberSearchEmptyState({super.key, required this.colors});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSpacing.width80,
              height: AppSpacing.width80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.textSecondary.withValues(alpha: 0.08),
              ),
              child: Center(
                child: Icon(
                  Icons.people_outline_rounded,
                  size: AppSpacing.fontSize40,
                  color: colors.textSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.spacing20),
            Text(
              CreateTeamStrings.noUserFound,
              style: AppTextStyles.titleLarge.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            VerticalSpacing(AppSpacing.spacing8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing36),
              child: Text(
                CreateTeamStrings.noUserFoundSubTittle,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.textSecondary,
                  fontSize: AppSpacing.fontSize13,
                  height: AppSpacing.lineHeight1_4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
