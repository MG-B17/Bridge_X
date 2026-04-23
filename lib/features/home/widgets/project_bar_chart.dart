import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/utils/extensions.dart';

class ProjectBarChart extends StatelessWidget {
  const ProjectBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.xl,
        vertical: context.spacing.xl,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(context, percentage: 0.70, label: 'FinTrack'),
                _buildBar(context, percentage: 0.30, label: 'EcoMarket'),
                _buildBar(context, percentage: 0.50, label: 'Graduation'),
              ],
            ),
          ),
          VSpace(context.spacing.md),
          Text(
            'Based on completed tasks',
            style: context.labelSmall.copyWith(
              color: context.colors.textHint,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, {required double percentage, required String label}) {
    return GestureDetector(
      onTap: () => context.push(AppRouteConstant.workspace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${(percentage * 100).toInt()}%',
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          VSpace(context.spacing.sm),
          Expanded(
            child: Container(
              width: 12.w,
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(context.spacing.xs),
                  ),
                ),
              ),
            ),
          ),
          VSpace(context.spacing.sm),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
