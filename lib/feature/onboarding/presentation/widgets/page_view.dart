import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) => SizedBox(
        width: double.infinity,
        height: 500.h,
        child: PageView.builder(
          physics:const NeverScrollableScrollPhysics(),
          controller: provider.pageController,
          itemCount: provider.onboardingContents.length,
          onPageChanged: (index) => provider.onPageChanged(index: index),
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity, height: 300.h, child: SvgPicture.asset(provider.onboardingContents[index].image)),
                  Text(
                    provider.onboardingContents[index].title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  VerticalSpacing(10.h),
                  Text(
                    provider.onboardingContents[index].description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
