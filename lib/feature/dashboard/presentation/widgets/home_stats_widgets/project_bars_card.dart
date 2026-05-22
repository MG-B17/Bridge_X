import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/project_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'project_bar_column.dart';

class ProjectBarsCard extends StatelessWidget {
  const ProjectBarsCard({super.key, this.projects});

  final List<ProjectDetailEntity>? projects;

  static const double _barsAreaHeight = 175;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpacing.height250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius28),
        color: context.appColors.primary.withValues(alpha: .02),
        boxShadow: AppShadow.chartCard,
        border: Border.all(
          width: AppSpacing.width2,
          color: context.appColors.primary.withValues(alpha: .25),
        ),
      ),
      child: Stack(
        children: [
          BridgeXBackgroundGears(),
          Padding(
            padding:EdgeInsets.all(AppSpacing.height14),
            child: Column(
              children: [
                SizedBox(
                  height: _barsAreaHeight.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: projects != null
                        ? projects!.take(3).map((p) => ProjectBarColumn(
                              name: p.projectTitle,
                              percentage: p.completionPercentage / 100,
                            )).toList()
                        : List.generate(
                            3,
                            (index) => const ProjectBarColumn(
                              name: '         ',
                              percentage: 0.5,
                            ),
                          ),
                  ),
                ),
            
                VerticalSpacing(AppSpacing.height12),
            
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
          ),
        ],
      ),
    );
  }
}
