import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.avatarUrl, this.level});

  final String? avatarUrl;
  final String? level;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
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
              child: avatarUrl != null
                  ? Image.network(
                      avatarUrl!,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _fallbackAvatar(context),
                    )
                  : _fallbackAvatar(context),
            ),
          ),
        ),
        Positioned(
          bottom: -5.h,
          right: -10.w,
          child: GestureDetector(
            onTap: () {
              context.goNamed(BridegeXRouteNames.level);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: context.colors.textPrimary,
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
                    level ?? 'Beginner',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: context.colors.surface,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  HorizontalSpacing(4),
                  Icon(
                    Icons.workspace_premium_outlined,
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

  Widget _fallbackAvatar(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.w,
      color: context.colors.indigo.withValues(alpha: 0.2),
      child: Icon(
        Icons.person,
        size: 50.w,
        color: context.colors.indigo,
      ),
    );
  }
}
