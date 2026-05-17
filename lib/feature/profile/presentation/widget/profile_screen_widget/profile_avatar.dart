import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar background circle
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.indigo.withValues(alpha: 0.15),
            border: Border.all(
              color: context.colors.textHint.withValues(alpha: 0.3),
              width: 4,
            ),
          ),
          child: Center(
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar.jpg', // Replace with actual asset
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: context.colors.indigo.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.person,
                      size: 50.w,
                      color: context.colors.indigo,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // Badge
        Positioned(
          bottom: -5.h,
          right: -10.w,
          child: GestureDetector(
            onTap: (){
              context.goNamed(BridegeXRouteNames.level);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: context.colors.textPrimary, // Dark blue/primary
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                border: Border.all(
                  color: context.colors.surface,
                  width: 2.w,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.beginner,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: context.colors.surface,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  HorizontalSpacing(4),
                  Icon(
                    Icons.workspace_premium_outlined, // Medal icon
                    size: 12.w,
                    color: context.colors.surface,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
