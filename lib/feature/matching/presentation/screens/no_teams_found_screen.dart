import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoTeamsFoundScreen extends StatelessWidget {
  const NoTeamsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Column(
            children: [
              // ── Back button ──
              const Align(
                alignment: Alignment.centerLeft,
                child: BridgeXBackButton(),
              ),

              // ── Spacer to center content ──
              const Spacer(flex: 2),

              // ── Illustration placeholder ──
              Container(
                width: 220.w,
                height: 140.h,
                decoration: BoxDecoration(
                  color: colors.primaryLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
                ),
                child: Center(
                  child: Container(
                    width: 160.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                      boxShadow: AppSpacing.subtleShadow,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background circles
                        Positioned(
                          left: 30.w,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor:
                                colors.divider.withValues(alpha: 0.4),
                          ),
                        ),
                        Positioned(
                          right: 30.w,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor:
                                colors.divider.withValues(alpha: 0.4),
                          ),
                        ),
                        // Search icon
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            gradient: AppColorScheme.matching,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusXs),
                          ),
                          child: Icon(
                            Icons.manage_search_rounded,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        // Orange dot
                        Positioned(
                          top: 20.h,
                          right: 40.w,
                          child: CircleAvatar(
                            radius: 5.r,
                            backgroundColor: colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              VerticalSpacing(AppSpacing.xxl),

              // ── Title ──
              Text(
                AppStrings.noTeamsFound,
                style: AppTextStyles.displayLarge.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  AppStrings.noTeamsFoundSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 1),

              // ── Retry Matching (filled) ──
              GestureDetector(
                onTap: () {
                  // TODO: Retry matching
                },
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColorScheme.gradient,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.retryMatching,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.refresh_rounded,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              VerticalSpacing(AppSpacing.md),

              // ── Create Your Own Team (outlined) ──
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to create team
                },
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: colors.divider,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.createYourOwnTeam,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalSpacing(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
