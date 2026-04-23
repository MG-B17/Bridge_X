import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class RoadmapIndicator extends StatelessWidget {
  final bool isCompleted;
  final bool isLocked;
  final bool showLine;

  const RoadmapIndicator({
    super.key,
    required this.isCompleted,
    required this.isLocked,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isCompleted ? context.colors.primary : context.colors.divider.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16.w)
                : Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: isLocked ? Colors.transparent : context.colors.textHint.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ),
        if (showLine)
          Expanded(
            child: Container(
              width: 2.w,
              color: context.colors.divider.withValues(alpha: 0.3),
            ),
          ),
      ],
    );
  }
}

class RoadmapPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isLocked;

  const RoadmapPill({
    super.key,
    required this.label,
    required this.isActive,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md,
        vertical: context.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? context.colors.primary
            : context.colors.divider.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: isActive
              ? Colors.white
              : isLocked
                  ? context.colors.textHint.withValues(alpha: 0.5)
                  : context.colors.textPrimary.withValues(alpha: 0.6),
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    );
  }
}
