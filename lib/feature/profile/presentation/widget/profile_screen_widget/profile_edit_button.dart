import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(BridegeXRouteNames.editProfile);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          color: context.colors.indigo.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
          border: Border.all(
            color: context.colors.divider,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.edit,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.colors.indigo,
                fontWeight: FontWeight.w600,
              ),
            ),
            HorizontalSpacing(4),
            Icon(
              Icons.edit_outlined,
              size: 14.w,
              color: context.colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}
