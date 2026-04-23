import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import 'stat_card_widget.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatCardWidget(
            value: '12',
            label: AppStrings.completedTasksUpper,
            onTap: () => context.push(AppRouteConstant.level),
          ),
          StatCardWidget(
            value: '3',
            label: AppStrings.teamsUpper,
            onTap: () => context.push(AppRouteConstant.teams),
          ),
          StatCardWidget(
            value: '10',
            label: AppStrings.activeTasksUpper,
            onTap: () => context.push(AppRouteConstant.workspace),
          ),
        ],
      ),
    );
  }
}
