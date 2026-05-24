import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class GithubLinkSection extends StatelessWidget {
  const GithubLinkSection({super.key, required this.githubLink});

  final String githubLink;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.githubRepositoryLink,
          style: AppTextStyles.titleMedium.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
            vertical: AppSpacing.spacing14,
          ),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(color: colors.divider.withValues(alpha: 0.4)),
          ),
          child: Text(
            githubLink,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
