import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_route_constant.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hi, Ahmed 👋',
              style: context.displayLarge.copyWith(
                color: context.colors.textPrimary,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            VSpace(context.spacing.xs),
            Text(
              "Let's build something great today",
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.push(AppRouteConstant.notifications),
          child: Icon(
            Icons.notifications,
            color: context.colors.primary,
            size: 28.w,
          ),
        ),
      ],
    );
  }
}
