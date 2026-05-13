import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamTypeSelector extends StatelessWidget {
  const TeamTypeSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.teamType,
          style: AppTextStyles.titleLarge.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        _TeamTypeCard(
          icon: Icons.lock_rounded,
          title: AppStrings.private,
          subtitle: AppStrings.privateDesc,
          isSelected: selectedIndex == 0,
          onTap: () => onChanged(0),
        ),
        VerticalSpacing(AppSpacing.sm),
        _TeamTypeCard(
          icon: Icons.public_rounded,
          title: AppStrings.public,
          subtitle: AppStrings.publicDesc,
          isSelected: selectedIndex == 1,
          onTap: () => onChanged(1),
        ),
      ],
    );
  }
}

// ── Single team type card ───────────────────────────────────────────────────
class _TeamTypeCard extends StatelessWidget {
  const _TeamTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryLight.withValues(alpha: 0.35)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.divider,
            width: isSelected ? 1.8 : 1.2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primary.withValues(alpha: 0.12)
                          : colors.background,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusXs),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? colors.primary : colors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Checkmark ──
            if (isSelected)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
