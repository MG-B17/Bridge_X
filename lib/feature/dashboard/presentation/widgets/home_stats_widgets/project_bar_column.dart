import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class ProjectBarColumn extends StatelessWidget {
  const ProjectBarColumn({
    super.key,
    required this.name,
    required this.percentage,
  });

  final String name;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${(percentage * 100).toInt()}%',
          style: TextStyle(
            color: context.colors.secondary,
            fontWeight: FontWeight.w800,
            fontSize: AppSpacing.fontSize16,
          ),
        ),

        VerticalSpacing(AppSpacing.height8),

        SizedBox(
          height: AppSpacing.barHeight,
          width: AppSpacing.barColumnWidth,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: AppSpacing.barWidth,
                height: AppSpacing.barHeight,
                decoration: BoxDecoration(
                  color: context.appColors.textSecondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radius20),
                ),
              ),

              AnimatedContainer(
                duration: AppSpacing.animationSlow,
                curve: Curves.easeOutCubic,
                width: AppSpacing.barWidth,
                height: AppSpacing.barHeight * percentage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radius20),
                  gradient: AppGradient.barFill,
                  boxShadow: AppShadow.barGlow,
                ),
              ),
            ],
          ),
        ),

        VerticalSpacing(AppSpacing.height10),

        Text(
          name,
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: AppSpacing.fontSize14,
          ),
        ),
      ],
    );
  }
}
