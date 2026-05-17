import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skill scan progress bar + verification step list.
class SkillScanSection extends StatelessWidget {
  const SkillScanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── CORE SKILL SCAN label + Matching... ──
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
              AppStrings.matchingDot,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.sm),

        // ── Scan progress bar ──
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          child: SizedBox(
            height: 6.h,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: colors.primaryLight.withValues(alpha: 0.5),
                ),
                FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.teal, colors.primary],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.xl),

        // ── Verification steps ──
        _VerificationStep(
          label: AppStrings.skillsVerified,
          isCompleted: true,
        ),
        VerticalSpacing(AppSpacing.md),
        _VerificationStep(
          label: AppStrings.experienceAnalyzed,
          isCompleted: true,
        ),
        VerticalSpacing(AppSpacing.md),
        _VerificationStep(
          label: AppStrings.finalizingShortlist,
          isCompleted: false,
        ),
      ],
    );
  }
}

// ── Single verification step row ────────────────────────────────────────────
class _VerificationStep extends StatelessWidget {
  const _VerificationStep({
    required this.label,
    required this.isCompleted,
  });

  final String label;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: isCompleted
                ? colors.success
                : colors.divider.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? Icon(Icons.check, color: Colors.white, size: 14.sp)
              : null,
        ),
        HorizontalSpacing(AppSpacing.md),
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
    );
  }
}
