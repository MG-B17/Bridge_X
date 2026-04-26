import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class NoTeamsHeader extends StatelessWidget {
  const NoTeamsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.noTeamsFound,
          textAlign: TextAlign.center,
          style: context.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.md),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.lg),
          child: Text(
            AppStrings.noTeamsFoundSubtitle,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class NoTeamsActions extends StatelessWidget {
  const NoTeamsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: AppStrings.retryMatching,
          onPressed: () => context.go(AppRouteConstant.matching),
          trailing: Icon(Icons.explore_outlined, color: Colors.white, size: 20.w),
        ),
        VSpace(context.spacing.md),
        AppButton(
          label: AppStrings.createYourOwnTeam,
          isSecondary: true,
          onPressed: () => context.push(AppRouteConstant.createTeam),
        ),
      ],
    );
  }
}
