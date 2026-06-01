import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateTaskHeader extends StatelessWidget {
  const CreateTaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16, vertical: AppSpacing.spacing12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.close, color: colors.textPrimary, size: 24.sp),
          ),
          const Spacer(),
          Text(AppStrings.createTask, style: AppTextStyles.headlineSmall.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w700)),
          const Spacer(),
          SizedBox(width: 24.sp),
        ],
      ),
    );
  }
}
