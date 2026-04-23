import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/utils/extensions.dart';

class HomeTipBanner extends StatelessWidget {
  const HomeTipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb,
            color: context.colors.primary,
            size: 20.w,
          ),
          HSpace(context.spacing.sm),
          Expanded(
            child: Text(
              'Tip: Join a team to start building real projects',
              style: context.bodyMedium.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
