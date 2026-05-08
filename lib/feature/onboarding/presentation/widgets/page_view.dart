import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:bridge_x/feature/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) => SizedBox(
        width: double.infinity,
        height: 500.h,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: provider.pageController,
          itemCount: provider.onboardingContents.length,
          onPageChanged: (index) => provider.onPageChanged(index: index),
          itemBuilder: (context, index) => OnboardingPage(
            content: provider.onboardingContents[index],
          ),
        ),
      ),
    );
  }
}




