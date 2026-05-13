import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows the "Select Category" bottom sheet and returns the selected categories.
Future<List<String>?> showSelectCategorySheet(BuildContext context) {
  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _SelectCategorySheet(),
  );
}

class _SelectCategorySheet extends StatefulWidget {
  const _SelectCategorySheet();

  @override
  State<_SelectCategorySheet> createState() => _SelectCategorySheetState();
}

class _SelectCategorySheetState extends State<_SelectCategorySheet> {
  final Set<int> _selected = {0, 2}; // Development, Marketing pre-selected

  static const _categories = [
    AppStrings.development,
    AppStrings.design,
    AppStrings.marketing,
    AppStrings.research,
    AppStrings.aiData,
    AppStrings.business,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusPill),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl, 12.h, AppSpacing.xl, AppSpacing.xl,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag handle ──
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.lg),

            // ── Title row ──
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.selectCategory,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: colors.textSecondary,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.categorySheetSubtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.textSecondary,
              ),
            ),
            VerticalSpacing(AppSpacing.xl),

            // ── Category chips ──
            Wrap(
              spacing: 10.w,
              runSpacing: 12.h,
              children: List.generate(_categories.length, (i) {
                final isSelected = _selected.contains(i);
                return _CategoryChip(
                  label: _categories[i],
                  isSelected: isSelected,
                  onTap: () => setState(() {
                    isSelected ? _selected.remove(i) : _selected.add(i);
                  }),
                );
              }),
            ),
            VerticalSpacing(AppSpacing.xl),

            // ── Info banner ──
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.primaryLight.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: colors.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: colors.error,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      AppStrings.multiCategoryHint,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(AppSpacing.xl),

            // ── Start Matching button ──
            BridgeXButton(
              text: AppStrings.startMatching,
              onTap: _selected.isNotEmpty
                  ? () => Navigator.pop(
                        context,
                        _selected.map((i) => _categories[i]).toList(),
                      )
                  : null,
            ),
            VerticalSpacing(AppSpacing.md),

            // ── Cancel ──
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    AppStrings.cancel,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Single category chip ────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryLight.withValues(alpha: 0.3)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill + 4.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.divider,
            width: isSelected ? 1.6 : 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(Icons.check, color: colors.primary, size: 16.sp),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: isSelected ? colors.primary : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
