import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/impact_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourImpactSection extends StatelessWidget {
  const YourImpactSection({super.key, required this.impacts});

  final List<ImpactEntity> impacts;

  IconData _mapIcon(String icon) => switch (icon) {
        'trending_down' => Icons.trending_down_rounded,
        'trending_up' => Icons.trending_up_rounded,
        'dashboard' => Icons.dashboard_outlined,
        'speed' => Icons.speed_rounded,
        'code' => Icons.code_rounded,
        'bug_report' => Icons.bug_report_outlined,
        'security' => Icons.security_rounded,
        'devices' => Icons.devices_rounded,
        _ => Icons.auto_awesome_outlined,
      };

  @override
  Widget build(BuildContext context) {
    if (impacts.isEmpty) return const SizedBox.shrink();

    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR IMPACT',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.burgundy,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              fontSize: AppSpacing.fontSize12,
            ),
          ),
          VerticalSpacing(AppSpacing.md),
          ...impacts.map((impact) => Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.spacing12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _mapIcon(impact.icon),
                      color: colors.burgundy,
                      size: 18.sp,
                    ),
                    HorizontalSpacing(AppSpacing.sm),
                    Expanded(
                      child: Text(
                        impact.text,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
