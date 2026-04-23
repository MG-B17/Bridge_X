import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/utils/extensions.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '24',
            label: 'TOTAL TASKS',
            valueColor: context.colors.primary,
          ),
        ),
        HSpace(context.spacing.sm),
        Expanded(
          child: _StatCard(
            value: '18',
            label: 'COMPLETED',
            valueColor: Colors.brown[700]!,
          ),
        ),
        HSpace(context.spacing.sm),
        Expanded(
          child: _StatCard(
            value: '04',
            label: 'PROJECTS',
            valueColor: context.colors.primary,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        border: Border.all(
          color: context.colors.textHint.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: context.displayLarge.copyWith(
              color: valueColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontSize: 9.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
