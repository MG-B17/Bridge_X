import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectBarsCard extends StatelessWidget {
  const ProjectBarsCard({super.key});

  static const _projects = [
    _ProjectData(name: 'FinTrack', percentage: 0.90),
    _ProjectData(name: 'Graduation', percentage: 0.70),
    _ProjectData(name: 'EcoMarket', percentage: 0.40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.surface,
            context.colors.teal.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.3),
        ),
        boxShadow: AppSpacing.subtleShadow,
      ),
      child: Column(
        children: [
          // ── Bar chart area ──
          SizedBox(
            height: 160.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _projects.map((project) {
                return _BarColumn(
                  name: project.name,
                  percentage: project.percentage,
                  barColor: _barColor(context, project.percentage),
                  trackColor: context.colors.divider.withValues(alpha: 0.25),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 12.h),
          // ── Footer ──
          Text(
            AppStrings.basedOnCompleted,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Color _barColor(BuildContext context, double pct) {
    if (pct >= 0.8) return context.colors.primary;
    if (pct >= 0.6) return context.colors.teal;
    return context.colors.textSecondary;
  }
}

// ── Data class for projects ─────────────────────────────────────────────────
class _ProjectData {
  const _ProjectData({required this.name, required this.percentage});
  final String name;
  final double percentage;
}

// ── Single bar column ───────────────────────────────────────────────────────
class _BarColumn extends StatelessWidget {
  const _BarColumn({
    required this.name,
    required this.percentage,
    required this.barColor,
    required this.trackColor,
  });

  final String name;
  final double percentage;
  final Color barColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    final barHeight = 120.h;

    return SizedBox(
      width: 56.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ── Percentage label ──
          Text(
            '${(percentage * 100).toInt()}%',
            style: AppTextStyles.labelSmall.copyWith(
              color: barColor,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 6.h),
          // ── Bar track ──
          SizedBox(
            height: barHeight,
            width: 20.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Track background
                Container(
                  width: 20.w,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                // Filled bar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  width: 20.w,
                  height: barHeight * percentage,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        barColor,
                        barColor.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          // ── Project name ──
          Text(
            name,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
