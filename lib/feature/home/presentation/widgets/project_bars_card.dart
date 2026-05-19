import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'project_bar_column.dart';

class ProjectBarsCard extends StatelessWidget {
  const ProjectBarsCard({super.key});

  static const double _barsAreaHeight = 170;

  static const _projects = [
    _ProjectData(name: 'FinTrack',   percentage: 0.90),
    _ProjectData(name: 'Graduation', percentage: 0.70),
    _ProjectData(name: 'EcoMarket',  percentage: 0.40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.spacing24,
        AppSpacing.spacing24,
        AppSpacing.spacing24,
        AppSpacing.height18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius28),
        gradient: AppGradient.projectBarsCard,
        border: Border.all(
          color: AppColors.cardBorderBlue.withValues(alpha: 0.25),
        ),
        boxShadow: AppShadow.projectBarsCard,
      ),
      child: Stack(
        children: [
          // ── Floating glow particles ──
          ...List.generate(
            10,
            (index) => Positioned(
              top:  (index * 24).toDouble(),
              left: (index * 31).toDouble(),
              child: Container(
                width:  AppSpacing.spacing6,
                height: AppSpacing.spacing6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.particleCyan.withValues(alpha: 0.55),
                  boxShadow: AppShadow.particleGlow(AppColors.particleCyan),
                ),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: _barsAreaHeight.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _projects.map((p) => ProjectBarColumn(
                    name: p.name,
                    percentage: p.percentage,
                  )).toList(),
                ),
              ),

              VerticalSpacing(AppSpacing.height18),

              Text(
                AppStrings.basedOnCompleted,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                  fontSize: AppSpacing.fontSize12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectData {
  const _ProjectData({required this.name, required this.percentage});
  final String name;
  final double percentage;
}
