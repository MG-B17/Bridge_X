import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectsHeader extends StatelessWidget {
  const ProjectsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.myProjects,
          style: AppTextStyles.displayLarge.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          AppStrings.myProjectsSubtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
