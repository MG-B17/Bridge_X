import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tier_card_details.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class TierCardWidget extends StatelessWidget {
  final String currentTier;
  final String nextTierInfo;
  final double progress;

  const TierCardWidget({
    super.key,
    required this.currentTier,
    required this.nextTierInfo,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10.w,
            top: -10.w,
            child: Icon(
              Icons.stars_rounded,
              size: 100.w,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TierHeader(currentTier: currentTier),
              VSpace(context.spacing.xl),
              TierProgress(progress: progress),
              VSpace(context.spacing.lg),
              TierFooter(nextTierInfo: nextTierInfo),
            ],
          ),
        ],
      ),
    );
  }
}

class _TierHeader extends StatelessWidget {
  final String currentTier;
  const _TierHeader({required this.currentTier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CURRENT TIER',
          style: context.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        VSpace(context.spacing.xs),
        Text(
          currentTier,
          style: context.displayLarge.copyWith(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
