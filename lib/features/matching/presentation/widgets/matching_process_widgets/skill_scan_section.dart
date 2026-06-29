import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class SkillScanSection extends StatelessWidget {
  final double progress;

  const SkillScanSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.coreSkillScan,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radius30),
          child: SizedBox(
            height: AppSpacing.height6,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: colors.primaryLight.withValues(alpha: 0.5),
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.teal, colors.primary],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radius30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.spacing24),
        _VerificationStep(
          label: AppStrings.skillsVerified,
          isCompleted: progress >= 0.15,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        _VerificationStep(
          label: AppStrings.experienceAnalyzed,
          isCompleted: progress >= 0.50,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        _VerificationStep(
          label: AppStrings.finalizingShortlist,
          isCompleted: progress >= 0.85,
        ),
      ],
    );
  }
}

class _VerificationStep extends StatelessWidget {
  final String label;
  final bool isCompleted;

  const _VerificationStep({
    required this.label,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: EdgeInsets.all(AppSpacing.width12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius5),
        border: Border.all(color: context.colors.divider.withValues(alpha: .5))
      ),
      child: Row(
        children: [
          Container(
            width: AppSpacing.spacing24,
            height: AppSpacing.spacing24,
            decoration: BoxDecoration(
              color: isCompleted
                  ? colors.success
                  : colors.divider.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: isCompleted
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: AppSpacing.fontSize14,
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primary,
                    ),
                  ),
          ),
          HorizontalSpacing(AppSpacing.spacing16),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isCompleted ? colors.textPrimary : colors.textHint,
                fontWeight: isCompleted ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
