import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/dynamic_insight_card.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_progress_ring.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/skill_scan_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MatchingProcessScreen extends StatelessWidget {
  const MatchingProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Column(
            children: [
              // ── Back button ──
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: colors.surface,
                      shape: BoxShape.circle,
                      boxShadow: AppSpacing.subtleShadow,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: colors.textPrimary,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              VerticalSpacing(AppSpacing.xl),

              // ── Title ──
              Text(
                AppStrings.matchingTitle,
                style: AppTextStyles.displayLarge.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.matchingSubtitleFull,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(AppSpacing.xxl),

              // ── Progress ring ──
              const MatchingProgressRing(
                percentage: 45,
                label: AppStrings.optimizing,
              ),
              VerticalSpacing(AppSpacing.xxl),

              // ── Dynamic insight card ──
              const DynamicInsightCard(),
              VerticalSpacing(AppSpacing.xl),

              // ── Skill scan ──
              const SkillScanSection(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
