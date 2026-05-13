import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamActionButtons extends StatelessWidget {
  const TeamActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── Join Team (filled) ──
        Expanded(
          child: _GradientActionButton(
            label: AppStrings.joinTeam,
            icon: Icons.group_add_outlined,
            onTap: () {
              // TODO: Navigate to join team
            },
          ),
        ),
        HorizontalSpacing(AppSpacing.sm),
        // ── Create Team (outlined) ──
        Expanded(
          child: _OutlinedActionButton(
            label: AppStrings.createTeam,
            icon: Icons.add_circle_outline,
            onTap: () {
              // TODO: Navigate to create team
            },
          ),
        ),
      ],
    );
  }
}

// ── Gradient-filled button ──────────────────────────────────────────────────
class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          gradient: AppColorScheme.gradient,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill + 4.r),
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Outlined button ─────────────────────────────────────────────────────────
class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill + 4.r),
          border: Border.all(
            color: context.colors.divider,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: context.colors.textPrimary, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
