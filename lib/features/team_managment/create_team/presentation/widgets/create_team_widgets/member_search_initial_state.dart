import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class MemberSearchInitialState extends StatelessWidget {
  const MemberSearchInitialState({super.key, required this.colors});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSpacing.width120,
              height: AppSpacing.width120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.primary.withValues(alpha: 0.15),
                    colors.primary.withValues(alpha: 0.0),
                  ],
                  radius: 0.8,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.people_alt_rounded,
                  size: AppSpacing.fontSize64,
                  color: colors.primary.withValues(alpha: 0.85),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.spacing24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing32),
              child: Text(
                CreateTeamStrings.findColleaguesDisplay,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textSecondary,
                  height: AppSpacing.lineHeight1_5,
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
