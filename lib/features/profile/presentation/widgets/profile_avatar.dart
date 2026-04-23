import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildAvatar(context),
          _buildBadge(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xs),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.3)),
      ),
      child: CircleAvatar(
        radius: 60.r,
        backgroundColor: context.colors.secondary,
        backgroundImage: const NetworkImage('https://i.pravatar.cc/300?u=ahmed'),
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Positioned(
      bottom: -10.h,
      child: GestureDetector(
        onTap: () => context.push(AppRouteConstant.level),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.md,
            vertical: context.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(context.spacing.radiusPill),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [context.spacing.cardShadow],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.beginner,
                style: context.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.sp,
                ),
              ),
              HSpace(context.spacing.xs),
              Icon(Icons.military_tech_rounded, color: Colors.white, size: 14.w),
            ],
          ),
        ),
      ),
    );
  }
}
