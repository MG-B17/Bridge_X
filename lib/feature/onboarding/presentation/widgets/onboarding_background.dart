import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.h,
          left: 0.w,
          child: SvgPicture.asset(
            'assets/svgs/onboarding_background2.svg',
            width: 256.w,
            height: 200.h,
          ),
        ),
        Positioned(
          bottom: 0.h,
          right: 0.w,
          child: SvgPicture.asset(
            'assets/svgs/onboarding_background_button.svg',
            width: 280.w,
            height: 200.h,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
