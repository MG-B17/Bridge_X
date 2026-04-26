import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class TierProgress extends StatelessWidget {
  final double progress;
  const TierProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress to Gold',
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        VSpace(context.spacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.spacing.radiusXs),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10.w,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF83A0E7)),
          ),
        ),
      ],
    );
  }
}

class TierFooter extends StatelessWidget {
  final String nextTierInfo;
  const TierFooter({super.key, required this.nextTierInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          nextTierInfo,
          style: context.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11.sp,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.flag_outlined,
          color: Colors.white.withValues(alpha: 0.7),
          size: 16.w,
        ),
      ],
    );
  }
}
