import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top nav row: back arrow + "Profile Setup"
        Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.navyBlue,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              AppStrings.profileSetup,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing24),
        // Large centered title and subtitle
        Center(
          child: Column(
            children: [
              Text(
                AppStrings.completeProfile,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing8),
              Text(
                'Help us find the right team for you.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
