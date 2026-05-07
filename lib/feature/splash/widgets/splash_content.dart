import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';

class SplashContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const SplashContent({
    super.key,
    required this.fadeAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo
            SvgPicture.asset(
              'assets/svgs/bridge_x_app_icon.svg',
              width: 120.w,
              height: 120.h,
            ),
            VerticalSpacing(AppSpacing.xl),

            // App Name
            SvgPicture.asset(
              'assets/svgs/Bridge_x_name_icon.svg',
              width: 150.w,
              height: 60.h,
            ),
            VerticalSpacing(AppSpacing.xxl),
            
          ],
        ),
      ),
    );
  }
}
