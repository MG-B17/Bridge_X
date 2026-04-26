import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import 'status_item_widget.dart';

class MatchingHeader extends StatelessWidget {
  const MatchingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace(context.spacing.sm),
        Text(
          AppStrings.matching,
          textAlign: TextAlign.center,
          style: context.displayLarge.copyWith(
            color: context.colors.primary,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.md),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(
            AppStrings.matchingSubtitle,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(color: context.colors.textSecondary, height: 1.5),
          ),
        ),
      ],
    );
  }
}

class MatchingStatusList extends StatelessWidget {
  const MatchingStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StatusItemWidget(label: AppStrings.skillsVerified, status: StatusType.success),
        StatusItemWidget(label: AppStrings.experienceAnalyzed, status: StatusType.success),
        StatusItemWidget(label: AppStrings.finalizingShortlist, status: StatusType.pending),
      ],
    );
  }
}
