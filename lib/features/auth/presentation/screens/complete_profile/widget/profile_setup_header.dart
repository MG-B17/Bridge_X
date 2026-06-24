import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: AppSpacing.spacing12),
            Text(
              AppStrings.profileSetup,
              style: GoogleFonts.inter(
                fontSize: AppSpacing.fontSize16,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing24),
        Center(
          child: Column(
            children: [
              Text(
                AppStrings.completeProfile,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: AppSpacing.fontSize30,
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing8),
              Text(
                AuthStrings.subtitleFindTeam,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: AppSpacing.fontSize14,
                  fontWeight: FontWeight.w400,
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
