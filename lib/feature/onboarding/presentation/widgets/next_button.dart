import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) => GestureDetector(
        onTap: () => provider.nextPage(context: context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              provider.islastPage ? AppStrings.getStarted : AppStrings.next,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.surface,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.arrow_forward_rounded,
              color: context.colors.surface,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
