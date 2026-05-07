import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../controller/onboarding_provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) => InkWell(
        onTap: () => provider.nextPage(context: context),
        child: Row(
          spacing: 2.w,
          children: [
            Text(
              provider.islastPage ? AppStrings.getStarted : AppStrings.next,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(Icons.arrow_forward, color: Colors.white, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
