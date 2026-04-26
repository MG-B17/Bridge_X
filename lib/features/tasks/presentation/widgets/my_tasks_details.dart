import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class MyTasksEmptyHeader extends StatelessWidget {
  const MyTasksEmptyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.allCaughtUp,
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
            '${AppStrings.noActiveTasks}\n${AppStrings.takeBreak}',
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

class MyTasksEmptyActions extends StatelessWidget {
  const MyTasksEmptyActions({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: AppStrings.exploreProjects,
      onPressed: () => context.push(AppRouteConstant.projects),
      trailing: Icon(Icons.arrow_forward, color: Colors.white, size: 20.w),
    );
  }
}
