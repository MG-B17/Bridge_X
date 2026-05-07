import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
        Positioned(
          bottom: 80.h,
          right: 8.w,
          child: TextButton(
            onPressed: ()=> context.read<OnboardingProvider>().nextPage(context:context),
            child: Row(
              spacing: 2.w,
              children: [
                Text(
                  AppStrings.next,
                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Icon( Icons.arrow_forward, color: Colors.white, size: 18.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
